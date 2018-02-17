#import "TwitterX.h"
#import "TWXCharactersLimit.h"
#import "TWXRoundedAvatars.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (TWX)

+ (void)load {
    [TWXCharactersLimit loadFeature];
    [TWXRoundedAvatars loadFeature];
}

@end

NS_ASSUME_NONNULL_END
