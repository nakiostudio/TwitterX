//
//  NSColor+TWX.m
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/07.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import "NSColor+TWX.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSColor (TWX)

+ (instancetype)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [NSColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end

NS_ASSUME_NONNULL_END
