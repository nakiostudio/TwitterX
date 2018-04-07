//
//  NSColor+TWX.h
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/07.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSColor (TWX)
+ (instancetype)colorFromHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
