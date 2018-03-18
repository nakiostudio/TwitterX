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
#import "TWXPretendBeingiPhone.h"
#import "TWXRuntime.h"
#import "NSView+TWX.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXPretendBeingiPhone

+ (void)loadFeature {
    [TWXRuntime exchangeClassMethod:@"userAgent" ofClass:@"TwitterAPI"];
    [TWXRuntime exchangeInstanceMethod:@"setValue:forHTTPHeaderField:" ofClass:@"ABHTTPRequest"];
    [TWXRuntime exchangeInstanceMethod:@"oAuthConsumerKey" ofClass:@"TwitterAccount"];
    [TWXRuntime exchangeInstanceMethod:@"oAuthConsumerSecret" ofClass:@"TwitterAccount"];
    [TWXRuntime exchangeInstanceMethod:@"setGeneralView:" ofClass:@"TweetiePreferencesWindowController"];
}

@end

@implementation NSObject (TWX)

+ (NSString *)TwitterAPI_userAgent {
    return @"Twitter-iPhone/7.17.1 iOS/9.3.5 (Apple;iPhone4,1;;;;;1;2011)";
}

- (void)ABHTTPRequest_setValue:(id)value forHTTPHeaderField:(NSString *)field {
    if (![self isKindOfClass:[@"ABHTTPRequest" twx_class]]) {
        [self ABHTTPRequest_setValue:value forHTTPHeaderField:field];
        return;
    }
    
    id customValue = value;
    
    if ([field isEqualToString:@"X-Twitter-Client"]) {
        customValue = @"Twitter-iPhone";
    }
    else if ([field isEqualToString:@"X-Twitter-Client-Version"]) {
        customValue = @"7.17.1";
        [self ABHTTPRequest_setValue:@"5" forHTTPHeaderField:@"X-Twitter-API-Version"];
    }
    
    [self ABHTTPRequest_setValue:customValue forHTTPHeaderField:field];
}

- (NSString *)TwitterAccount_oAuthConsumerKey {
    if (![self isKindOfClass:[@"TwitterAccount" twx_class]]) {
        return [self TwitterAccount_oAuthConsumerKey];
    }

    return [[NSProcessInfo processInfo].environment objectForKey:@"TWITTER_CONSUMER_KEY"];
}

- (NSString *)TwitterAccount_oAuthConsumerSecret {
    if (![self isKindOfClass:[@"TwitterAccount" twx_class]]) {
        return [self TwitterAccount_oAuthConsumerSecret];
    }

    return [[NSProcessInfo processInfo].environment objectForKey:@"TWITTER_CONSUMER_SECRET"];
}

- (void)TweetiePreferencesWindowController_setGeneralView:(NSView *)view {
    if (![self isKindOfClass:[@"TweetiePreferencesWindowController" twx_class]]) {
        [self TweetiePreferencesWindowController_setGeneralView:view];
        return;
    }
    
    // Consumer Key TextField
    NSTextField *const consumerKeyTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    consumerKeyTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:consumerKeyTextField];
    
    [consumerKeyTextField anchorDimenstionAttribute:NSLayoutAttributeWidth toConstant:185.f];
    [consumerKeyTextField anchorToAttribute:NSLayoutAttributeTrailing ofView:view fromAttribute:NSLayoutAttributeTrailing constant:-94.f];
    [consumerKeyTextField anchorToAttribute:NSLayoutAttributeTop ofView:view fromAttribute:NSLayoutAttributeTop constant: 27.0];
    
    NSTextField *const consumerKeyLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    consumerKeyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    consumerKeyLabel.stringValue = @"OAuth consumer key:";
    consumerKeyLabel.alignment = NSRightTextAlignment;
    consumerKeyLabel.drawsBackground = NO;
    consumerKeyLabel.selectable = NO;
    consumerKeyLabel.bordered = NO;
    consumerKeyLabel.editable = NO;
    consumerKeyLabel.bezeled = NO;
    [view addSubview:consumerKeyLabel];
    
    [consumerKeyLabel anchorToAttribute:NSLayoutAttributeLeading ofView:view fromAttribute:NSLayoutAttributeLeading constant:20.f];
    [consumerKeyLabel anchorToAttribute:NSLayoutAttributeLeading ofView:consumerKeyTextField fromAttribute:NSLayoutAttributeTrailing constant:-9.f];
    [consumerKeyLabel anchorToAttribute:NSLayoutAttributeLastBaseline ofView:consumerKeyTextField fromAttribute:NSLayoutAttributeLastBaseline];
    
    // Consumer Secret TextField
    NSTextField *const consumerSecretTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    consumerSecretTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:consumerSecretTextField];
    
    [consumerSecretTextField anchorDimenstionAttribute:NSLayoutAttributeWidth toConstant:185.f];
    [consumerSecretTextField anchorToAttribute:NSLayoutAttributeTrailing ofView:view fromAttribute:NSLayoutAttributeTrailing constant:-94.f];
    [consumerSecretTextField anchorToAttribute:NSLayoutAttributeBottom ofView:consumerKeyTextField fromAttribute:NSLayoutAttributeTop constant:10.f];
    
    NSTextField *const consumerSecretLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    consumerSecretLabel.translatesAutoresizingMaskIntoConstraints = NO;
    consumerSecretLabel.stringValue = @"OAuth consumer secret:";
    consumerSecretLabel.alignment = NSRightTextAlignment;
    consumerSecretLabel.drawsBackground = NO;
    consumerSecretLabel.selectable = NO;
    consumerSecretLabel.bordered = NO;
    consumerSecretLabel.editable = NO;
    consumerSecretLabel.bezeled = NO;
    [view addSubview:consumerSecretLabel];
    
    [consumerSecretLabel anchorToAttribute:NSLayoutAttributeLeading ofView:view fromAttribute:NSLayoutAttributeLeading constant:20.f];
    [consumerSecretLabel anchorToAttribute:NSLayoutAttributeLeading ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeTrailing constant:-9.f];
    [consumerSecretLabel anchorToAttribute:NSLayoutAttributeLastBaseline ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeLastBaseline];
    
    // Anchor existing content
    for (NSLayoutConstraint *constraint in view.constraints) {
        if ([constraint.firstItem isKindOfClass:[NSPopUpButton class]] && constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondItem == view) {
            [view removeConstraint:constraint];
            [constraint.firstItem anchorToAttribute:NSLayoutAttributeBottom ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeTop constant:20.f];
            break;
        }
    }
    
    [self TweetiePreferencesWindowController_setGeneralView:view];
}

@end

NS_ASSUME_NONNULL_END
