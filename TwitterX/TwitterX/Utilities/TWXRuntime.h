#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWXRuntime: NSObject

+ (void)exchangeInstanceMethod:(NSString *)method ofClass:(NSString *)classString;

+ (void)exchangeClassMethod:(NSString *)method ofClass:(NSString *)classString;

@end

@interface NSString (TWX)

- (Class)twx_class;

@end

NS_ASSUME_NONNULL_END
