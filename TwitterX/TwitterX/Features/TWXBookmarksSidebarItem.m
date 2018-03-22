// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <AppKit/AppKit.h>
#import <objc/runtime.h>
#import "TWXBookmarksSidebarItem.h"
#import "TWXRuntime.h"
#import "NSView+TWX.h"

NS_ASSUME_NONNULL_BEGIN

static void *TWXBookmarksSidebarItemBookmarksButtonRefKey = &TWXBookmarksSidebarItemBookmarksButtonRefKey;

@implementation TWXBookmarksSidebarItem

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"viewDidLoad" ofClass:@"TMSidebarItemViewController"];
    [TWXRuntime exchangeInstanceMethod:@"toggleButtonStates:" ofClass:@"TMSidebarItemViewController"];
}

@end

@implementation NSObject (TWX)

- (void)TMSidebarItemViewController_viewDidLoad {
    [self TMSidebarItemViewController_viewDidLoad];
    
    NSButton *const directMessagesButton = [self performSelector:@selector(directMessagesButton)];
    NSButton *const profileButton = [self performSelector:@selector(profileButton)];
    NSView *const containerView = [profileButton superview];
    
    for (NSLayoutConstraint *const constraint in containerView.constraints) {
        if (constraint.secondItem == directMessagesButton && constraint.secondAttribute == NSLayoutAttributeBottom) {
            [containerView removeConstraint:constraint];
            break;
        }
    }
    
    NSLayoutConstraint *const heightConstraint = [self performSelector:@selector(heightConstraint)];
    heightConstraint.constant += 43.f;
    
    NSLayoutConstraint *const containerHeightConstraint = [self performSelector:@selector(buttonContainerHeightConstraint)];
    containerHeightConstraint.constant += 43.f;
    
    [self performSelector:@selector(setHeightConstraint:) withObject:nil];
    
    NSButton *const bookmarksButton = [self twx_bookmarksButton];
    [bookmarksButton performSelector:@selector(setColorsForStates:) withObject:[profileButton performSelector:@selector(colorsForStates)]];
    [containerView addSubview:bookmarksButton];
    [bookmarksButton anchorToAttribute:NSLayoutAttributeLeading ofView:containerView fromAttribute:NSLayoutAttributeLeading];
    [bookmarksButton anchorToAttribute:NSLayoutAttributeTrailing ofView:containerView fromAttribute:NSLayoutAttributeTrailing];
    [bookmarksButton anchorToAttribute:NSLayoutAttributeBottom ofView:directMessagesButton fromAttribute:NSLayoutAttributeTop constant:5.0f];
    [profileButton anchorToAttribute:NSLayoutAttributeBottom ofView:bookmarksButton fromAttribute:NSLayoutAttributeTop constant: 5.0f];
}

- (void)TMSidebarItemViewController_toggleButtonStates:(NSInteger)states {
    [self TMSidebarItemViewController_toggleButtonStates:states];
    [[self twx_bookmarksButton] setState:NSControlStateValueOff];
}

#pragma mark - Convenience

- (NSButton *)twx_bookmarksButton {
    NSButton *__nullable const existingButton = objc_getAssociatedObject(self, TWXBookmarksSidebarItemBookmarksButtonRefKey);
    if (existingButton) {
        return existingButton;
    }
    
    NSButton *const newButton = [[[@"TMSidebarButton" twx_class] alloc] init];
    newButton.translatesAutoresizingMaskIntoConstraints = NO;
    [newButton performSelector:@selector(commonInit)];
    [newButton performSelector:@selector(setBaseImageName:) withObject:@"bookmarks"];
    [newButton setTarget:self];
    [newButton setAction:@selector(twx_switchToBookmarks:)];
    objc_setAssociatedObject(self, TWXBookmarksSidebarItemBookmarksButtonRefKey, newButton, OBJC_ASSOCIATION_RETAIN);
    return newButton;
}

- (void)twx_switchToBookmarks:(NSButton *)sender {
    NSArray *buttons = @[
         [self performSelector:@selector(homeButton)],
         [self performSelector:@selector(momentsButton)],
         [self performSelector:@selector(notificationsButton)],
         [self performSelector:@selector(directMessagesButton)],
         [self performSelector:@selector(listsButton)],
         [self performSelector:@selector(profileButton)],
         [self performSelector:@selector(searchButton)]
    ];
    
    [[self twx_bookmarksButton] setState:NSControlStateValueOn];
    [buttons enumerateObjectsUsingBlock:^(NSButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setState:NSControlStateValueOff];
    }];
}

@end

NS_ASSUME_NONNULL_END
