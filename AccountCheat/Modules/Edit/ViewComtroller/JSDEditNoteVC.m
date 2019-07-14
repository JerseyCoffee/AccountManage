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

@interface JSDEditNoteVC () 

@property (strong, nonatomic) JSDEditNoteView *editNoteView;
@property (strong, nonatomic) MDCTextInputControllerUnderline *textFieldControllerFloating;

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

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDEditNoteView *)editNoteView {
    
    if (!_editNoteView)  {
        _editNoteView = [[NSBundle mainBundle] loadNibNamed:@"JSDEditNoteView" owner:nil options:nil].lastObject;
        _editNoteView.frame = self.view.bounds;
        self.textFieldControllerFloating.textInput = _editNoteView.nameTextField;
        self.textFieldControllerFloating.normalColor = [UIColor grayColor];
        self.textFieldControllerFloating.activeColor = [UIColor blueColor];
        self.textFieldControllerFloating.borderFillColor = [UIColor yellowColor];
        self.textFieldControllerFloating.placeholderText = @"名称";
//        self.textFieldControllerFloating.
        
        MDCTextInputControllerUnderline* accountController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:_editNoteView.accountTextField];
        MDCTextInputControllerUnderline* passwordController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:_editNoteView.passwordTextField];
        MDCTextInputControllerUnderline* typeController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:_editNoteView.typeTextField];
        MDCTextInputControllerBase* remarkController = [[MDCTextInputControllerBase alloc] initWithTextInput:_editNoteView.remarkTextField];
        remarkController.borderFillColor = [UIColor whiteColor];
        
//        MDCTextInputControllerOutlined* outLined = [[MDCTextInputControllerOutlined alloc] initWithTextInput:_editNoteView.accountTextField];
//        MDCTextInputControllerFilled* filled = [[MDCTextInputControllerFilled alloc] initWithTextInput:_editNoteView.passwordTextField];
//        MDCTextInputControllerFullWidth* fullWidth = [[MDCTextInputControllerFullWidth alloc] initWithTextInput:_editNoteView.typeTextField];
//        fullWidth.backgroundColor = [UIColor yellowColor];
//        MDCTextInputControllerLegacyDefault* defaultt = [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:_editNoteView.remarkTextField];
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
