//
//  JSDItemListViewController.m
//  AccountCheat
//
//  Created by ada on 2019/7/13.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemListViewController.h"

#import <MDCCollectionViewFlowLayout.h>
#import "JSDEditNoteVC.h"
#import "JSDPublic.h"

@interface JSDItemListViewController () 

@property (strong, nonatomic) MDCCollectionViewFlowLayout *layout;
@property (nonatomic, strong) JSDItemListViewModel* viewModel;
@property (nonatomic, strong) MDCFloatingButton* addItemButton;

@end

@implementation JSDItemListViewController
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

// TODO: 用通知回调刷新;
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.viewModel updata];
    [self.collectionView reloadData];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
//    self.navigationItem.title = @"网易";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[MDCCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _addItemButton = [[MDCFloatingButton alloc] init];
    [_addItemButton jsd_setsize:CGSizeMake(65, 65)];
    [_addItemButton jsd_setright:ScreenWidth - 30];
    [_addItemButton jsd_setbottom:ScreenHeight - 30];
    [_addItemButton addTarget:self action:@selector(touchAddItemSender:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_addItemButton];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.itemList.count;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MDCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}
//
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth - 50, 100);
}

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
    
    JSDEditNoteVC* editVC = [[JSDEditNoteVC alloc] init];
    [self presentViewController:editVC animated:YES completion:nil];
}

#pragma mark - 5.Event Response

- (void)touchAddItemSender:(MDCButton *)sender {
    
    JSDEditNoteVC* editNoteVC = [[JSDEditNoteVC alloc] init];
    editNoteVC.viewModel = self.viewModel;
    
    [self.navigationController pushViewController:editNoteVC animated:YES];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (JSDItemListViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDItemListViewModel alloc] init];
        _viewModel.type = self.title;
    }
    return _viewModel;
}

@end
