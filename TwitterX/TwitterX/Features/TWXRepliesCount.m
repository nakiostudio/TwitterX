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
#import <objc/runtime.h>
#import "TWXRepliesCount.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

static void *TwitterStatusRepliesCountKey = &TwitterStatusRepliesCountKey;

@interface TWXRepliesTextField: NSTextField

@end

@implementation TWXRepliesTextField

@end

@implementation TWXRepliesCount

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"v1_1_GET:parameters:callback:" ofClass:@"TwitterAPI"];
    [TWXRuntime exchangeClassMethod:@"statusWithDictionary:" ofClass:@"TwitterStatus"];
    [TWXRuntime exchangeInstanceMethod:@"setStatus:" ofClass:@"TMNewTimelineStatusCell"];
}

@end

@implementation NSObject (TWX)

- (void)TwitterAPI_v1_1_GET:(NSString *)endpoint parameters:(NSDictionary *)parameters callback:(id)callback {
    NSMutableDictionary *customParameters = [parameters mutableCopy];

    if ([self isKindOfClass:[@"TwitterAPI" twx_class]] && [endpoint rangeOfString:@"statuses/"].location != NSNotFound) {
        [customParameters setObject:@"iPhone-13" forKey:@"cards_platform"];
        [customParameters setObject:@1 forKey:@"include_reply_count"];
    }

    [self TwitterAPI_v1_1_GET:endpoint parameters:customParameters callback:callback];
}

+ (nullable id)TwitterStatus_statusWithDictionary:(NSDictionary *)dictionary {
    id __nullable const status = [self TwitterStatus_statusWithDictionary:dictionary];

    if ([NSStringFromClass(self) isEqualToString:@"TwitterStatus"]) {
        objc_setAssociatedObject(status, TwitterStatusRepliesCountKey, dictionary[@"reply_count"], OBJC_ASSOCIATION_COPY);
    }

    return status;
}

- (void)TMNewTimelineStatusCell_setStatus:(id)status {
    [self TMNewTimelineStatusCell_setStatus:status];

    if ([self isKindOfClass:[@"TMNewTimelineStatusCell" twx_class]]) {
        NSView *const cell = (NSView *)self;
        NSTextField *__nullable const retweetsTextField = (id)[self performSelector:@selector(retweetTextField)];
        NSButton *__nullable const replyButton = (id)[self performSelector:@selector(replyButton)];
        NSTextField *__nullable repliesTextField;
        for (NSView *subview in cell.subviews) {
            if ([subview isKindOfClass:[TWXRepliesTextField class]]) {
                repliesTextField = (id)subview;
                break;
            }
        }

        if (repliesTextField == nil && replyButton) {
            repliesTextField = [[TWXRepliesTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
            repliesTextField.translatesAutoresizingMaskIntoConstraints = NO;
            repliesTextField.backgroundColor = [NSColor clearColor];
            repliesTextField.bordered = retweetsTextField.bordered;
            repliesTextField.bezeled = retweetsTextField.bezeled;
            repliesTextField.editable = retweetsTextField.editable;
            repliesTextField.selectable = retweetsTextField.selectable;
            repliesTextField.font = [NSFont systemFontOfSize:13.0f];
            repliesTextField.textColor = [[[@"TMTheme" twx_class] performSelector:@selector(currentTheme)] performSelector:@selector(buttonGrayIconColor)];
            [cell addSubview:repliesTextField];
            [NSLayoutConstraint activateConstraints:@[
                [repliesTextField.leadingAnchor constraintEqualToAnchor:replyButton.trailingAnchor constant:0.0f],
                [repliesTextField.centerYAnchor constraintEqualToAnchor:replyButton.centerYAnchor],
                [repliesTextField.heightAnchor constraintEqualToAnchor:retweetsTextField.heightAnchor]
            ]];
            [repliesTextField setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
            [repliesTextField setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
        }

        NSNumber *__nullable const repliesCount = objc_getAssociatedObject(status, TwitterStatusRepliesCountKey) ?: @(0);
        repliesTextField.stringValue = repliesCount.integerValue > 0 ? repliesCount.stringValue : @"";
    }
}

@end

NS_ASSUME_NONNULL_END
