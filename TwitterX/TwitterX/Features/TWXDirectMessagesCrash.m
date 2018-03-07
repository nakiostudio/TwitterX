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
