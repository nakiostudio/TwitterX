// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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

@implementation NSString (TWXRuntime)

- (Class)twx_class {
    return NSClassFromString(self);
}

@end

@implementation NSObject (TWXRuntime)

- (void)twx_performSelector:(SEL)selector value:(unsigned long long)value {
    NSInvocation *const invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    invocation.target = self;
    invocation.selector = selector;
    [invocation setArgument:&value atIndex:2];
    [invocation invoke];
}

- (void)twx_performSelector:(SEL)selector withObject:(id)object value:(unsigned long long)value {
    NSParameterAssert(object);
    
    NSInvocation *const invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    invocation.target = self;
    invocation.selector = selector;
    [invocation setArgument:&object atIndex:2];
    [invocation setArgument:&value atIndex:3];
    [invocation invoke];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        object;
    });
}

@end

NS_ASSUME_NONNULL_END
