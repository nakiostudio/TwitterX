#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (TWX)

- (void)anchorToAttribute:(NSLayoutAttribute)toAttr ofView:(NSView *)view fromAttribute:(NSLayoutAttribute)fromAttr;

- (void)anchorToAttribute:(NSLayoutAttribute)toAttr ofView:(NSView *)view fromAttribute:(NSLayoutAttribute)fromAttr constant:(CGFloat)constant;

- (void)anchorDimenstionAttribute:(NSLayoutAttribute)attr toConstant:(CGFloat)constant;

@end

NS_ASSUME_NONNULL_END
