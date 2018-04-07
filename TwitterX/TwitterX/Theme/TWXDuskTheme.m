//
//  TWXDuskheme.m
//  TwitterX
//
//  Created by Tomoya Hirano on 2018/04/07.
//  Copyright © 2018年 twitterx. All rights reserved.
//

#import "TWXDuskTheme.h"
#import <AppKit/AppKit.h>
#import "NSColor+TWX.h"

@implementation TWXDuskTheme
+ (void)load{
    
}
+ (id)themeImageFilenameIdentifier{
    return @"";
}
+ (id)themeIdentifier{
    return @"com.twitter.twitter.themeIdentifiers.duskTheme";
}
- (id)imageNamed:(NSString *)name{
    NSLog(@"%@", name);
    return [NSImage imageNamed:name];
}
- (id)_themedImageNameForImageName:(id)arg1{
    return @"";
}
- (id)inactiveBadgeBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)liveBadgeBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)appearance {
    return nil;
}
- (id)videoPlayerPlaceholderColor{
  return [NSColor whiteColor];
}
- (id)GIFSearchRed{
  return [NSColor whiteColor];
}
- (id)GIFSearchOrange{
  return [NSColor whiteColor];
}
- (id)GIFSearchYellow{
  return [NSColor whiteColor];
}
- (id)GIFSearchBlue{
  return [NSColor whiteColor];
}
- (id)GIFSearchGreen{
  return [NSColor whiteColor];
}
- (id)GIFSearchPurple{
  return [NSColor whiteColor];
}
- (id)messageMineSelectedTextBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)selectedTextBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)copyrightTextColor{
  return [NSColor whiteColor];
}
- (id)versionTextColor{
  return [NSColor whiteColor];
}
- (id)logoColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)aboutBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)momentsBlurColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)momentCoverSubtextColor{
    return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)momentCoverTitleTextColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)momentCoverImageOverlayColor{
  return [[NSColor colorFromHexString:@"#2D2D2E"] colorWithAlphaComponent:0.5];
}
- (id)momentHeroTimeTextColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)momentHeroTitleTextColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)momentHeroSubcategoryTextColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)momentTimeTextColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)momentTitleTextColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)momentSubcategoryTextColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)momentsGuideNavigationBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)momentsNavigationActiveColor{
    return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)momentsNavigationColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)popoverSeparatorColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)popoverRemoveTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)popoverRemoveTextColor{
  return [NSColor whiteColor];
}
- (id)popoverActionTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)popoverActionTextColor{
  return [NSColor whiteColor];
}
- (id)popoverWarningTextColor{
  return [NSColor whiteColor];
}
- (id)popoverSubheadTextColor{
  return [NSColor whiteColor];
}
- (id)popoverTextColor{
  return [NSColor whiteColor];
}
- (id)searchSuggestionsOverlayBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)searchFieldBackgroundColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)searchFieldBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)trendNeutralColor{
  return [NSColor whiteColor];
}
- (id)trendDownColor{
  return [NSColor whiteColor];
}
- (id)trendUpColor{
  return [NSColor whiteColor];
}
- (id)trendColor{
  return [NSColor whiteColor];
}
- (id)savedSearchIconColor{
  return [NSColor whiteColor];
}
- (id)searchFilterAndClearIconColor{
  return [NSColor whiteColor];
}
- (id)searchScopeIconColor{
  return [NSColor whiteColor];
}
- (id)searchPlaceholderTextColor{
  return [NSColor whiteColor];
}
- (id)searchTextColor{
  return [NSColor whiteColor];
}
- (id)searchIconColor{
  return [NSColor whiteColor];
}
- (id)settingsToggleThumbColor{
  return [NSColor whiteColor];
}
- (id)settingsToggleOffColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)settingsToggleOffColor{
  return [NSColor whiteColor];
}
- (id)settingsToggleOnColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)settingsToggleOnColor{
  return [NSColor whiteColor];
}
- (id)profileSecondaryTextColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)profilePrimaryTextColor{
    return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)profileBackButtonColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)profileBackButtonColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)followerRequestsCountBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)followerRequestsCountTextColor{
  return [NSColor whiteColor];
}
- (id)profileProtectedIconColor{
  return [NSColor whiteColor];
}
- (id)profileProtectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)profileProtectedTextColor{
  return [NSColor whiteColor];
}
- (id)profileAvatarBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)profileAvatarPlaceholderColor{
  return [NSColor whiteColor];
}
- (id)profileBannerPlaceholdercolor{
  return [NSColor whiteColor];
}
- (id)profileTabBackgroundColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)profileTabBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)profileTabSelectedBackgroundColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)profileTabSelectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)profileTabSelectedTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)profileTabSelectedTextColor{
  return [NSColor whiteColor];
}
- (id)profileTabTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)profileTabTextColor{
  return [NSColor whiteColor];
}
- (id)profileTabBackgroundRuleColor{
  return [NSColor whiteColor];
}
- (id)profileTabDividerColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)profileFollowersCountColor{
  return [NSColor whiteColor];
}
- (id)profileFollowersLabelColor{
  return [NSColor whiteColor];
}
- (id)profileEditPlaceholderColor{
  return [NSColor whiteColor];
}
- (id)profileTitleBarBottomColor{
  return [NSColor whiteColor];
}
- (id)profileTitleBarTopColor{
  return [NSColor whiteColor];
}
- (id)followsYouTokenBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)followsYouTokenColor{
  return [NSColor whiteColor];
}
- (id)directMessageFullNameColor{
  return [NSColor whiteColor];
}
- (id)directMessageEmptyOtherUserAvatarBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)directMessageLeaveConversationTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)directMessageLeaveConversationTextColor{
  return [NSColor whiteColor];
}
- (id)directMessageAlreadyAddedIconColor{
  return [NSColor whiteColor];
}
- (id)directMessageNoMatchTextColor{
  return [NSColor whiteColor];
}
- (id)directMessageAddPeopleTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)directMessageAddPeopleTextColor{
  return [NSColor whiteColor];
}
- (id)directMessageComposeMediaIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)directMessageComposeMediaIconColor{
  return [NSColor whiteColor];
}
- (id)directMessageComposePlaceholderTextColor{
  return [NSColor whiteColor];
}
- (id)directMessageComposeTextColor{
  return [NSColor whiteColor];
}
- (id)directMessageComposeBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)directMessageComposeBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)directMessageActionTextColor{
  return [NSColor whiteColor];
}
- (id)recipientTokenTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)recipientTokenTextColor{
  return [NSColor whiteColor];
}
- (id)recipientTokenBackgroundColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)recipientTokenBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)otherChatBubbleBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)otherChatBubbleHashtagColor{
  return [NSColor whiteColor];
}
- (id)otherChatBubbleLinkColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)otherChatBubbleTextColor{
  return [NSColor whiteColor];
}
- (id)mineChatBubbleBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)mineChatBubbleHashtagColor{
  return [NSColor whiteColor];
}
- (id)mineChatBubbleLinkColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)mineChatBubbleTextColor{
  return [NSColor whiteColor];
}
- (id)participantBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)pollChoiceInputTextColor{
  return [NSColor whiteColor];
}
- (id)pollChoiceInputPlaceholderTextColor{
  return [NSColor whiteColor];
}
- (id)pollChoiceInputBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)cardPollWinningBarColor{
  return [NSColor whiteColor];
}
- (id)cardPollBarColor{
  return [NSColor whiteColor];
}
- (id)cardPollBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)cardButtonTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)cardButtonTextColor{
  return [NSColor whiteColor];
}
- (id)cardButtonBorderColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)cardButtonBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)cardBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)detailMetadataCountColor{
    return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)endOfDetailBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)mediaViewerIconColor{
  return [NSColor whiteColor];
}
- (id)mediaViewerBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)messageListExcerptTextColor{
  return [NSColor whiteColor];
}
- (id)messageListActionTextColor{
  return [NSColor whiteColor];
}
- (id)conversationMutedColor{
  return [NSColor whiteColor];
}
- (id)messageRepliedColor{
  return [NSColor whiteColor];
}
- (id)unreadIndicatorColor{
  return [NSColor whiteColor];
}
- (id)unreadMessageColor{
  return [NSColor whiteColor];
}
- (id)listInputPlaceHolderTextColor{
  return [NSColor whiteColor];
}
- (id)listInputBackgroundTextColor{
  return [NSColor whiteColor];
}
- (id)listProtectedIconColor{
  return [NSColor whiteColor];
}
- (id)autocompleteBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)autocompleteSeparatorColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)autocompleteHighlightColor{
  return [NSColor whiteColor];
}
- (id)autocompleteHashTagColor{
  return [NSColor whiteColor];
}
- (id)autocompleteFullNameColor{
  return [NSColor whiteColor];
}
- (id)autocompleteTwitterHandleColor{
  return [NSColor whiteColor];
}
- (id)composeActionTextSelectedColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)composeActionTextSelectedColor{
  return [NSColor whiteColor];
}
- (id)composeActionIconSelectedColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)composeActionIconSelectedColor{
  return [NSColor whiteColor];
}
- (id)composeActionTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)composeActionTextColor{
  return [NSColor whiteColor];
}
- (id)composeActionIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)composeEmojiIconColor{
  return [NSColor whiteColor];
}
- (id)composeActionIconColor{
  return [NSColor whiteColor];
}
- (id)composeBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)userRowSelectedTextBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)userRowSelectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)mediaDeleteOverlayColor{
  return [NSColor whiteColor];
}
- (id)placeholderTextColor{
  return [NSColor whiteColor];
}
- (id)addMediaIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)addMediaIconColor{
  return [NSColor whiteColor];
}
- (id)characterCountOverflowColor{
  return [NSColor whiteColor];
}
- (id)characterCountColor{
  return [NSColor whiteColor];
}
- (id)insertionPointColor{
  return [NSColor whiteColor];
}
- (id)notificationTweetTextColor{
  return [NSColor whiteColor];
}
- (id)notificationListIconColor{
  return [NSColor whiteColor];
}
- (id)notificationContactIconColor{
  return [NSColor whiteColor];
}
- (id)notificationFollowIconColor{
  return [NSColor whiteColor];
}
- (id)notificationRetweetIconColor{
  return [NSColor whiteColor];
}
- (id)notificationFavoriteIconColor{
  return [NSColor whiteColor];
}
- (id)quoteMentionSelectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)quoteSelectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)quoteBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)quoteMentionSelectedBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)quoteSelectedBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)quoteBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)newFollowerColor{
  return [NSColor whiteColor];
}
- (id)retweetSelectedColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)retweetSelectedColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)favoriteSelectedColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)favoriteSelectedColor{
  return [NSColor colorFromHexString:@"#DA2C38"];
}
- (id)tweetActionTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)tweetActionTextColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)tweetActionIconColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)tweetActionIconColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)inputCursorColor{
  return [NSColor whiteColor];
}
- (id)inputErrorBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)inputErrorBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)inputErrorPlaceholderTextColor{
  return [NSColor whiteColor];
}
- (id)inputErrorTextColor{
  return [NSColor whiteColor];
}
- (id)inputBorderColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)inputBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)inputTextColor{
  return [NSColor whiteColor];
}
- (id)minorTextColor{
  return [NSColor whiteColor];
}
- (id)errorTextColor{
  return [NSColor whiteColor];
}
- (id)actionTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)actionTextColor{
  return [NSColor whiteColor];
}
- (id)atReplyColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)atReplyColor{
  return [NSColor whiteColor];
}
- (id)hashtagColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)hashtagColor{
  return [NSColor colorFromHexString:@"#0090B9"];
}
- (id)linkColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)linkColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)subheadTextColor{
  return [NSColor whiteColor];
}
- (id)bodyTextColor{
    return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)metadataLinkColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)metadataColor{
  return [NSColor whiteColor];
}
- (id)timestampColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)usernameColor{
  return [NSColor colorFromHexString:@"#B31789"];
}
- (id)fullNameColor{
  return [NSColor colorFromHexString:@"#B31789"];
}
- (id)progressIndicatorColor{
  return [NSColor whiteColor];
}
- (id)retweetedTextColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)retweetedIconColor{
  return [NSColor colorFromHexString:@"#7CC155"];
}
- (id)endOfLineIconColor{
  return [NSColor whiteColor];
}
- (id)endOfLineBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)closeButtonColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)closeButtonColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)backButtonColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)backButtonColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)mediaPlaceholderColor{
  return [NSColor whiteColor];
}
- (id)topTweetIconColor{
  return [NSColor whiteColor];
}
- (id)promotedIconColor{
  return [NSColor whiteColor];
}
- (id)mentionSelectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)selectedBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)mentionBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)horizontalSeparatorColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)emptyStateTextColor{
  return [NSColor whiteColor];
}
- (id)emptyStateIconColor{
  return [NSColor whiteColor];
}
- (id)appBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)titlebarTextButtonTextColorForState:(long long)arg1{
    return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)titlebarTextButtonTextColor{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)titleColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)titleColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)rowActionIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)rowActionIconColor{
  return [NSColor whiteColor];
}
- (id)rowUnselectedIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)rowUnselectedIconColor{
  return [NSColor whiteColor];
}
- (id)rowSelectedIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)rowSelectedIconColor{
  return [NSColor whiteColor];
}
- (id)borderlessTextColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)buttonWhiteTextColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)buttonWhiteTextColor{
  return [NSColor whiteColor];
}
- (id)buttonWhiteIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonWhiteIconColor{
  return [NSColor whiteColor];
}
- (id)buttonMuteTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonMuteTextColor{
  return [NSColor whiteColor];
}
- (id)buttonMuteIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonMuteIconColor{
  return [NSColor whiteColor];
}
- (id)buttonGrayTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonGrayTextColor{
  return [NSColor whiteColor];
}
- (id)buttonGrayIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonGrayIconColor{
  return [NSColor whiteColor];
}
- (id)buttonPollTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonPollTextColor{
  return [NSColor whiteColor];
}
- (id)buttonPollIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonPollIconColor{
  return [NSColor whiteColor];
}
- (id)buttonBlueTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonBlueTextColor{
  return [NSColor whiteColor];
}
- (id)buttonBlueIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonBlueIconColor{
  return [NSColor whiteColor];
}
- (id)buttonKeyTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonKeyTextColor{
  return [NSColor whiteColor];
}
- (id)buttonKeyIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonKeyIconColor{
  return [NSColor whiteColor];
}
- (id)buttonStandardTextColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonStandardTextColor{
  return [NSColor whiteColor];
}
- (id)buttonStandardIconColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)buttonStandardIconColor{
  return [NSColor whiteColor];
}
- (id)sidebarBackgroundColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)sidebarBackgroundColor{
  return [NSColor colorFromHexString:@"#1F2028"];
}
- (id)sidebarSeparatorColor{
  return [NSColor colorFromHexString:@"#2D2D2E"];
}
- (id)sidebarButtonSelectedColorForState:(long long)arg1{
  return [NSColor whiteColor];
}
- (id)sidebarButtonSelectedColor{
  return [NSColor colorFromHexString:@"#FFFFFF"];
}
- (id)sidebarButtonColorForState:(long long)arg1{
  return [NSColor colorFromHexString:@"#616168"];
}
- (id)sidebarButtonColor{
  return [NSColor whiteColor];
}
- (id)iconGray{
  return [NSColor whiteColor];
}
- (id)textGray{
  return [NSColor whiteColor];
}
- (id)backgroundGray{
  return [NSColor whiteColor];
}
- (id)placeholderGray{
  return [NSColor whiteColor];
}
- (id)disabledGray{
  return [NSColor whiteColor];
}
- (id)inactiveGray{
  return [NSColor whiteColor];
}
- (id)strongGray{
  return [NSColor whiteColor];
}
- (id)weakGray{
  return [NSColor whiteColor];
}
- (id)red{
  return [NSColor whiteColor];
}
- (id)blue{
  return [NSColor whiteColor];
}
- (id)neededColor{
  return [NSColor whiteColor];
}
- (id)modifiedColorForControlState:(long long)arg1 color:(id)arg2{
  return [NSColor whiteColor];
}
- (id)pressedColorForColor:(id)arg1{
  return [NSColor whiteColor];
}
- (id)hoverColorForColor:(id)arg1{
  return [NSColor whiteColor];
}
- (id)inactiveColorForColor:(id)arg1{
  return [NSColor whiteColor];
}
- (id)disabledColorForColor:(id)arg1{
  return [NSColor whiteColor];
}
@end
