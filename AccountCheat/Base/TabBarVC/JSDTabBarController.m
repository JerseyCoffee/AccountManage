//
//  JSDTabBarController.m
//  MaterialColor
//
//  Created by Jersey on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDTabBarController.h"
#import "JSDHomeViewController.h"
#import "JSDBaseNavigationController.h"

@interface JSDTabBarController ()

@end

@implementation JSDTabBarController

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    
    CYLTabBarController* tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers  tabBarItemsAttributes:[self tabBarItemsAttributesForController] imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
    
    
    [self customizeTabBarAppearance:tabBarController];
    self.navigationController.navigationBar.hidden = YES;
    return (self = (JSDTabBarController *)tabBarController);
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"Primary",
        CYLTabBarItemImage : @"home_highlight",
        CYLTabBarItemSelectedImage : @"home_highlight",  /* NSString and UIImage are supported*/
    };
    NSDictionary *secondTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"Secondary",
        CYLTabBarItemImage : @"fishpond_highlight",
        CYLTabBarItemSelectedImage : @"fishpond_highlight",
    };
    
    
    NSArray *tabBarItemsAttributes = @[
        firstTabBarItemsAttributes,
        secondTabBarItemsAttributes,
    ];
    return tabBarItemsAttributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -- set  && get

- (NSArray *)viewControllers {
    UIViewController *firstViewController = [[JSDHomeViewController alloc] init];
    UIViewController *firstNavigationController = [[JSDBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:NO];
    UIViewController *secondViewController = [[JSDHomeViewController alloc] init];
    UIViewController *secondNavigationController = [[JSDBaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:NO];
    NSArray *viewControllers = @[
        firstNavigationController,
        secondNavigationController,
    ];
    return viewControllers;
}

@end
