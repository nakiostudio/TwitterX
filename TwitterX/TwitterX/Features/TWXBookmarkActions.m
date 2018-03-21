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
#import "TWXBookmarkActions.h"
#import "TWXRuntime.h"
#import "TWXAPI+Bookmarks.h"

NS_ASSUME_NONNULL_BEGIN

static void *TwitterAPIRefKey = &TwitterAPIRefKey;

@implementation TWXBookmarkActions

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"_addMenuItemsForStatus:toMenu:" ofClass:@"TMBaseViewController"];
}

@end

@implementation NSObject (TWX)

- (void)TMBaseViewController__addMenuItemsForStatus:(id)status toMenu:(NSMenu *)menu {
    NSParameterAssert(status && menu);
    
    if (![self isKindOfClass:[@"TMBaseViewController" twx_class]]) {
        [self TMBaseViewController__addMenuItemsForStatus:status toMenu:menu];
        return;
    }

    __block NSInteger indexToInsert = 0;
    [menu.itemArray enumerateObjectsUsingBlock:^(NSMenuItem *_Nonnull item, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([item.title isEqualToString:@""]) {
            indexToInsert = idx;
            *stop = YES;
        }
    }];
    
    NSMenuItem *const addToBookmarksMenuItem = [[NSMenuItem alloc] initWithTitle:@"Add to Bookmarks..." action:@selector(twx_didTapAddToBookmarkMenuItem:) keyEquivalent:@"M"];
    addToBookmarksMenuItem.target = self;
    addToBookmarksMenuItem.representedObject = status;
    [menu insertItem:addToBookmarksMenuItem atIndex:indexToInsert];
}

- (void)twx_didTapAddToBookmarkMenuItem:(NSMenuItem *)menuItem {
    NSParameterAssert(menuItem.representedObject);
    
    TWXAPI *const api = [self twx_api];
    id const status = menuItem.representedObject;
    NSString *__nullable const statusID = [status performSelector:@selector(statusID)];
    if (statusID) {
        [api addBookmarkForTweetWithIdentifier:statusID];
    }
}

- (TWXAPI *)twx_api {
    TWXAPI *__nullable const existingAPI = objc_getAssociatedObject(self, TwitterAPIRefKey);
    if (existingAPI) {
        return existingAPI;
    }
    
    TWXAPI *const newAPI = [[TWXAPI alloc] initWithTwitterAccount:[self performSelector:@selector(account)]];
    objc_setAssociatedObject(self, TwitterAPIRefKey, newAPI, OBJC_ASSOCIATION_RETAIN);
    return newAPI;
}

@end

NS_ASSUME_NONNULL_END
