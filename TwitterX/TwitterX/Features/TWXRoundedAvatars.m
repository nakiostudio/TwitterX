#import <AppKit/AppKit.h>
#import "TWXRoundedAvatars.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXRoundedAvatars

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"layout" ofClass:@"TMAvatarImageView"];
    [TWXRuntime exchangeInstanceMethod:@"setBaseImage:" ofClass:@"TMAvatarSidebarButton"];
}

@end

@implementation NSObject (Feature)

- (void)TMAvatarImageView_layout {
    [self TMAvatarImageView_layout];
    
    if ([self isKindOfClass:[@"TMAvatarImageView" twx_class]]) {
        NSView *const view = (NSView *)self;
        view.wantsLayer = YES;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = view.bounds.size.height * 0.5f;
    }
}

- (void)TMAvatarSidebarButton_setBaseImage:(nullable NSImage *)image {
    if (image == nil) {
        [self TMAvatarSidebarButton_setBaseImage:image];
        return;
    }
    
    NSImage *const roundedImage = [[NSImage alloc] initWithSize:[image size]];
    [roundedImage lockFocus];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    NSRect imageFrame = NSRectFromCGRect(CGRectMake(0, 0, image.size.width, image.size.height));
    [[NSBezierPath bezierPathWithRoundedRect:imageFrame xRadius:image.size.height * 0.5f yRadius:image.size.height * 0.5f] addClip];
    [image drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, image.size.width, image.size.height) operation:NSCompositingOperationSourceOver fraction:1];
    [roundedImage unlockFocus];
    
    [self TMAvatarSidebarButton_setBaseImage:roundedImage];
}

@end

NS_ASSUME_NONNULL_END
