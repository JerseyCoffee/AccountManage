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
#import "JSDMyCenterVC.h"
#import "JSDPlusButton.h"

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
    
    [tabBarController setTintColor:[UIColor colorWithRed:170 / 255.0f green:230/ 255.0f blue:245/ 255.0f alpha:1.0f]];
    
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"home_defalut",
        CYLTabBarItemSelectedImage : @"home_selected",  /* NSString and UIImage are supported*/
    };
    NSDictionary *secondTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"个人中心",
        CYLTabBarItemImage : @"my_defalut",
        CYLTabBarItemSelectedImage : @"my_selected",
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
    
    [JSDPlusButton registerPlusButton];
}

#pragma mark -- set  && get

- (NSArray *)viewControllers {
    
    UIViewController *homeViewController = [[JSDHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[JSDBaseNavigationController alloc]
                                                   initWithRootViewController:homeViewController];
    [homeViewController cyl_setHideNavigationBarSeparator:NO];
    UIViewController *myCenterVC = [[JSDMyCenterVC alloc] init];
    UIViewController *myCenterNavigationController = [[JSDBaseNavigationController alloc]
                                                    initWithRootViewController:myCenterVC];
    [myCenterVC cyl_setHideNavigationBarSeparator:NO];
    NSArray *viewControllers = @[
        homeNavigationController,
        myCenterNavigationController,
    ];
    return viewControllers;
}

@end
