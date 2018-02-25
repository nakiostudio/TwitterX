#import "TWXPretendBeingiPhone.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXPretendBeingiPhone

+ (void)loadFeature {
    [TWXRuntime exchangeClassMethod:@"userAgent" ofClass:@"TwitterAPI"];
    [TWXRuntime exchangeInstanceMethod:@"setValue:forHTTPHeaderField:" ofClass:@"ABHTTPRequest"];
}

@end

@implementation NSObject (TWX)

+ (NSString *)TwitterAPI_userAgent {
    return @"Twitter-iPhone/7.17.1 iOS/9.3.5 (Apple;iPhone4,1;;;;;1;2011)";
}

- (void)ABHTTPRequest_setValue:(id)value forHTTPHeaderField:(NSString *)field {
    if (![self isKindOfClass:[@"ABHTTPRequest" twx_class]]) {
        [self ABHTTPRequest_setValue:value forHTTPHeaderField:field];
        return;
    }
    
    id customValue = value;
    
    if ([field isEqualToString:@"X-Twitter-Client"]) {
        customValue = @"Twitter-iPhone";
    }
    else if ([field isEqualToString:@"X-Twitter-Client-Version"]) {
        customValue = @"7.17.1";
        [self ABHTTPRequest_setValue:@"5" forHTTPHeaderField:@"X-Twitter-API-Version"];
    }
    
    [self ABHTTPRequest_setValue:customValue forHTTPHeaderField:field];
}

@end

NS_ASSUME_NONNULL_END
