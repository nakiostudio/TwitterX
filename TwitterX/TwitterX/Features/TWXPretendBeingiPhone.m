// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "TWXPretendBeingiPhone.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXPretendBeingiPhone

+ (void)loadFeature {
    [TWXRuntime exchangeClassMethod:@"userAgent" ofClass:@"TwitterAPI"];
    [TWXRuntime exchangeInstanceMethod:@"setValue:forHTTPHeaderField:" ofClass:@"ABHTTPRequest"];
    [TWXRuntime exchangeInstanceMethod:@"oAuthConsumerKey" ofClass:@"TwitterAccount"];
    [TWXRuntime exchangeInstanceMethod:@"oAuthConsumerSecret" ofClass:@"TwitterAccount"];
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

- (NSString *)TwitterAccount_oAuthConsumerKey {
    if (![self isKindOfClass:[@"TwitterAccount" twx_class]]) {
        return [self TwitterAccount_oAuthConsumerKey];
    }
    
    return @"REPLACE_WITH_CONSUMER_KEY";
}

- (NSString *)TwitterAccount_oAuthConsumerSecret {
    if (![self isKindOfClass:[@"TwitterAccount" twx_class]]) {
        return [self TwitterAccount_oAuthConsumerSecret];
    }
    
    return @"REPLACE_WITH_CONSUMER_SECRET";
}

@end

NS_ASSUME_NONNULL_END
