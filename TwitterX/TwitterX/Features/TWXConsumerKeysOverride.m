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
#import "TWXConsumerKeysOverride.h"
#import "TWXRuntime.h"
#import "NSView+TWX.h"

NS_ASSUME_NONNULL_BEGIN

NSString *const TWXOAuthConsumerKeyDefaultsKey = @"TWXOAuthConsumerKeyDefaults";
NSString *const TWXOAuthConsumerSecretDefaultsKey = @"TWXOAuthConsumerSecretDefaults";
static void *TWXConsumerTextFieldsDelegateKey = &TWXConsumerTextFieldsDelegateKey;

@interface TWXConsumerTextFieldsDelegate: NSObject <NSTextFieldDelegate>

@end

@implementation TWXConsumerKeysOverride

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

    return [[NSUserDefaults standardUserDefaults] stringForKey:TWXOAuthConsumerKeyDefaultsKey] ?: [self TwitterAccount_oAuthConsumerKey];
}

- (NSString *)TwitterAccount_oAuthConsumerSecret {
    if (![self isKindOfClass:[@"TwitterAccount" twx_class]]) {
        return [self TwitterAccount_oAuthConsumerSecret];
    }

    return [[NSUserDefaults standardUserDefaults] stringForKey:TWXOAuthConsumerSecretDefaultsKey] ?: [self TwitterAccount_oAuthConsumerSecret];
}

- (void)TweetiePreferencesWindowController_setGeneralView:(NSView *)view {
    if (![self isKindOfClass:[@"TweetiePreferencesWindowController" twx_class]]) {
        [self TweetiePreferencesWindowController_setGeneralView:view];
        return;
    }
    
    TWXConsumerTextFieldsDelegate *const delegate = [[TWXConsumerTextFieldsDelegate alloc] init];
    objc_setAssociatedObject(self, TWXConsumerTextFieldsDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN);
    
    // Consumer Key TextField
    NSTextField *const consumerKeyTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    consumerKeyTextField.translatesAutoresizingMaskIntoConstraints = NO;
    consumerKeyTextField.stringValue = [[NSUserDefaults standardUserDefaults] stringForKey:TWXOAuthConsumerKeyDefaultsKey] ?: @"";
    consumerKeyTextField.tag = 0;
    consumerKeyTextField.delegate = delegate;
    [view addSubview:consumerKeyTextField];
    
    [consumerKeyTextField anchorDimenstionAttribute:NSLayoutAttributeWidth toConstant:185.f];
    [consumerKeyTextField anchorToAttribute:NSLayoutAttributeTrailing ofView:view fromAttribute:NSLayoutAttributeTrailing constant:-94.f];
    [consumerKeyTextField anchorToAttribute:NSLayoutAttributeTop ofView:view fromAttribute:NSLayoutAttributeTop constant: 27.0];
    
    NSTextField *const consumerKeyLabel = [[self class] createLabel];
    consumerKeyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    consumerKeyLabel.stringValue = @"OAuth consumer key:";
    consumerKeyLabel.alignment = NSRightTextAlignment;
    [view addSubview:consumerKeyLabel];
    
    [consumerKeyLabel anchorToAttribute:NSLayoutAttributeLeading ofView:view fromAttribute:NSLayoutAttributeLeading constant:20.f];
    [consumerKeyLabel anchorToAttribute:NSLayoutAttributeLeading ofView:consumerKeyTextField fromAttribute:NSLayoutAttributeTrailing constant:-9.f];
    [consumerKeyLabel anchorToAttribute:NSLayoutAttributeLastBaseline ofView:consumerKeyTextField fromAttribute:NSLayoutAttributeLastBaseline];
    
    // Consumer Secret TextField
    NSTextField *const consumerSecretTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    consumerSecretTextField.translatesAutoresizingMaskIntoConstraints = NO;
    consumerSecretTextField.stringValue = [[NSUserDefaults standardUserDefaults] stringForKey:TWXOAuthConsumerSecretDefaultsKey] ?: @"";
    consumerSecretTextField.tag = 1;
    consumerSecretTextField.delegate = delegate;
    [view addSubview:consumerSecretTextField];
    
    [consumerSecretTextField anchorDimenstionAttribute:NSLayoutAttributeWidth toConstant:185.f];
    [consumerSecretTextField anchorToAttribute:NSLayoutAttributeTrailing ofView:view fromAttribute:NSLayoutAttributeTrailing constant:-94.f];
    [consumerSecretTextField anchorToAttribute:NSLayoutAttributeBottom ofView:consumerKeyTextField fromAttribute:NSLayoutAttributeTop constant:10.f];
    
    NSTextField *const consumerSecretLabel = [[self class] createLabel];
    consumerSecretLabel.translatesAutoresizingMaskIntoConstraints = NO;
    consumerSecretLabel.stringValue = @"OAuth consumer secret:";
    consumerSecretLabel.alignment = NSRightTextAlignment;
    [view addSubview:consumerSecretLabel];
    
    [consumerSecretLabel anchorToAttribute:NSLayoutAttributeLeading ofView:view fromAttribute:NSLayoutAttributeLeading constant:20.f];
    [consumerSecretLabel anchorToAttribute:NSLayoutAttributeLeading ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeTrailing constant:-9.f];
    [consumerSecretLabel anchorToAttribute:NSLayoutAttributeLastBaseline ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeLastBaseline];
    
    // Info
    NSTextField *const infoLabel = [[self class] createLabel];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.stringValue = @"(requires re-authentication if changed)";
    infoLabel.font = [NSFont systemFontOfSize:9.f];
    infoLabel.alphaValue = 0.48f;
    [view addSubview:infoLabel];
    
    [infoLabel anchorToAttribute:NSLayoutAttributeLeading ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeLeading];
    [infoLabel anchorToAttribute:NSLayoutAttributeTrailing ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeTrailing];
    [infoLabel anchorToAttribute:NSLayoutAttributeBottom ofView:consumerSecretTextField fromAttribute:NSLayoutAttributeTop constant:2.f];
    
    // Anchor existing content
    view.frame = NSMakeRect(0.f, 0.f, 481.f, 444.f);
    for (NSLayoutConstraint *constraint in view.constraints) {
        if ([constraint.firstItem isKindOfClass:[NSPopUpButton class]] && constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondItem == view) {
            [view removeConstraint:constraint];
            [constraint.firstItem anchorToAttribute:NSLayoutAttributeBottom ofView:infoLabel fromAttribute:NSLayoutAttributeTop constant:20.f];
            break;
        }
    }
    
    [self TweetiePreferencesWindowController_setGeneralView:view];
}

#pragma mark - Static

+ (NSTextField *)createLabel {
    NSTextField *const label = [[NSTextField alloc] initWithFrame:NSMakeRect(0.f, 0.f, 0.f, 0.f)];
    label.font = [NSFont systemFontOfSize:13.f];
    label.drawsBackground = NO;
    label.selectable = NO;
    label.bordered = NO;
    label.editable = NO;
    label.bezeled = NO;
    return label;
}

@end

@implementation TWXConsumerTextFieldsDelegate

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
    NSString *const defaultsKey = control.tag == 0 ? TWXOAuthConsumerKeyDefaultsKey : TWXOAuthConsumerSecretDefaultsKey;
    [[NSUserDefaults standardUserDefaults] setObject:fieldEditor.string forKey:defaultsKey];
    return YES;
}

@end

NS_ASSUME_NONNULL_END
