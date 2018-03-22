// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "NSImage+TWX.h"
#import "TWXRuntime.h"
#import "NSBundle+TWX.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSImage (TWX)

+ (void)load {
    [TWXRuntime exchangeClassMethod:@"imageNamed:" ofClass:@"NSImage"];
}

@end

@implementation NSObject (TWX)

+ (NSImage *)NSImage_imageNamed:(NSString *)name {
    NSParameterAssert(name);
    
    NSImage *__nullable const mainBundleImage = [self NSImage_imageNamed:name];
    if (mainBundleImage) {
        return mainBundleImage;
    }
    
    NSBundle *__nullable assetsBundle = [NSBundle twx_assetsBundle];
    return [assetsBundle imageForResource:name];
}

@end

NS_ASSUME_NONNULL_END
