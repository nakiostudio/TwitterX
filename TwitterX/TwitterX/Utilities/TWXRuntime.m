#import <objc/runtime.h>
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXRuntime

+ (void)exchangeInstanceMethod:(NSString *)method ofClass:(NSString *)classString {
    NSParameterAssert(method);
    NSParameterAssert(classString);
    
    SEL const originalSelector = NSSelectorFromString(method);
    SEL const swizzledSelector = NSSelectorFromString([[classString stringByAppendingString:@"_"] stringByAppendingString:method]);
    
    Method const originalMethod = class_getInstanceMethod([classString twx_class], originalSelector);
    Method const swizzledMethod = class_getInstanceMethod([NSObject class], swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)exchangeClassMethod:(NSString *)method ofClass:(NSString *)classString {
    NSParameterAssert(method);
    NSParameterAssert(classString);
    
    SEL const originalSelector = NSSelectorFromString(method);
    SEL const swizzledSelector = NSSelectorFromString([[classString stringByAppendingString:@"_"] stringByAppendingString:method]);
    
    Method const originalMethod = class_getClassMethod([classString twx_class], originalSelector);
    Method const swizzledMethod = class_getClassMethod([NSObject class], swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end

@implementation NSString (TWX)

- (Class)twx_class {
    return NSClassFromString(self);
}

@end

NS_ASSUME_NONNULL_END
