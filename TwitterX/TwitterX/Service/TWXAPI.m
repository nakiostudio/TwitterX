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
#import "TWXAPI.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWXAPI ()

@property (nonatomic, readonly, strong) id twitterAPI;
@property (nonatomic, readonly, strong) id twitterAccount;

@end

@implementation TWXAPI

- (instancetype)initWithTwitterAccount:(id)twitterAccount {
    NSParameterAssert(twitterAccount);
    NSParameterAssert([twitterAccount isKindOfClass:[@"TwitterAccount" twx_class]]);
    
    self = [super init];
    
    if (self) {
        self->_twitterAccount = twitterAccount;
        self->_twitterAPI = [[self class] createTwitterAPIWithAccount:twitterAccount];
    }
    
    return self;
}

#pragma mark - Public

- (void)v1_1_requestTo:(NSString *)endpoint method:(NSString*)method parameters:(NSDictionary *)parameters callback:(void(^)(id))callback {
    NSString *const apiRoot = @"https://api.twitter.com/1.1";
    [self requestTo:endpoint apiRoot:apiRoot method:method parameters:parameters multiPartFormData:nil persistent:NO callback:callback start:@"" excludingParameters:nil];
}

- (void)v2_requestTo:(NSString *)endpoint method:(NSString*)method parameters:(NSDictionary *)parameters callback:(void(^)(id))callback {
    NSString *const apiRoot = @"https://api.twitter.com/2";
    [self requestTo:endpoint apiRoot:apiRoot method:method parameters:parameters multiPartFormData:nil persistent:NO callback:callback start:@"" excludingParameters:nil];
}

#pragma mark - Private

- (void)requestTo:(NSString *)endpoint apiRoot:(NSString *)apiRoot method:(NSString*)method parameters:(NSDictionary *)parameters multiPartFormData:(nullable NSData *)data
     persistent:(BOOL)persistent callback:(void(^)(id))callback start:(NSString *)start excludingParameters:(nullable NSDictionary *)excludingParameters {
    NSParameterAssert(endpoint && apiRoot && method && parameters && callback && start);
    
    const SEL requestSelector = @selector(request:apiRoot:method:parameters:multiPartFormData:persistent:callback:start:excludingParameters:);
    NSInvocation *const requestInvocation = [NSInvocation invocationWithMethodSignature:[self.twitterAPI methodSignatureForSelector:requestSelector]];
    requestInvocation.selector = requestSelector;
    requestInvocation.target = self.twitterAPI;
    [requestInvocation setArgument:&endpoint atIndex:2];
    [requestInvocation setArgument:&apiRoot atIndex:3];
    [requestInvocation setArgument:&method atIndex:4];
    [requestInvocation setArgument:&parameters atIndex:5];
    [requestInvocation setArgument:&data atIndex:6];
    [requestInvocation setArgument:&persistent atIndex:7];
    [requestInvocation setArgument:&callback atIndex:8];
    [requestInvocation setArgument:&start atIndex:9];
    [requestInvocation setArgument:&excludingParameters atIndex:10];
    [requestInvocation invoke];
}

#pragma mark - Static

+ (nullable id)createTwitterAPIWithAccount:(id)twitterAccount {
    NSParameterAssert(twitterAccount);
    
    void *result;
    
    // Arguments
    NSString *apiRoot = @"https://api.twitter.com/2";
    void(^__nullable callback)(id) = nil;
    
    // Invocation
    id const allocatedAPI = [NSClassFromString(@"TwitterAPI") alloc];
    const SEL selector = @selector(initWithAccount:apiRoot:callback:);
    NSInvocation *const invocation = [NSInvocation invocationWithMethodSignature:[allocatedAPI methodSignatureForSelector:selector]];
    invocation.selector = selector;
    invocation.target = allocatedAPI;
    [invocation setArgument:&twitterAccount atIndex:2];
    [invocation setArgument:&apiRoot atIndex:3];
    [invocation setArgument:&callback atIndex:4];
    [invocation invoke];
    [invocation retainArguments];
    [invocation getReturnValue:&result];
    
    return (__bridge NSObject *)result;
}

@end

NS_ASSUME_NONNULL_END
