// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <AppKit/AppKit.h>
#import "TWXDirectMessagesCrash.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXDirectMessagesCrash

+ (void)loadFeature {
    [TWXRuntime exchangeClassMethod:@"attributedTextForMessage:cellType:" ofClass:@"TMMessageCell"];
}

@end

@implementation NSObject (TWX)

+ (nullable id)TMMessageCell_attributedTextForMessage:(nullable id)message cellType:(NSInteger)cellType {
    if ([NSStringFromClass(self) isEqualToString:@"TMMessageCell"] && message == nil) {
        return nil;
    }
    return [self TMMessageCell_attributedTextForMessage:message cellType:cellType];
}

@end

NS_ASSUME_NONNULL_END
