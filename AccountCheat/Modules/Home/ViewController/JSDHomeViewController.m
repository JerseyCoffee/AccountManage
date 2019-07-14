//
//  JSDHomeViewController.m
//  AccountCheat
//
//  Created by ada on 2019/7/11.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDHomeViewController.h"

#import <MaterialComponents/MDCCollectionViewCell.h>
#import <MaterialComponents/MDCCollectionViewFlowLayout.h>
#import <MaterialComponents/MDCCardCollectionCell.h>
#import <MaterialComponents/MDCCard.h>
#import <MaterialComponents/MaterialChips.h>
#import "JSDPublic.h"
#import <MaterialBottomNavigation.h>
#import "JSDItemListViewController.h"

@interface JSDHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) MDCCollectionViewFlowLayout *layout;
@property (strong, nonatomic) MDCBottomNavigationBar *bottomNavBar;

@end

@implementation JSDHomeViewController

#pragma mark - 1.View Controller Life Cycle

- (instancetype)init {
    
    _layout = [[MDCCollectionViewFlowLayout alloc] init];
    
    return [self initWithCollectionViewLayout:_layout];
}

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

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    CGSize size = [_bottomNavigationBar sizeThatFits:self.view.bounds.size];
//    CGRect bottomNavBarFrame = CGRectMake(0,
//                                          CGRectGetHeight(self.view.bounds) - size.height,
//                                          size.width,
//                                          size.height);
//    _bottomNavigationBar.frame = bottomNavBarFrame;
//}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
//    self.bottomNavBar = [[MDCBottomNavigationBar alloc] init];
//    
//    // Disable inclusion of safe area in size calculations.
//    self.bottomNavBar.sizeThatFitsIncludesSafeArea = YES;
//    [self.view addSubview:self.bottomNavBar];
//    [self layoutBottomNavBar];
    
}

- (void)layoutBottomNavBar {
    CGRect viewBounds = CGRectStandardize(self.view.bounds);
    CGSize size = [self.bottomNavBar sizeThatFits:viewBounds.size];
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    // Extend the Bottom Navigation to the bottom of the screen.
    if (@available(iOS 11.0, *)){
        safeAreaInsets = self.view.safeAreaInsets;
    }
    CGRect bottomNavBarFrame =
    CGRectMake(0, viewBounds.size.height - size.height - safeAreaInsets.bottom, size.width,
               size.height + safeAreaInsets.bottom);
    self.bottomNavBar.frame = bottomNavBarFrame;
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MDCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark collectionView代理方法
//返回section个数
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MDCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

//    cell.accessoryView.backgroundColor = [UIColor redColor];
//    cell.contentView.backgroundColor = [UIColor clearColor];

    return cell;
}
//
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 100) / 2, 100);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 30, 10, 30);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    JSDItemListViewController* listVC = [[JSDItemListViewController alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

//- (UICollectionViewFlowLayout *)collectionViewLayout {
//
//    if (!_collectionViewLayout) {
//        _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
//        [_collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        _collectionViewLayout.headerReferenceSize = CGSizeZero;
//        _collectionViewLayout.itemSize = CGSizeMake(150, 200);
////        [_collectionViewLayout registerClass:[MDCCollectionViewCell class] forDecorationViewOfKind:@"cell"];
//
//    }
//    return _collectionViewLayout;
//}
//
//- (UICollectionView *)collectionView {
//
//    if (!_collectionView) {
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        [_collectionView registerClass:[MDCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    }
//    return _collectionView;
//}

@end

