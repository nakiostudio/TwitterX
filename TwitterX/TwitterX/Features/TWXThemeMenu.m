//
//  TWXThemeMenu.m
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/07.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import "TWXThemeMenu.h"
#import <objc/runtime.h>
#import "TWXRuntime.h"
#import "NSView+TWX.h"
#import "TWXDuskTheme.h"

@implementation TWXThemeMenu
+ (void)loadFeature {
    [[@"TMTheme" twx_class] twx_invoke:@"registerThemeClass:" arg:TWXDuskTheme.class];
    [TWXRuntime exchangeInstanceMethod:@"setGeneralView:"
                               ofClass:@"TweetiePreferencesWindowController"
                                prefix: @"TWXThemeMenu"];
    [TWXRuntime exchangeInstanceMethod:@"didChangeDarkModeSetting:" ofClass:@"TweetiePreferencesWindowController"];
    [TWXRuntime exchangeInstanceMethod:@"windowDidLoad" ofClass:@"TweetiePreferencesWindowController"];
}
@end

@implementation NSObject (TWX)

- (void)TweetiePreferencesWindowController_windowDidLoad {
    [self TweetiePreferencesWindowController_windowDidLoad];
    
    // select current identifier
    NSPopUpButton* themePopUpButton = [self valueForKey:@"_darkButton"];
    NSString* currentThemeIdentifier = [[@"TMTheme" twx_class] twx_invokeAndReturnValue:@"currentThemeIdentifier"];
    NSInteger currentThemeIndex = [[self TWX_allThemeIdentifiers] indexOfObject:currentThemeIdentifier];
    NSLog(@"TWXThemeMenu_TweetiePreferencesWindowController_setGeneralView %ld", (long)currentThemeIndex);
    [themePopUpButton selectItemAtIndex:currentThemeIndex];
}

- (NSArray*)TWX_allThemeNames {
    return @[NSLocalizedStringFromTable(@"YLa-rz-sxj.title", @"Preferences", nil),
             NSLocalizedStringFromTable(@"07L-lv-aR5.title", @"Preferences", nil),
             @"Dusk"];
}

- (NSArray*)TWX_allThemeIdentifiers {
    return @[@"com.twitter.twitter.themeIdentifiers.lightTheme",
             @"com.twitter.twitter.themeIdentifiers.darkTheme",
             TWXDuskTheme.themeIdentifier];
}

- (void)TWXThemeMenu_TweetiePreferencesWindowController_setGeneralView:(NSView *)view {
    if (![self isKindOfClass:[@"TweetiePreferencesWindowController" twx_class]]) {
        [self TWXThemeMenu_TweetiePreferencesWindowController_setGeneralView:view];
        return;
    }
    
    NSPopUpButton* themePopUpButton = [self valueForKey:@"_darkButton"];
    [themePopUpButton removeAllItems];
    for (id name in [self TWX_allThemeNames]) {
        [themePopUpButton addItemWithTitle:name];
    }
    
    [self TWXThemeMenu_TweetiePreferencesWindowController_setGeneralView:view];
}

- (void)TweetiePreferencesWindowController_didChangeDarkModeSetting:(NSPopUpButton *)sender {
    NSInteger index = [sender indexOfSelectedItem];
    NSString* identifier = [self TWX_allThemeIdentifiers][index];
    [[@"TMTheme" twx_class] twx_invoke:@"switchToThemeWithIdentifier:" arg:identifier];
    [[@"TMTheme" twx_class] twx_invoke:@"saveThemeIdentifierToUserDefaults:" arg:identifier];
}

@end
