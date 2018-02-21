#import <AppKit/AppKit.h>
#import "TWXEnhancedFullscreen.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXEnhancedFullscreen

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"maxSize" ofClass:@"TMMainWindow"];
    [TWXRuntime exchangeInstanceMethod:@"backgroundColor" ofClass:@"NSToolbarFullScreenWindow"];
}

@end

@implementation NSObject (TWX)

- (NSSize)TMMainWindow_maxSize {
    if ([self isKindOfClass:[@"TMMainWindow" twx_class]]) {
        return NSMakeSize(CGFLOAT_MAX, CGFLOAT_MAX);
    }
    return [self TMMainWindow_maxSize];
}

- (nullable NSColor *)NSToolbarFullScreenWindow_backgroundColor {
    if ([self isKindOfClass:[@"NSToolbarFullScreenWindow" twx_class]]) {
        NSWindow *const window = (NSWindow *)self;
        [window.contentView.layer.sublayers.firstObject setHidden:YES];
        return [NSColor clearColor];
    }
    return [self NSToolbarFullScreenWindow_backgroundColor];
}

@end

NS_ASSUME_NONNULL_END
