#import "TwitterX.h"
#import "TWXCharactersLimit.h"
#import "TWXRoundedAvatars.h"
#import "TWXEnhancedFullscreen.h"
#import "TWXRoundedStatusContent.h"
#import "TWXLightThemeReborn.h"
#import "TWXPretendBeingiPhone.h"
#import "TWXRepliesCount.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (TWX)

+ (void)load {
    [TWXCharactersLimit loadFeature];
    [TWXRoundedAvatars loadFeature];
    [TWXEnhancedFullscreen loadFeature];
    [TWXRoundedStatusContent loadFeature];
    [TWXLightThemeReborn loadFeature];
    [TWXPretendBeingiPhone loadFeature];
    [TWXRepliesCount loadFeature];
}

@end

NS_ASSUME_NONNULL_END
