// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "NSView+TWX.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSView (TWX)

- (void)anchorToAttribute:(NSLayoutAttribute)toAttr ofView:(NSView *)view fromAttribute:(NSLayoutAttribute)fromAttr {
    NSParameterAssert(view);
    
    NSLayoutConstraint *const constraint =
    [NSLayoutConstraint
     constraintWithItem:self
     attribute:fromAttr
     relatedBy:NSLayoutRelationEqual
     toItem:view
     attribute:toAttr
     multiplier:1.0f
     constant:0.0f];
    
    if (@available(macOS 10.10, *)) {
        [NSLayoutConstraint activateConstraints:@[constraint]];
        return;
    }
    
    NSView *const ownerView = (fromAttr == NSLayoutAttributeWidth || fromAttr == NSLayoutAttributeHeight) ? self : self.superview;
    [ownerView addConstraint:constraint];
}

@end

NS_ASSUME_NONNULL_END
