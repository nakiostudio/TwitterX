//
//  TWXTheme.m
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/08.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import "TWXTheme.h"
#import <objc/runtime.h>
#import "TWXRuntime.h"
#import "NSView+TWX.h"
#import "TWXDuskTheme.h"

@implementation TWXTheme
+ (void)loadFeature {
    [TWXRuntime exchangeClassMethod:@"saveThemeIdentifierToUserDefaults:" ofClass:@"TMTheme"];
    [TWXRuntime exchangeClassMethod:@"themeIdentifierFromUserDefaults" ofClass:@"TMTheme"];
}
@end

@implementation NSObject (TWX)

NSString *const TMSelectedThemeIdentifierDefaultsKey = @"TMSelectedThemeIdentifier";

+ (void)TMTheme_saveThemeIdentifierToUserDefaults:(id)arg1 {
    [[NSUserDefaults standardUserDefaults] setObject:arg1 forKey:TMSelectedThemeIdentifierDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (id)TMTheme_themeIdentifierFromUserDefaults {
    return [[NSUserDefaults standardUserDefaults] stringForKey:TMSelectedThemeIdentifierDefaultsKey];
}
@end
