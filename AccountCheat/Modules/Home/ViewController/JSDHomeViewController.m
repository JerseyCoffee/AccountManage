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
#import "JSDPublic.h"
#import <MaterialBottomNavigation.h>
#import "JSDItemListViewController.h"
#import "JSDHomeCollectionViewCell.h"
#import "JSDHomeModel.h"
#import <MaterialComponents/MaterialButtons.h>
#import "JSDAddTypeVC.h"
#import "JSDItemListVC.h"
#import "JSDSearchViewController.h"

static NSString* kJSDHomeCellIdentifier = @"kJSDHomeCellIdentifier";

@interface JSDHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) MDCCollectionViewFlowLayout *layout;
@property (strong, nonatomic) MDCBottomNavigationBar *bottomNavBar;
@property (nonatomic, strong) JSDHomeViewModel* viewModel;
@property (nonatomic, strong) MDCFloatingButton* addTypeButton;
@property (nonatomic, strong) MDCFloatingButton* searchButton;

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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.viewModel updateData];
    [self.collectionView reloadData];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
//    self.bottomNavBar = [[MDCBottomNavigationBar alloc] init];
//    
//    // Disable inclusion of safe area in size calculations.
//    self.bottomNavBar.sizeThatFitsIncludesSafeArea = YES;
//    [self.view addSubview:self.bottomNavBar];
//    [self layoutBottomNavBar];
    
    self.navigationItem.title = @"首页";
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

    [self.collectionView registerNib:[UINib nibWithNibName:@"JSDHomeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kJSDHomeCellIdentifier];
    
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    _addTypeButton = [[MDCFloatingButton alloc] init];
    [_addTypeButton jsd_setsize:CGSizeMake(65, 65)];
    [_addTypeButton setcenterX:ScreenWidth / 2];
    [_addTypeButton jsd_setbottom:ScreenHeight - 30];
    [_addTypeButton addTarget:self action:@selector(touchAddTypeSender:) forControlEvents:UIControlEventTouchUpInside];
    [_addTypeButton setBackgroundImage:JSDImageOfFile(@"add") forState:UIControlStateNormal];
    _addTypeButton.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_addTypeButton];
    
    _searchButton = [[MDCFloatingButton alloc] init];
    [_searchButton jsd_setsize:CGSizeMake(50, 50)];
    [_searchButton jsd_setright:ScreenWidth - 30];
    [_searchButton jsd_setbottom:ScreenHeight - 30];
    [_searchButton addTarget:self action:@selector(touchSearchSender:) forControlEvents:UIControlEventTouchUpInside];
    [_searchButton setBackgroundImage:JSDImageOfFile(@"search") forState:UIControlStateNormal];
    _searchButton.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_searchButton];
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
    return self.viewModel.typeArray.count;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    JSDHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kJSDHomeCellIdentifier forIndexPath:indexPath];
    
    [cell setModel:self.viewModel.typeArray[indexPath.row]];

    return cell;
}
//
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 50) / 2, 100);
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
    return UIEdgeInsetsMake(10, 15, 10, 15);
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
//    JSDItemListViewController* listVC = [[JSDItemListViewController alloc] init];
    JSDItemListVC* listVC = [[JSDItemListVC alloc] init];
    
    NSInteger index = indexPath.row;
    NSString* typeName = [self.viewModel.typeArray objectAtIndex:index].title;
    listVC.title = typeName;
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark - 5.Event Response

- (void)touchAddTypeSender:(MDCFloatingButton *)sender {
    
    JSDAddTypeVC* addTypeVC = [[JSDAddTypeVC alloc] init];
    
    [self.navigationController pushViewController:addTypeVC animated:YES];
}

- (void)touchSearchSender:(MDCFloatingButton *)sender {
    
    JSDSearchViewController* searchVC = [[JSDSearchViewController alloc] init];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    
    [self presentViewController:navigationVC animated:YES completion:nil];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

#pragma mark - 7.GET & SET

- (JSDHomeViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDHomeViewModel alloc] init];
    }
    return _viewModel;
}

@end

