#import <AppKit/AppKit.h>
#import "TWXRoundedAvatars.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXRoundedAvatars

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"layout" ofClass:@"TMAvatarImageView"];
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

@end

NS_ASSUME_NONNULL_END
