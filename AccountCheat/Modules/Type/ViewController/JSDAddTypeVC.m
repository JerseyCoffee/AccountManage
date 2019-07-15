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
    self.iconImageView.backgroundColor = [UIColor grayColor];
    
    self.nameController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:self.nameTextField];
    self.nameController.activeColor = [UIColor blueColor];
    self.nameController.normalColor = [UIColor grayColor];
    self.nameController.borderFillColor = [UIColor grayColor];
    self.nameController.placeholderText = @"分类名称";
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
    model.image = self.iconImageView.image ? model.image : @"";
    model.title = self.nameTextField.text.length ? self.nameTextField.text : @"";
    JSDHomeViewModel* viewModel = [[JSDHomeViewModel alloc] init];
    [viewModel.typeArray addObject:model];
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kTypeFilePathName];
    NSMutableArray* dataArray = [JSDHomeModel mj_keyValuesArrayWithObjectArray:viewModel.typeArray];
    NSData* data = dataArray.mj_JSONData;
    [data writeToFile:path atomically:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldWillChange:(NSNotification *)notification {

    self.saveButton.enabled = self.nameTextField.text.length;
}

#pragma mark - 7.GET & SET

@end


