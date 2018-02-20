#import <AppKit/AppKit.h>
#import "TWXRoundedAvatars.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TWX)

- (void)roundView;

@end

@implementation TWXRoundedAvatars

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"layout" ofClass:@"TMAvatarImageView"];
    [TWXRuntime exchangeInstanceMethod:@"layout" ofClass:@"TMEditableAvatarView"];
    [TWXRuntime exchangeInstanceMethod:@"layout" ofClass:@"TMComposerAvatarView"];
    [TWXRuntime exchangeInstanceMethod:@"setBaseImage:" ofClass:@"TMAvatarSidebarButton"];
}

@end

@implementation NSObject (Feature)

- (void)TMAvatarImageView_layout {
    [self TMAvatarImageView_layout];
    
    if ([self isKindOfClass:[@"TMAvatarImageView" twx_class]]) {
        [(NSView *)self roundView];
    }
}

- (void)TMEditableAvatarView_layout {
    [self TMEditableAvatarView_layout];
    
    if ([self isKindOfClass:[@"TMEditableAvatarView" twx_class]]) {
        [(NSView *)self roundView];
        [((NSView *)self).superview roundView];
    }
}

- (void)TMComposerAvatarView_layout {
    [self TMComposerAvatarView_layout];
    
    if ([self isKindOfClass:[@"TMComposerAvatarView" twx_class]]) {
        [(NSView *)self roundView];
    }
}

- (void)TMAvatarSidebarButton_setBaseImage:(nullable NSImage *)image {
    if (image == nil || ![self isKindOfClass:[@"TMAvatarSidebarButton" twx_class]]) {
        [self TMAvatarSidebarButton_setBaseImage:image];
        return;
    }
    
    NSImage *const roundedImage = [[NSImage alloc] initWithSize:[image size]];
    [roundedImage lockFocus];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    NSRect const imageFrame = NSRectFromCGRect(CGRectMake(0, 0, image.size.width, image.size.height));
    [[NSBezierPath bezierPathWithRoundedRect:imageFrame xRadius:image.size.height * 0.5f yRadius:image.size.height * 0.5f] addClip];
    [image drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, image.size.width, image.size.height) operation:NSCompositingOperationSourceOver fraction:1];
    [roundedImage unlockFocus];
    
    [self TMAvatarSidebarButton_setBaseImage:roundedImage];
}

@end

@implementation NSView (TWX)

- (void)roundView {
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.height * 0.5f;
}

@end

NS_ASSUME_NONNULL_END
