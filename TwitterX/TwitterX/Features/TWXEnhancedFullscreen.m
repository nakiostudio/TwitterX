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
#import "TWXEnhancedFullscreen.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXEnhancedFullscreen

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"backgroundColor" ofClass:@"NSToolbarFullScreenWindow"];
}

@end

@implementation NSObject (TWX)

- (nullable NSColor *)NSToolbarFullScreenWindow_backgroundColor {
    if ([self isKindOfClass:[@"NSToolbarFullScreenWindow" twx_class]]) {
        NSWindow *const window = (NSWindow *)self;
        [window.contentView.layer.sublayers.firstObject setHidden:YES];
        return [NSColor clearColor];
    }
    return [self NSToolbarFullScreenWindow_backgroundColor];
}

@end

NS_ASSUME_NONNULL_END
