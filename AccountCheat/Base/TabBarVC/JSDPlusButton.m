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
    [flatButton jsd_setsize:CGSizeMake(50, 50)];
    
    return flatButton;
}

+ (UIViewController *)plusChildViewController {

    JSDAddTypeVC* addTypeVC = [[JSDAddTypeVC alloc] init];
    JSDBaseNavigationController* addTypenavigationVC = [[JSDBaseNavigationController alloc] initWithRootViewController:addTypeVC];

    return addTypenavigationVC;
}

//+ (UIViewController *)plusChildViewController {
//
//    JSDAddNoteToTypeVC* addNoteToTypeVC = [[JSDAddNoteToTypeVC alloc] init];
//    JSDBaseNavigationController* addTypenavigationVC = [[JSDBaseNavigationController alloc] initWithRootViewController:addNoteToTypeVC];
//
//    addNoteToTypeVC.viewModel = [[JSDItemListViewModel alloc] initWithType:@"密钥"];
//
//    return addTypenavigationVC;
//}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    
    return 1;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    
    return 0.1;
}


@end
