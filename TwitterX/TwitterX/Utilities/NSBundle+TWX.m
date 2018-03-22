// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "NSBundle+TWX.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSBundle (TWX)

+ (nullable NSBundle *)twx_assetsBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *const frameworkBundle = [NSBundle bundleForClass:[TWXRuntime class]];
        NSURL *__nullable const assetsBundleURL = [frameworkBundle URLForResource:@"TwitterXAssets" withExtension:@"bundle"];
        if (assetsBundleURL) {
            bundle = [NSBundle bundleWithURL:assetsBundleURL];
        }
    });
    return bundle;
}

@end

NS_ASSUME_NONNULL_END
