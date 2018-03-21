// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWXAPI: NSObject

- (instancetype)initWithTwitterAccount:(id)twitterAccount;

- (void)v1_1_requestTo:(NSString *)endpoint method:(NSString*)method parameters:(NSDictionary *)parameters callback:(void(^)(id))callback;

- (void)v2_requestTo:(NSString *)endpoint method:(NSString*)method parameters:(NSDictionary *)parameters callback:(void(^)(id))callback;

@end

NS_ASSUME_NONNULL_END
