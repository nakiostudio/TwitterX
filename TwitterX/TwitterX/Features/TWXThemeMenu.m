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
    [self registerCustomTheme];
    [TWXRuntime exchangeInstanceMethod:@"setGeneralView:"
                               ofClass:@"TweetiePreferencesWindowController"
                                prefix: @"TWXThemeMenu"];
    [TWXRuntime exchangeInstanceMethod:@"didChangeDarkModeSetting:" ofClass:@"TweetiePreferencesWindowController"];
}

+ (void)registerCustomTheme {
    [[@"TMTheme" twx_class] twx_invoke:@"registerThemeClass:" arg:TWXDuskTheme.class];
}
@end

@implementation NSObject (TWX)

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
    
    NSString * darkTitle = NSLocalizedStringFromTable(@"07L-lv-aR5.title", @"Preferences", nil);
    NSString * lightTitle = NSLocalizedStringFromTable(@"YLa-rz-sxj.title", @"Preferences", nil);
    
    // get theme NSPopUpButton :p
    NSPopUpButton* themePopUpButton;
    for (NSView* subView in view.subviews) {
        if (![subView isKindOfClass:NSPopUpButton.class]) {
            continue;
        }
        NSPopUpButton* popupButton = (NSPopUpButton *)subView;
        if ([popupButton.itemTitles containsObject:darkTitle] || [popupButton.itemTitles containsObject:lightTitle]) {
            themePopUpButton = popupButton;
            break;
        }
    }
    
    // inject items
    [themePopUpButton removeAllItems];
    for (id name in [self TWX_allThemeNames]) {
        [themePopUpButton addItemWithTitle:name];
    }
    
    // select current identifier
    NSString* currentThemeIdentifier = [[@"TMTheme" twx_class] twx_invokeAndReturnValue:@"currentThemeIdentifier"];
    NSInteger currentThemeIndex = [[self TWX_allThemeIdentifiers] indexOfObject:currentThemeIdentifier];
    [themePopUpButton selectItemAtIndex:currentThemeIndex];
    
    [self TWXThemeMenu_TweetiePreferencesWindowController_setGeneralView:view];
}

- (void)TweetiePreferencesWindowController_didChangeDarkModeSetting:(NSPopUpButton *)sender {
    NSInteger index = [sender indexOfSelectedItem];
    NSString* identifier = [self TWX_allThemeIdentifiers][index];
    [[@"TMTheme" twx_class] twx_invoke:@"switchToThemeWithIdentifier:" arg:identifier];
    [[@"TMTheme" twx_class] twx_invoke:@"saveThemeIdentifierToUserDefaults:" arg:identifier];
}

@end
