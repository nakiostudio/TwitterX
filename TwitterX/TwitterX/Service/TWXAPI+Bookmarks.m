// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <objc/runtime.h>
#import "TWXAPI+Bookmarks.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TWXAPI (Bookmarks)

- (void)fetchBookmarksWithCompletion:(void(^)(NSArray *))completion {
    NSParameterAssert(completion);
    
    NSDictionary *const parameters = [[self class] defaultParameters];
    [self v2_requestTo:@"timeline/bookmark.json" method:@"GET" parameters:parameters callback:^(id _Nonnull request) {
        NSData *__nullable const data = (id)[request performSelector:@selector(data)];
        if (!data) {
            completion(@[]);
            return;
        }
        
        NSError *parseError;
        NSDictionary *__nullable const jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
        if (parseError || !jsonResponse) {
            completion(@[]);
            return;
        }
        
        NSMutableArray *const tweets = [NSMutableArray array];
        NSDictionary *__nullable const tweetsDictionaries = jsonResponse[@"globalObjects"][@"tweets"];
        NSDictionary *__nullable const userDictionaries = jsonResponse[@"globalObjects"][@"users"];
        NSArray<NSString *> *const sortedTweetIds = [[self class] sortedTweetIdentifiersForInJsonResponse:jsonResponse];
        for (NSString *const tweetId in sortedTweetIds) {
            NSMutableDictionary *__nullable const tweetDictionary = tweetsDictionaries[tweetId];
            if (!tweetDictionary) {
                continue;
            }
            NSMutableDictionary *const mutableTweetDictionary = [tweetDictionary mutableCopy];
            [mutableTweetDictionary setObject:userDictionaries[mutableTweetDictionary[@"user_id_str"]] ?: @{} forKey:@"user"];
            id const tweet = [[@"TwitterStatus" twx_class] performSelector:@selector(statusWithDictionary:) withObject:mutableTweetDictionary];
            if (tweet) {
                [tweets addObject:tweet];
            }
        }
        
        completion([tweets copy]);
    }];
}

- (void)addBookmarkForTweetWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *const parameters = [[[self class] defaultParameters] mutableCopy];
    [parameters setObject:@(identifier.integerValue) forKey:@"tweet_id"];
    [self v1_1_requestTo:@"bookmark/entries/add.json" method:@"POST" parameters:parameters callback:^(id _Nonnull request) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.twitter.mac.TMSidebarItemViewControllerBookmarkNotification" object:nil];
    }];
}

- (void)removeBookmarkForTweetWithIdentifier:(NSString *)identifier completion:(void(^)(id))completion {
    __weak typeof(self) weakSelf = self;
    [self fetchBookmarksWithCompletion:^(NSArray *_Nonnull tweets) {
        for (id const tweet in tweets) {
            NSString *const tweetID = [tweet performSelector:@selector(statusID)];
            if ([tweetID isEqualToString:identifier]) {
                [weakSelf _proceedDeletingBookmarkWithIdentifier:identifier completion:completion];
                return;
            }
        }
    }];
}

#pragma mark - Private

- (void)_proceedDeletingBookmarkWithIdentifier:(NSString *)identifier completion:(void(^)(id))completion {
    NSMutableDictionary *const parameters = [[[self class] defaultParameters] mutableCopy];
    [parameters setObject:@(identifier.integerValue) forKey:@"tweet_id"];
    [self v1_1_requestTo:@"bookmark/entries/remove.json" method:@"POST" parameters:parameters callback:completion];
}

#pragma mark - Private static

+ (NSDictionary *)defaultParameters {
    return @{
         @"cards_platform": @"iPhone-13",
         @"contributor_details": @(1),
         @"include_cards": @(1),
         @"include_carousels": @(1),
         @"include_entities": @(1),
         @"include_ext_media_color": @"true",
         @"include_media_features": @"true",
         @"include_my_retweet": @"true",
         @"include_profile_interstitial_type": @"true",
         @"include_profile_location": @"true",
         @"include_reply_count": @(1),
         @"include_user_entities": @"true",
         @"include_user_hashtag_entities": @"true",
         @"include_user_mention_entities": @"true",
         @"include_user_symbol_entities": @"true",
         @"request_context": @"ptr",
         @"tweet_mode": @"extended"
    };
}

+ (NSArray<NSString *> *)sortedTweetIdentifiersForInJsonResponse:(NSDictionary *)jsonResponse {
    NSParameterAssert(jsonResponse);
    
    NSArray *__nullable const instructionsArray = jsonResponse[@"timeline"][@"instructions"];
    if (!instructionsArray || instructionsArray.count == 0) {
        return @[];
    }
    
    NSMutableArray *const result = [NSMutableArray array];
    NSArray<NSString *> *const expectedEntries = instructionsArray[0][@"addEntries"][@"entries"] ?: @[];
    for (NSDictionary *const entry in expectedEntries) {
        NSString *const entryId = entry[@"entryId"];
        if ([entryId hasPrefix:@"tweet-"]) {
            NSString *const tweetId = [entryId stringByReplacingCharactersInRange:NSMakeRange(0, 6) withString:@""];
            [result addObject:tweetId];
        }
    }
    
    return result;
}

@end

NS_ASSUME_NONNULL_END
