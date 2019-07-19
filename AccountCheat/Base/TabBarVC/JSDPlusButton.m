//
//  JSDPlusButton.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/17.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDPlusButton.h"

#import "JSDPublic.h"
#import "JSDAddTypeVC.h"
#import "JSDBaseNavigationController.h"
#import "JSDAddNoteToTypeVC.h"

@implementation JSDPlusButton

+ (id)plusButton {
    
    JSDPlusButton* flatButton = [[JSDPlusButton alloc] init];
    [flatButton setImage:[UIImage jsd_imageName:@"add"] forState:UIControlStateNormal];
    [flatButton jsd_setsize:CGSizeMake(60, 60)];
    
    return flatButton;
}

//TODO: 改成添加列表而不是分类
//+ (UIViewController *)plusChildViewController {
//
//    JSDAddTypeVC* addTypeVC = [[JSDAddTypeVC alloc] init];
//    JSDBaseNavigationController* addTypenavigationVC = [[JSDBaseNavigationController alloc] initWithRootViewController:addTypeVC];
//
//    return addTypenavigationVC;
//}

+ (UIViewController *)plusChildViewController {

    JSDAddNoteToTypeVC* addNoteToTypeVC = [[JSDAddNoteToTypeVC alloc] init];

    JSDBaseNavigationController* addTypenavigationVC = [[JSDBaseNavigationController alloc] initWithRootViewController:addNoteToTypeVC];
    //TODO:默认添加到账户;
    addNoteToTypeVC.viewModel = [[JSDItemListViewModel alloc] initWithType:@"账户"];

    return addTypenavigationVC;
}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    
    return 1;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    
    return 0.1;
}


@end
