#import <AppKit/AppKit.h>
#import "TWXMultiColumn.h"
#import "TWXRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (TWX)

- (NSLayoutConstraint *)withPriority:(NSLayoutPriority)priority;

@end

@implementation TWXMultiColumn

+ (void)loadFeature {
    [TWXRuntime exchangeInstanceMethod:@"viewDidLoad" ofClass:@"TMRootViewController"];
}

@end

@implementation NSObject (TWX)

- (void)TMRootViewController_viewDidLoad {
    [self TMRootViewController_viewDidLoad];
    
    if (![self isKindOfClass:[@"TMRootViewController" twx_class]]) {
        return;
    }
    
    NSViewController *const viewController = (NSViewController *)self;
    NSViewController *const sideBarViewController = [self performSelector:@selector(sideBarViewController)];
    NSViewController *const navigationViewController = [self performSelector:@selector(navigationController)];
    NSViewController *const newNavigationController = [[[@"TMNavigationController" twx_class] alloc] init];
    NSViewController *const searchesViewController = [[[@"TMNewSearchesViewController" twx_class] alloc] init];
    [newNavigationController performSelector:@selector(setRootViewController:animated:) withObject:searchesViewController withObject:nil];
    
    [navigationViewController.view removeFromSuperview];
    [viewController.view addSubview:navigationViewController.view];
    [NSLayoutConstraint activateConstraints:@[
        [navigationViewController.view.topAnchor constraintEqualToAnchor:viewController.view.topAnchor],
        [navigationViewController.view.leadingAnchor constraintEqualToAnchor:sideBarViewController.view.trailingAnchor],
        [[navigationViewController.view.trailingAnchor constraintEqualToAnchor:viewController.view.trailingAnchor] withPriority:400.f],
        [[navigationViewController.view.trailingAnchor constraintLessThanOrEqualToAnchor:viewController.view.trailingAnchor] withPriority:NSLayoutPriorityDefaultHigh],
        [navigationViewController.view.bottomAnchor constraintEqualToAnchor:viewController.view.bottomAnchor],
        [[navigationViewController.view.widthAnchor constraintLessThanOrEqualToConstant:[self screenResolution].size.width * 0.25f] withPriority:NSLayoutPriorityRequired]
    ]];
    
    newNavigationController.view.translatesAutoresizingMaskIntoConstraints = false;
    [viewController addChildViewController:newNavigationController];
    [viewController.view addSubview:newNavigationController.view];
    [NSLayoutConstraint activateConstraints:@[
        [newNavigationController.view.topAnchor constraintEqualToAnchor:viewController.view.topAnchor],
        [newNavigationController.view.bottomAnchor constraintEqualToAnchor:viewController.view.bottomAnchor],
        [newNavigationController.view.leadingAnchor constraintEqualToAnchor:navigationViewController.view.trailingAnchor],
        [newNavigationController.view.trailingAnchor constraintEqualToAnchor:viewController.view.trailingAnchor]
    ]];
    
    [navigationViewController.view setContentHuggingPriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];
    [navigationViewController.view setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
    [newNavigationController.view setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
    [newNavigationController.view setContentCompressionResistancePriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];
    
    NSObject *account = [[[@"Twitter" twx_class] performSelector:@selector(sharedTwitter)] performSelector:@selector(defaultAccount)];
    [searchesViewController performSelector:@selector(setAccount:) withObject:account];
}

- (NSRect)screenResolution {
    return [[NSScreen mainScreen] frame];
}

@end

@implementation NSLayoutConstraint (TWX)

- (NSLayoutConstraint *)withPriority:(NSLayoutPriority)priority {
    self.priority = priority;
    return self;
}

@end

NS_ASSUME_NONNULL_END
