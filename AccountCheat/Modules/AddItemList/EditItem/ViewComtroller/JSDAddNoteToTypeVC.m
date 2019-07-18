//
//  JSDAddNoteToTypeVC.m
//  AccountCheat
//
//  Created by ada on 2019/7/17.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDAddNoteToTypeVC.h"

#import "JSDEditNoteView.h"
#import <MaterialComponents/MaterialTextFields.h>
#import <MaterialButtons.h>

@interface JSDAddNoteToTypeVC ()

@property (strong, nonatomic) JSDEditNoteView *editNoteView;
@property (strong, nonatomic) MDCTextInputControllerFilled *textFieldControllerFloating;
@property (strong, nonatomic) MDCTextInputControllerFilled *accountController;
@property (strong, nonatomic) MDCTextInputControllerFilled *passwrodController;
@property (strong, nonatomic) MDCTextInputControllerFilled *typeController;
@property (strong, nonatomic) MDCTextInputControllerFilled *remarkController;
@property (nonatomic, strong) MDCRaisedButton* saveButton;

@end

@implementation JSDAddNoteToTypeVC

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
    
    self.navigationItem.title = @"添加账户";
    
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
    
    [self.view addSubview:self.editNoteView];
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
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view endEditing:YES];
}

- (void)touchesSaveSender:(MDCButton *)sender {
    
    JSDItemListModel* model = [[JSDItemListModel alloc] init];
    model.name = self.editNoteView.nameTextField.text.length ? self.editNoteView.nameTextField.text : @"";
    model.account = self.editNoteView.accountTextField.text.length ? self.editNoteView.accountTextField.text : @"";
    model.password = self.editNoteView.passwordTextField.text.length ? self.editNoteView.passwordTextField.text : @"";
    model.type = self.editNoteView.selectedFlagColorName.length ? self.editNoteView.selectedFlagColorName : @"";
    //    model.remark = self.editNoteView.remarkTextField.text.length ? self.editNoteView.remarkTextField.text : @"";
    model.remark = self.editNoteView.remarkTextField.text.length ? self.editNoteView.remarkTextField.text : @"";
    
    @weakify(self)
    [self.viewModel addItemModel:model complectionBlock:^{
        @strongify(self)
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"添加成功"];
        [manager showMessage:message];
//        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.selectedIndex = 0;
    }];
}

#pragma mark - 6.Private Methods


- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textFieldWillChange:(NSNotification *)notification {
    
    BOOL name = !(self.textFieldControllerFloating.characterCountMax && [self.textFieldControllerFloating performSelector:@selector(characterCount)] > self.textFieldControllerFloating.characterCountMax);
    BOOL account = !(self.accountController.characterCountMax && [self.accountController performSelector:@selector(characterCount)] > self.accountController.characterCountMax);
    BOOL password = !(self.passwrodController.characterCountMax && [self.passwrodController performSelector:@selector(characterCount)] > self.passwrodController.characterCountMax);
    //    BOOL flag = !(self.typeController.characterCountMax && [self.typeController performSelector:@selector(characterCount)] > self.typeController.characterCountMax);
    BOOL remark = !(self.remarkController.characterCountMax && [self.remarkController performSelector:@selector(characterCount)] > self.remarkController.characterCountMax);
    
    self.saveButton.enabled = self.editNoteView.nameTextField.text.length && name && account && password && remark;
}

#pragma mark - 7.GET & SET

- (JSDEditNoteView *)editNoteView {
    
    if (!_editNoteView)  {
        _editNoteView = [[NSBundle mainBundle] loadNibNamed:@"JSDEditNoteView" owner:nil options:nil].lastObject;
        _editNoteView.frame = self.view.bounds;
        self.textFieldControllerFloating.textInput = _editNoteView.nameTextField;
        //        self.textFieldControllerFloating.normalColor = ColorWithFROMRGB(0xdddddd, 1);
        //        self.textFieldControllerFloating.activeColor = [UIColor blueColor];
        //        self.textFieldControllerFloating.borderFillColor = [UIColor lightGrayColor];
        self.textFieldControllerFloating.placeholderText = @"标题(最长10个字符)";
        self.textFieldControllerFloating.characterCountMax = 10;
        
        MDCTextInputControllerFilled* accountController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_editNoteView.accountTextField];
        //       accountController.textInput = _editNoteView.nameTextField;
        //        accountController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        //        accountController.activeColor = [UIColor blueColor];
        //        accountController.borderFillColor = [UIColor whiteColor];
        accountController.placeholderText = @"账号(最长50个字符)";
        _accountController = accountController;
        accountController.characterCountMax = 50;
        
        MDCTextInputControllerFilled* passwordController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_editNoteView.passwordTextField];
        _passwrodController = passwordController;
        //        passwordController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        //        passwordController.activeColor = [UIColor blueColor];
        //        passwordController.borderFillColor = [UIColor whiteColor];
        passwordController.placeholderText = @"密码(最长50个字符)";
        passwordController.characterCountMax = 50;
        
        //        MDCTextInputControllerFilled* typeController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_editNoteView.typeTextField];
        //        _typeController = typeController;
        ////        typeController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        ////        typeController.activeColor = [UIColor blueColor];
        ////        typeController.borderFillColor = [UIColor whiteColor];
        //        typeController.placeholderText = @"标签(最长50个字符)";
        //        typeController.characterCountMax = 50;
        
        MDCTextInputControllerFilled* remarkController = [[MDCTextInputControllerFilled alloc] initWithTextInput:_editNoteView.remarkTextField];
        _remarkController = remarkController;
        //        remarkController.normalColor = ColorWithFROMRGB(0xdddddd, 1);;
        //        remarkController.activeColor = [UIColor blueColor];
        //        remarkController.borderFillColor = [UIColor whiteColor];
        remarkController.placeholderText = @"备注(最长250个字符)";
        remarkController.characterCountMax = 250;
        remarkController.characterCountViewMode = UITextFieldViewModeWhileEditing;
    }
    return _editNoteView;
}

- (MDCTextInputControllerFilled *)textFieldControllerFloating {
    
    if (!_textFieldControllerFloating) {
        _textFieldControllerFloating = [[MDCTextInputControllerFilled alloc] init];
    }
    return _textFieldControllerFloating;
}

- (UIColor *)activeColor {
    
    return [UIColor redColor];
}

@end

