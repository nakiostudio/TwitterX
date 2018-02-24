#import "TwitterX.h"
#import "TWXCharactersLimit.h"
#import "TWXRoundedAvatars.h"
#import "TWXEnhancedFullscreen.h"
#import "TWXRoundedStatusContent.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (TWX)

+ (void)load {
    [TWXCharactersLimit loadFeature];
    [TWXRoundedAvatars loadFeature];
    [TWXEnhancedFullscreen loadFeature];
    [TWXRoundedStatusContent loadFeature];
}

@end

NS_ASSUME_NONNULL_END
