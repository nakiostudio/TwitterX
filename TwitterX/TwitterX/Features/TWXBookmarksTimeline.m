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
#import "TWXBookmarksTimeline.h"
#import "TWXRuntime.h"
#import "TWXAPI+Bookmarks.h"

NS_ASSUME_NONNULL_BEGIN

static void *TWXBookmarksTimelineAPIRefKey = &TWXBookmarksTimelineAPIRefKey;
static void *TWXBookmarksTimelineStatusesRefKey = &TWXBookmarksTimelineStatusesRefKey;
static void *TWXBookmarksTimelineIsBookmarksScreenRefKey = &TWXBookmarksTimelineIsBookmarksScreenRefKey;

@implementation TWXBookmarksTimeline

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"viewDidLoad" ofClass:@"TWMHomeTimelineController"];
    [TWXRuntime exchangeInstanceMethod:@"viewDidAppear" ofClass:@"TWMHomeTimelineController"];
    [TWXRuntime exchangeInstanceMethod:@"viewWillDisappear" ofClass:@"TWMHomeTimelineController"];
    [TWXRuntime exchangeInstanceMethod:@"numberOfStatusCells" ofClass:@"TWMHomeTimelineController"];
    [TWXRuntime exchangeInstanceMethod:@"numberOfRowsInTableView:" ofClass:@"TWMHomeTimelineController"];
    [TWXRuntime exchangeInstanceMethod:@"statusForRow:" ofClass:@"TWMHomeTimelineController"];
}

@end

@implementation NSObject (TWX)

- (void)TWMHomeTimelineController_viewDidLoad {
    if (![self isKindOfClass:[@"TWMHomeTimelineController" twx_class]] || ![self twx_isBookmarksScreen]) {
        [self TWMHomeTimelineController_viewDidLoad];
        return;
    }
    
    [self TWMHomeTimelineController_viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSelector:@selector(setTitle:) withObject:@"Bookmarks"];
    
    __weak typeof(self) weakSelf = self;
    [[self twx_api] fetchBookmarksWithCompletion:^(NSArray *_Nonnull statuses) {
        dispatch_async(dispatch_get_main_queue(), ^{
            objc_setAssociatedObject(weakSelf, TWXBookmarksTimelineStatusesRefKey, statuses, OBJC_ASSOCIATION_COPY);
            NSTableView *const tableView = [weakSelf performSelector:@selector(tableView)];
            [tableView reloadData];
            [weakSelf performSelector:@selector(showTableView)];
        });
    }];
}

- (void)TWMHomeTimelineController_viewDidAppear {
    if (![self isKindOfClass:[@"TWMHomeTimelineController" twx_class]] || ![self twx_isBookmarksScreen]) {
        [self TWMHomeTimelineController_viewDidAppear];
        return;
    }
    
    NSTableView *const tableView = [self performSelector:@selector(tableView)];
    tableView.delegate = (id<NSTableViewDelegate>)self;
    tableView.dataSource = (id<NSTableViewDataSource>)self;
}

- (void)TWMHomeTimelineController_viewWillDisappear {
    if (![self isKindOfClass:[@"TWMHomeTimelineController" twx_class]] || ![self twx_isBookmarksScreen]) {
        [self TWMHomeTimelineController_viewWillDisappear];
        return;
    }
}

- (NSInteger)TWMHomeTimelineController_numberOfStatusCells {
    if (![self isKindOfClass:[@"TWMHomeTimelineController" twx_class]] || ![self twx_isBookmarksScreen]) {
        return  [self TWMHomeTimelineController_numberOfStatusCells];
    }
    
    return [self twx_statuses].count;
}

- (NSInteger)TWMHomeTimelineController_numberOfRowsInTableView:(NSTableView *)tableView {
    if (![self isKindOfClass:[@"TWMHomeTimelineController" twx_class]] || ![self twx_isBookmarksScreen]) {
        return [self TWMHomeTimelineController_numberOfRowsInTableView:tableView];
    }
    
    return [self twx_statuses].count;
}

- (id)TWMHomeTimelineController_statusForRow:(NSInteger)row {
    if (![self isKindOfClass:[@"TWMHomeTimelineController" twx_class]] || ![self twx_isBookmarksScreen]) {
        return [self TWMHomeTimelineController_statusForRow:row];
    }
    
    NSArray *const statuses = [self twx_statuses];
    if (statuses.count > row) {
        return statuses[row];
    }
    
    return nil;
}

#pragma mark - Convenience

- (BOOL)twx_isBookmarksScreen {
    return objc_getAssociatedObject(self, TWXBookmarksTimelineIsBookmarksScreenRefKey) != nil;
}

- (NSArray *)twx_statuses {
    return objc_getAssociatedObject(self, TWXBookmarksTimelineStatusesRefKey) ?: @[];
}

- (TWXAPI *)twx_api {
    TWXAPI *__nullable const existingAPI = objc_getAssociatedObject(self, TWXBookmarksTimelineAPIRefKey);
    if (existingAPI) {
        return existingAPI;
    }
    
    TWXAPI *const newAPI = [[TWXAPI alloc] initWithTwitterAccount:[self performSelector:@selector(account)]];
    objc_setAssociatedObject(self, TWXBookmarksTimelineAPIRefKey, newAPI, OBJC_ASSOCIATION_RETAIN);
    return newAPI;
}

@end

NS_ASSUME_NONNULL_END
