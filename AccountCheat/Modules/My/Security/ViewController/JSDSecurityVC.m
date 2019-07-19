//
//  JSDSecurityVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDSecurityVC.h"

#import "JSDSecurityCell.h"
#import "JSDSwitch.h"
static NSString* kCellIdentifire = @"cellIdentifire";

@interface JSDSecurityVC ()

@property (nonatomic, strong) JSDSecurityViewModel* viewModel;
@property (nonatomic, strong) JSDUserDataManage* userDataManage;

@end

@implementation JSDSecurityVC

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
    
    [self.userDataManage savePassData];
    
    [super viewWillDisappear:animated];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.navigationItem.title = @"安全相关";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_grayColor];
    
    // Register cell.
    [self.collectionView registerClass:[JSDSecurityCell class]
            forCellWithReuseIdentifier:kCellIdentifire];
    
    // Register header.
    [self.collectionView registerClass:[MDCCollectionViewTextCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:UICollectionElementKindSectionHeader];
    
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.viewModel.array.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewModel.array[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDSecurityCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifire forIndexPath:indexPath];
    JSDSecurityModel* model = self.viewModel.array[indexPath.section][indexPath.row];
    
    JSDSwitch *editingSwitch = [[JSDSwitch alloc] initWithFrame:CGRectZero];
    editingSwitch.model = model;
    editingSwitch.on = model.isOpen;
    [editingSwitch addTarget:self action:@selector(onTouchSwitch:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = editingSwitch;
    cell.textLabel.text = model.title;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    MDCCollectionViewTextCell *supplementaryView =
    [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                       withReuseIdentifier:kind
                                              forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            supplementaryView.textLabel.text = @"开启 App 解锁方式";
        } else if (indexPath.section == 1) {
            supplementaryView.textLabel.text = @"Notification";
        }
        supplementaryView.textLabel.textColor = [UIColor colorWithRed:0 green:0.67f blue:0.55f alpha:1.f];
    }
    return supplementaryView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(collectionView.bounds.size.width, MDCCellDefaultOneLineHeight);
}

#pragma mark - 5.Event Response

- (void)onTouchSwitch:(JSDSwitch *)sender {
    
    JSDSecurityModel* model = sender.model;
    if ([model.type isEqualToString:@"密码"]) {
        if (JSDIsString(model.tipTitle)) { //用户未设置过密码, 提示去设置密码;
            JSDSnackManage* manage = [JSDSnackManage sharedInstance];
            [manage showText: model.tipTitle];
            sender.on = NO;
        } else {
            //修改启动方式
//            model.isOpen = sender.isOn; //TODO: 延时保存
            self.userDataManage.passwordModel.usePassword = sender.isOn;
            [self.userDataManage savePassData];
        }
    } else if ([model.type isEqualToString:@"指纹"]) {
//        model.isOpen = sender.isOn;
        self.userDataManage.passwordModel.useFingerprint = sender.isOn;
        [self.userDataManage savePassData];
    }
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDSecurityViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDSecurityViewModel alloc] init];
    }
    return _viewModel;
}

- (JSDUserDataManage *)userDataManage {
    
    if (!_userDataManage) {
        _userDataManage = [JSDUserDataManage sharedInstance];
    }
    return _userDataManage;
}


@end

