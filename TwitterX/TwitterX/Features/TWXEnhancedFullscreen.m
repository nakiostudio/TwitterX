#import <AppKit/AppKit.h>
#import "TWXEnhancedFullscreen.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXEnhancedFullscreen

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"maxSize" ofClass:@"TMMainWindow"];
}

@end

@implementation NSObject (TWX)

- (NSSize)TMMainWindow_maxSize {
    if ([self isKindOfClass:[@"TMMainWindow" twx_class]]) {
        return NSMakeSize(CGFLOAT_MAX, CGFLOAT_MAX);
    }
    return [self TMMainWindow_maxSize];
}

@end

NS_ASSUME_NONNULL_END
