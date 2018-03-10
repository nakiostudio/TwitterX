#import <AppKit/AppKit.h>
#import "TWXEnhancedFullscreen.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXEnhancedFullscreen

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"backgroundColor" ofClass:@"NSToolbarFullScreenWindow"];
}

@end

@implementation NSObject (TWX)

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
