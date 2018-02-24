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
        textField.backgroundColor = [NSColor colorWithCGColor:cell.layer.backgroundColor];
    }
}

@end

NS_ASSUME_NONNULL_END
