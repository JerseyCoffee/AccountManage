//
//  JSDBaseBackViewController.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDBaseBackViewController.h"

@interface JSDBaseBackViewController ()

@end

@implementation JSDBaseBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
}

- (void)setupNavigation {
 
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(didTapBack:)];
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backButton.image = backImage;
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = nil;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)didTapBack:(id)button {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
