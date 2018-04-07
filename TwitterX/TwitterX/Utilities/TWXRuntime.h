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

@interface TWXRuntime: NSObject

+ (void)exchangeInstanceMethod:(NSString *)method ofClass:(NSString *)classString prefix:(nullable NSString *)prefix;

+ (void)exchangeInstanceMethod:(NSString *)method ofClass:(NSString *)classString;

+ (void)exchangeClassMethod:(NSString *)method ofClass:(NSString *)classString;

@end

@interface NSString (TWXRuntime)

- (Class)twx_class;

@end

@interface NSObject (TWXRuntime)

- (void)twx_performSelector:(SEL)selector value:(unsigned long long)value;

- (void)twx_performSelector:(SEL)selector withObject:(id)object value:(unsigned long long)value;

- (void)twx_invoke:(NSString*)method arg:(id)arg;

- (id)twx_invokeAndReturnValue:(NSString*)method;

@end

NS_ASSUME_NONNULL_END
