#import "TWXCharactersLimit.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXCharactersLimit

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"characterLimit" ofClass:@"TwitterComposition"];
}

@end

@implementation NSObject (TWX)

- (NSInteger)TwitterComposition_characterLimit {
    return 280;
}

@end

NS_ASSUME_NONNULL_END
