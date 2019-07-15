//
//  JSDEditNoteViewController.m
//  AccountCheat
//
//  Created by ada on 2019/7/13.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDEditNoteVC.h"

#import "JSDEditNoteView.h"
#import <MaterialComponents/MaterialTextFields.h>
#import <MaterialButtons.h>

@interface JSDEditNoteVC () 

@property (strong, nonatomic) JSDEditNoteView *editNoteView;
@property (strong, nonatomic) MDCTextInputControllerUnderline *textFieldControllerFloating;
@property (strong, nonatomic) MDCTextInputControllerUnderline *accountController;
@property (strong, nonatomic) MDCTextInputControllerUnderline *passwrodController;
@property (strong, nonatomic) MDCTextInputControllerUnderline *typeController;
@property (strong, nonatomic) MDCTextInputControllerLegacyDefault *remarkController;
@property (nonatomic, strong) MDCRaisedButton* saveButton;

@end

@implementation JSDEditNoteVC

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
}

- (void)touchesSaveSender:(MDCButton *)sender {
    
    
    JSDItemListModel* model = [[JSDItemListModel alloc] init];
    model.name = self.editNoteView.nameTextField.text.length ? self.editNoteView.nameTextField.text : @"";
    model.account = self.editNoteView.accountTextField.text.length ? self.editNoteView.accountTextField.text : @"";
    model.password = self.editNoteView.passwordTextField.text.length ? self.editNoteView.passwordTextField.text : @"";
    model.type = self.editNoteView.typeTextField.text.length ? self.editNoteView.typeTextField.text : @"";
    //    model.remark = self.editNoteView.remarkTextField.text.length ? self.editNoteView.remarkTextField.text : @"";
    model.remark = @"啊哈";
    
    @weakify(self)
    [self.viewModel addItemModel:model complectionBlock:^{
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark - 6.Private Methods


- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldWillChange:(NSNotification *)notification {
    
    self.saveButton.enabled = self.editNoteView.nameTextField.text.length;
}


#pragma mark - 7.GET & SET

- (JSDEditNoteView *)editNoteView {
    
    if (!_editNoteView)  {
        _editNoteView = [[NSBundle mainBundle] loadNibNamed:@"JSDEditNoteView" owner:nil options:nil].lastObject;
        _editNoteView.frame = self.view.bounds;
        self.textFieldControllerFloating.textInput = _editNoteView.nameTextField;
        self.textFieldControllerFloating.normalColor = [UIColor grayColor];
        self.textFieldControllerFloating.activeColor = [UIColor blueColor];
        self.textFieldControllerFloating.borderFillColor = [UIColor lightGrayColor];
        self.textFieldControllerFloating.placeholderText = @"名称";
        
        MDCTextInputControllerUnderline* accountController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:_editNoteView.accountTextField];
//       accountController.textInput = _editNoteView.nameTextField;
       accountController.normalColor = [UIColor grayColor];
       accountController.activeColor = [UIColor blueColor];
       accountController.borderFillColor = [UIColor lightGrayColor];
       accountController.placeholderText = @"账号";
       _accountController = accountController;
        
        MDCTextInputControllerUnderline* passwordController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:_editNoteView.passwordTextField];
        _passwrodController = passwordController;
        passwordController.normalColor = [UIColor grayColor];
        passwordController.activeColor = [UIColor blueColor];
        passwordController.borderFillColor = [UIColor lightGrayColor];
        passwordController.placeholderText = @"密码";
        
        MDCTextInputControllerUnderline* typeController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:_editNoteView.typeTextField];
        _typeController = typeController;
        typeController.normalColor = [UIColor grayColor];
        typeController.activeColor = [UIColor blueColor];
        typeController.borderFillColor = [UIColor lightGrayColor];
        typeController.placeholderText = @"分类";
        
        MDCTextInputControllerLegacyDefault* remarkController = [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:_editNoteView.remarkTextField];
       _remarkController = remarkController;
       remarkController.normalColor = [UIColor grayColor];
       remarkController.activeColor = [UIColor blueColor];
       remarkController.borderFillColor = [UIColor lightGrayColor];
       remarkController.placeholderText = @"备注";
    }
    return _editNoteView;
}

- (MDCTextInputControllerUnderline *)textFieldControllerFloating {
    
    if (!_textFieldControllerFloating) {
        _textFieldControllerFloating = [[MDCTextInputControllerUnderline alloc] init];
    }
    return _textFieldControllerFloating;
}

- (UIColor *)activeColor {
    
    return [UIColor redColor];
}

@end
