//
//  JSDSecurityVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDSecurityVC.h"

#import "JSDSecurityCell.h"

static NSString* kCellIdentifire = @"cellIdentifire";
@interface JSDSecurityVC ()

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
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDSecurityCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifire forIndexPath:indexPath];
    
//    cell.textLabel.text = _content[(NSUInteger)indexPath.section][(NSUInteger)indexPath.item];
    UISwitch *editingSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.accessoryView = editingSwitch;
    
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
            supplementaryView.textLabel.text = @"解锁";
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

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

