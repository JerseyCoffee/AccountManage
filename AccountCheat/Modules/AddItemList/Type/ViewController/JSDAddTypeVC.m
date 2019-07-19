//
//  JSDAddTypeVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDAddTypeVC.h"

#import <MaterialButtons.h>
#import <MaterialTextFields.h>
#import "JSDPublic.h"
#import "JSDHomeModel.h"

@interface JSDAddTypeVC ()

@property (weak, nonatomic) IBOutlet MDCButton *addIconButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet MDCTextField *nameTextField;
@property (nonatomic, strong) MDCTextInputControllerUnderline* nameController;
@property (nonatomic, strong) MDCRaisedButton* saveButton;
@property (nonatomic, strong) JSDHomeModel* typeModel;

@end

@implementation JSDAddTypeVC

#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self.nameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.nameTextField endEditing:YES];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"添加分类";
    
    _saveButton = [[MDCRaisedButton alloc] init];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton setTitle:@"保存" forState:UIControlStateDisabled];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_saveButton addTarget:self action:@selector(touchesSaveSender:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_saveButton];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addIconButton.layer.cornerRadius = self.addIconButton.jsd_width / 2;
    self.iconImageView.layer.cornerRadius = self.addIconButton.jsd_width / 2;
    self.iconImageView.backgroundColor = [UIColor jsd_grayColor];
    self.iconImageView.image = [UIImage jsd_imageName:@"mac_note"];
    
    self.nameController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:self.nameTextField];
    self.nameController.activeColor = [UIColor blueColor];
    self.nameController.normalColor = ColorWithFROMRGB(0xdddddd, 1);
    self.nameController.borderFillColor = [UIColor whiteColor];
    self.nameController.placeholderText = @"分类名称(最长15个字符)";
    self.nameController.characterCountMax = 15;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)touchesSaveSender:(MDCButton *)sender {
    
    JSDHomeModel* model = [[JSDHomeModel alloc] init];
//    model.image = self.iconImageView.image ? model.image : @"macNote";
    model.image = @"mac_note";
    model.title = self.nameTextField.text.length ? self.nameTextField.text : @"";
    JSDHomeViewModel* viewModel = [[JSDHomeViewModel alloc] init];
    
    BOOL isContent = NO;
    for (NSInteger i = 0; i < viewModel.typeArray.count; i++ ) {
        if ([viewModel.typeArray[i].title isEqualToString: self.nameTextField.text]) {
            isContent = YES;
            break;
        }
    }
    if (isContent) {
        self.saveButton.enabled = NO;
        MDCSnackbarManager* manage = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"已存在该分类, 请重新输入"];
        [manage showMessage:message];
        
    } else {
        [viewModel.typeArray addObject:model];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kTypeFilePathName];
        NSMutableArray* dataArray = [JSDHomeModel mj_keyValuesArrayWithObjectArray:viewModel.typeArray];
        NSData* data = dataArray.mj_JSONData;
        [data writeToFile:path atomically:YES];
        
        MDCSnackbarManager* manage = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"新增分类成功!"];
        [manage showMessage:message];
        //切换回首页
        [self updateView];
        self.tabBarController.selectedIndex = 0;
        
    }

}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldWillChange:(NSNotification *)notification {
    
    BOOL name = !(self.nameController.characterCountMax && [self.nameController performSelector:@selector(characterCount)] > self.nameController.characterCountMax);

    self.saveButton.enabled = self.nameTextField.text.length && name;
}

- (void)updateView {
    
    self.saveButton.enabled = NO;
    self.nameTextField.text = nil;
    self.iconImageView.image = nil;
}

#pragma mark - 7.GET & SET

@end


