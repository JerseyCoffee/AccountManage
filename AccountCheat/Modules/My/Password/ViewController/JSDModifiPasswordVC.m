//
//  JSDModifiPasswordVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDModifiPasswordVC.h"

#import "JSDUserDataManage.h"

@interface JSDModifiPasswordVC ()

@property (nonatomic, strong) MDCTextField* originalPasswrod;
@property (nonatomic, strong) MDCTextField* passwrod;
@property (nonatomic, strong) MDCTextField* confirmPasswrod;
@property (nonatomic, strong) MDCTextInputControllerFilled* passwrodController;
@property (nonatomic, strong) MDCTextInputControllerFilled* confirmPasswrodController;
@property (nonatomic, strong) MDCTextInputControllerFilled* originalPasswrodController;

@property (nonatomic, strong) MDCRaisedButton* saveButton;

@end

@implementation JSDModifiPasswordVC

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

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.originalPasswrod becomeFirstResponder];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.navigationItem.title = @"修改密码";
    
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
    
    [self.view addSubview:self.originalPasswrod];
    [self.view addSubview:self.passwrod];
    [self.view addSubview:self.confirmPasswrod];
    
    [self.originalPasswrod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(80);
    }];
    
    [self.passwrod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.originalPasswrod);
        make.top.mas_equalTo(self.originalPasswrod.mas_bottom).mas_offset(30);
    }];
    
    [self.confirmPasswrod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.passwrod);
        make.top.mas_equalTo(self.passwrod.mas_bottom).mas_offset(30);
    }];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)onTouchSave:(MDCRaisedButton* )sender {
    JSDSnackManage* manage = [JSDSnackManage sharedInstance];
    if (JSDIsString(self.originalPasswrod.text) && JSDIsString(self.passwrod.text) && JSDIsString(self.confirmPasswrod.text)) {
        
        JSDUserDataManage* userMamage = [JSDUserDataManage sharedInstance];
        //校验原密码;
        if ([self.originalPasswrod.text isEqualToString:userMamage.passwordModel.passwrod] || [self.originalPasswrod.text isEqualToString:userMamage.passwordModel.passwordKey] ||  [kJSDAppPasswrod isEqualToString:self.originalPasswrod.text]) {
            if ([self.passwrod.text isEqualToString:self.confirmPasswrod.text]) {
                userMamage.passwordModel.passwrod = self.passwrod.text;
                [userMamage savePassData];
                [self dismissViewControllerAnimated:YES completion:^{
                    [manage showText:@"设置密码成功"];
                }];
            } else {
                //两次密码不一致
                [manage showText:@"请确保密码与确认密码一致"];
            }
        } else {
            // 原密码错误;
            [manage showText:@"请输入正确的原密码或密保"];
        }
    } else {
        [manage showText:@"请输入密码"];
    }
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldWillChange:(NSNotification *)notification {
    
    BOOL isAccord = NO;
    if (JSDIsString(self.originalPasswrod.text) && JSDIsString(self.passwrod.text) && JSDIsString(self.confirmPasswrod.text)) {
        if ([self.passwrod.text isEqualToString:self.confirmPasswrod.text]) {
            isAccord = YES;
        } else {
            
        }
    } else {
        
    }
    self.saveButton.enabled = isAccord;
}

#pragma mark - 7.GET & SET

- (MDCTextField *)passwrod {
    
    if (!_passwrod) {
        _passwrod = [[MDCTextField alloc] init];
        _passwrodController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_passwrod];
        _passwrodController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        _passwrodController.activeColor = [UIColor blueColor];
        _passwrodController.borderFillColor = [UIColor whiteColor];
        _passwrodController.placeholderText = @"新密码(最长32个字符)";
        _passwrodController.characterCountMax = 32;
    }
    return _passwrod;
}

- (MDCTextField *)confirmPasswrod {
    
    if (!_confirmPasswrod) {
        _confirmPasswrod = [[MDCTextField alloc] init];
        _confirmPasswrodController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_confirmPasswrod];
        _confirmPasswrodController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        _confirmPasswrodController.activeColor = [UIColor blueColor];
        _confirmPasswrodController.borderFillColor = [UIColor whiteColor];
        _confirmPasswrodController.placeholderText = @"确认密码(最长32个字符)";
        _confirmPasswrodController.characterCountMax = 32;
    }
    return _confirmPasswrod;
}

- (MDCTextField *)originalPasswrod {
    
    if (!_originalPasswrod) {
        _originalPasswrod = [[MDCTextField alloc] init];
        _originalPasswrodController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_originalPasswrod];
        _originalPasswrodController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        _originalPasswrodController.activeColor = [UIColor blueColor];
        _originalPasswrodController.borderFillColor = [UIColor whiteColor];
        _originalPasswrodController.placeholderText = @"原密码或密保(最长32个字符)";
        _originalPasswrodController.characterCountMax = 32;
    }
    return _originalPasswrod;
}

@end
