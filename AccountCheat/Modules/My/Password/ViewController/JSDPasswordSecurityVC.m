//
//  JSDPasswordSecurityVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDPasswordSecurityVC.h"

@interface JSDPasswordSecurityVC ()

@property (nonatomic, strong) MDCTextField* passwordKey;
@property (nonatomic, strong) MDCTextInputControllerFilled* passwordKeyController;
@property (nonatomic, strong) MDCTextField* updatePasswordKey;
@property (nonatomic, strong) MDCTextInputControllerFilled* updatePasswordKeyKeyController;

@property (nonatomic, strong) JSDUserDataManage* userDataManage;
@property (nonatomic, assign) BOOL havaPasswordKey;
@property (nonatomic, strong) MDCRaisedButton* saveButton;
@property (nonatomic, strong) UILabel* tipLabel;

@end

@implementation JSDPasswordSecurityVC

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

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {

    if (JSDIsString(self.userDataManage.passwordModel.passwordKey)) {
        self.navigationItem.title = @"修改密保";
        self.havaPasswordKey = YES;
    } else {
        self.navigationItem.title = @"首次设置密保";
        self.havaPasswordKey = NO;
    }
    
    MDCRaisedButton* saveButton = [[MDCRaisedButton alloc] init];
    _saveButton = saveButton;
    [_saveButton setTitle:@"保存" forState: UIControlStateNormal];
    [_saveButton setTitle:@"保存" forState: UIControlStateDisabled];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    _saveButton.enabled = NO;
    [_saveButton addTarget:self action:@selector(onTouchSave:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_saveButton];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_grayColor];
    
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
    [self.view addSubview:self.passwordKey];
    
    [self.passwordKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_equalTo(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(80);
    }];
    
    if (self.havaPasswordKey) {
        [self.view addSubview:self.updatePasswordKey];
        [self.updatePasswordKey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.passwordKey);
            make.top.mas_equalTo(self.passwordKey.mas_bottom).mas_offset(30);
        }];
    }
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)onTouchSave:(MDCRaisedButton* )sender {
    
    JSDSnackManage* snackManage = [JSDSnackManage sharedInstance];
    if (self.havaPasswordKey) {

        if (JSDIsString(self.passwordKey.text)) {
            if ([self.userDataManage.passwordModel.passwordKey isEqualToString:self.passwordKey.text]) { //校验
                if (JSDIsString(self.updatePasswordKey.text)) {
                    
                    self.userDataManage.passwordModel.passwordKey = self.updatePasswordKey.text;
                    [self.userDataManage savePassData];
                    [self dismissViewControllerAnimated:YES completion:^{
                        [snackManage showText:@"修改新密保成功"];
                    }];
                } else {
                    [snackManage showText:@"请输入新密保"];
                    sender.enabled = NO;
                }
            } else {
                [snackManage showText:@"原密保不正确, 请重新输入"];
                sender.enabled = NO;
            }
        } else {
            [snackManage showText:@"请输入密保"];
            sender.enabled = NO;
        }
        
    } else {
        if (JSDIsString(self.passwordKey.text)) {
            self.userDataManage.passwordModel.passwordKey = self.passwordKey.text;
            [self.userDataManage savePassData];
            
            [self dismissViewControllerAnimated:YES completion: ^{
                [snackManage showText:@"修改新密保成功"];
            }];
        } else {
            [snackManage showText:@"请输入密保"];
            sender.enabled = NO;
        }
    }
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldWillChange:(NSNotification *)notification {
    
    BOOL isAccord = NO;
    if (self.havaPasswordKey) {
        isAccord = JSDIsString(self.passwordKey.text);
    } else {
        isAccord = JSDIsString(self.passwordKey.text) && JSDIsString(self.updatePasswordKey.text);
    }
    self.saveButton.enabled = isAccord;
}

#pragma mark - 7.GET & SET

- (JSDUserDataManage *)userDataManage {
    
    if (!_userDataManage) {
        _userDataManage = [JSDUserDataManage sharedInstance];
    }
    return _userDataManage;
}

- (MDCTextField *)passwordKey {
    
    if (!_passwordKey) {
        _passwordKey = [[MDCTextField alloc] init];
        _passwordKeyController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_passwordKey];
        _passwordKeyController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        _passwordKeyController.activeColor = [UIColor blueColor];
        _passwordKeyController.borderFillColor = [UIColor whiteColor];
        _passwordKeyController.placeholderText = self.havaPasswordKey ? @"原密保(最长32个字符)" : @"新密保(建议最长32个字符)";
        _passwordKeyController.characterCountMax = 32;
    }
    return _passwordKey;
}

- (MDCTextField *)updatePasswordKey {
    
    if (!_updatePasswordKey) {
        _updatePasswordKey = [[MDCTextField alloc] init];
        _updatePasswordKeyKeyController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_updatePasswordKey];
        _updatePasswordKeyKeyController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        _updatePasswordKeyKeyController.activeColor = [UIColor blueColor];
        _updatePasswordKeyKeyController.borderFillColor = [UIColor whiteColor];
        _updatePasswordKeyKeyController.placeholderText = @"新密保(建议最长32个字符)";
        _updatePasswordKeyKeyController.characterCountMax = 32;
    }
    return _updatePasswordKey;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:18];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.text = @"请自行保管好密保, 可用于找回密码";
    }
    return _tipLabel;
}
    
@end

