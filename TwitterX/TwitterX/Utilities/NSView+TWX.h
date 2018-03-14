#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TWX)

- (void)anchorToAttribute:(NSLayoutAttribute)toAttr ofView:(NSView *)view fromAttribute:(NSLayoutAttribute)fromAttr;

@end

NS_ASSUME_NONNULL_END
