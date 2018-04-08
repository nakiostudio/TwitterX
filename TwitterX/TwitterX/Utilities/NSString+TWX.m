//
//  NSString+TWX.m
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/08.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import "NSString+TWX.h"


NS_ASSUME_NONNULL_BEGIN

@implementation NSString (TWX)
-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
@end

NS_ASSUME_NONNULL_END
