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

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TWX)

- (void)anchorToAttribute:(NSLayoutAttribute)toAttr ofView:(NSView *)view fromAttribute:(NSLayoutAttribute)fromAttr;

- (void)anchorToAttribute:(NSLayoutAttribute)toAttr ofView:(NSView *)view fromAttribute:(NSLayoutAttribute)fromAttr constant:(CGFloat)constant;

- (void)anchorDimenstionAttribute:(NSLayoutAttribute)attr toConstant:(CGFloat)constant;

@end

NS_ASSUME_NONNULL_END
