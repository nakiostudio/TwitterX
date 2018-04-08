//
//  TWXSource.m
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/08.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import "TWXSource.h"
#import "TWXRuntime.h"
#import <AppKit/AppKit.h>
#import "NSString+TWX.h"

@implementation TWXSource
+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"updateAttributedStrings" ofClass:@"TMNewDetailedStatusCell"];
}
@end

@implementation NSObject (TWX)
- (void)TMNewDetailedStatusCell_updateAttributedStrings {
    [self TMNewDetailedStatusCell_updateAttributedStrings];
    id status = [self valueForKey:@"_status"];
    NSString* sourceHTML = [status valueForKey:@"_source"];
    NSString* source = [sourceHTML stringByStrippingHTML];
    NSTextView* textView = [self valueForKey:@"dateTimeAndLocation"];
    textView.string = [textView.string stringByAppendingString:source];
}
@end
