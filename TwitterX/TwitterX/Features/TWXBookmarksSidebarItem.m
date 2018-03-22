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
    [TWXRuntime exchangeInstanceMethod:@"themeChanged:" ofClass:@"TMSidebarItemViewController"];
    [TWXRuntime exchangeInstanceMethod:@"toggleButtonStates:" ofClass:@"TMSidebarItemViewController"];
    [TWXRuntime exchangeInstanceMethod:@"jumpToAccount:item:animated:" ofClass:@"TMRootViewController"];
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
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(twx_didReceiveAddedToBookmarkNotification:)
     name:@"com.twitter.mac.TMSidebarItemViewControllerBookmarkNotification"
     object:nil];
}

- (void)TMSidebarItemViewController_themeChanged:(id)theme {
    if (![self isKindOfClass:[@"TMSidebarItemViewController" twx_class]]) {
        [self TMSidebarItemViewController_themeChanged:theme];
        return;
    }
    
    [self TMSidebarItemViewController_themeChanged:theme];
    
    NSButton *const directMessagesButton = [self performSelector:@selector(directMessagesButton)];
    NSButton *const bookmarksButton = [self twx_bookmarksButton];
    [bookmarksButton performSelector:@selector(setColorsForStates:) withObject:[directMessagesButton performSelector:@selector(colorsForStates)]];
}

- (void)TMSidebarItemViewController_toggleButtonStates:(NSInteger)states {
    [self TMSidebarItemViewController_toggleButtonStates:states];
    [[self twx_bookmarksButton] setState:NSControlStateValueOff];
}

- (void)TMRootViewController_jumpToAccount:(id)account item:(NSInteger)item animated:(BOOL)animated {
    if (![self isKindOfClass:[@"TMRootViewController" twx_class]] || item != 1000) {
        return [self TMRootViewController_jumpToAccount:account item:item animated:animated];
    }
    
    NSInteger const currentItem = (NSInteger)[self performSelector:@selector(currentItem)];
    if (currentItem == item) {
        return;
    }
    
    NSViewController *const rootViewController = (NSViewController *)self;
    id const appDelegate = [NSApp delegate];
    [appDelegate performSelector:@selector(setSelectedAccount:) withObject:account];
    
    NSViewController *bookmarksTimelineController = [[[@"TWMHomeTimelineController" twx_class] alloc] init];
    [bookmarksTimelineController performSelector:@selector(setAccount:) withObject:account];
    [bookmarksTimelineController performSelector:@selector(setTitle:) withObject:@"Bookmarks"];
    
    NSViewController *const navigationController = [rootViewController performSelector:@selector(navigationController)];
    [navigationController twx_performSelector:@selector(setRootViewController:animated:) withObject:bookmarksTimelineController value:animated];
    
    [rootViewController.view.window makeFirstResponder:bookmarksTimelineController.view];
    [rootViewController performSelector:@selector(setCurrentContentController:) withObject:bookmarksTimelineController];
    [rootViewController twx_performSelector:@selector(setCurrentItem:) value:item];
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
    [buttons enumerateObjectsUsingBlock:^(NSButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [button setState:NSControlStateValueOff];
    }];
    
    NSButton *const bookmarksButton = [self twx_bookmarksButton];
    [bookmarksButton setState:NSControlStateValueOn];
    [bookmarksButton twx_performSelector:@selector(setUnreadItems:) value:0];
    
    NSInteger const bookmarksIndex = 1000;
    NSViewController *__nullable const parentViewController = ((NSViewController *)self).parentViewController;
    id const account = [self performSelector:@selector(account)];
    [parentViewController twx_performSelector:@selector(_internalJumpToAccount:item:) withObject:account value:bookmarksIndex];
}

- (void)twx_didReceiveAddedToBookmarkNotification:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSButton *const bookmarksButton = [self twx_bookmarksButton];
        if (bookmarksButton.state == NSControlStateValueOff) {
            [bookmarksButton twx_performSelector:@selector(setUnreadItems:) value:1];
        }
    });
}

@end

NS_ASSUME_NONNULL_END
