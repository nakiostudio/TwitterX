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
#import "TWXRoundedStatusContent.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXRoundedStatusContent

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"layout" ofClass:@"TMNewTimelineStatusCell"];
}

@end

@implementation NSObject (TWX)

- (void)TMNewTimelineStatusCell_layout {
    [self TMNewTimelineStatusCell_layout];
    
    if ([self isKindOfClass:[@"TMNewTimelineStatusCell" twx_class]]) {
        NSView *const cell = (NSView *)self;
        NSView *const containerView = (NSView *)[self performSelector:@selector(containerView)];
        containerView.layer.cornerRadius = 12.0f;
        NSTextField *const textField = (NSTextField *)[self performSelector:@selector(tweetTextField)];
        if (cell.layer.backgroundColor) {
            textField.backgroundColor = [NSColor colorWithCGColor:cell.layer.backgroundColor];
        }
    }
}

@end

NS_ASSUME_NONNULL_END
