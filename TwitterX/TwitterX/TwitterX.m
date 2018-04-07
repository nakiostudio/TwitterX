// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "TwitterX.h"
#import "TWXCharactersLimit.h"
#import "TWXRoundedAvatars.h"
#import "TWXEnhancedFullscreen.h"
#import "TWXRoundedStatusContent.h"
#import "TWXLightThemeReborn.h"
#import "TWXConsumerKeysOverride.h"
#import "TWXRepliesCount.h"
#import "TWXDirectMessagesCrash.h"
#import "TWXBookmarkActions.h"
#import "TWXBookmarksTimeline.h"
#import "TWXBookmarksSidebarItem.h"
#import "TWXThemeMenu.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (TWX)

+ (void)load {
    [TWXCharactersLimit loadFeature];
    [TWXRoundedAvatars loadFeature];
    [TWXEnhancedFullscreen loadFeature];
    [TWXRoundedStatusContent loadFeature];
    [TWXLightThemeReborn loadFeature];
    [TWXConsumerKeysOverride loadFeature];
    [TWXRepliesCount loadFeature];
    [TWXDirectMessagesCrash loadFeature];
    [TWXBookmarkActions loadFeature];
    [TWXBookmarksTimeline loadFeature];
    [TWXBookmarksSidebarItem loadFeature];
    [TWXThemeMenu loadFeature];
}

@end

NS_ASSUME_NONNULL_END
