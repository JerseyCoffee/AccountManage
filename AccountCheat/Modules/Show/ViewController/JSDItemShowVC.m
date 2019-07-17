//
//  JSDItemShowVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemShowVC.h"

#import "JSDItemShowViewCell.h"
#import <MaterialSnackbar.h>
#import <MDCCollectionViewTextCell.h>
#import "JSDEditNoteVC.h"

@interface JSDItemShowVC ()

@end

@implementation JSDItemShowVC

static NSString * const reuseIdentifier = @"Cell";
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
    self.navigationItem.title = @"";
    self.navigationItem.title = @"详情";
    
    MDCFlatButton* editButton = [[MDCFlatButton alloc] init];
    [editButton setTitle:@"编辑" forState: UIControlStateNormal];
    [editButton addTarget:self action:@selector(onTouchEdit:) forControlEvents: UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSDItemShowViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark -4 <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDItemShowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = self.model.name;
            cell.detailLabel.text = @"标题";
            break;
        case 1:
            cell.titleLabel.text = self.model.account;
            cell.detailLabel.text = @"账号";
            break;
        case 2:
            cell.titleLabel.text = self.model.password;
            cell.detailLabel.text = @"密码";
            break;
        case 3:
            cell.titleLabel.text = self.model.type;
            cell.detailLabel.text = @"标签";
            break;
        case 4:
            cell.titleLabel.text = self.model.remark;
            cell.detailLabel.text = @"备注";
            break;
        case 5:
            cell.titleLabel.text = self.model.isCollection ? @"已收藏" : @"未收藏";
            cell.detailLabel.text = @"收藏";
            break;
        default:
            break;
    }
    if (indexPath.row == 4) {
        cell.titleLabel.numberOfLines = 0;
    } else {
        cell.titleLabel.numberOfLines = 2;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    NSString* copyString;
    switch (indexPath.row) {
        case 0:
            copyString = self.model.name;
            break;
        case 1:
            copyString = self.model.account;
            break;
        case 2:
            copyString = self.model.password;
            break;
        case 3:
            copyString = self.model.type;
            break;
        case 4:
            copyString = self.model.remark;
            break;
        case 5:
            copyString = self.model.isCollection ? @"已收藏" : @"为收藏";
            break;
        default:
            break;
    }
    if (copyString.length) {
        UIPasteboard* pasteboard =  [UIPasteboard generalPasteboard];
        pasteboard.string = copyString;
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:[NSString stringWithFormat:@"已复制到剪切板:%@", copyString]];
        [manager showMessage:message];
    }
}

#pragma mark UICollectionLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        return CGSizeMake(ScreenWidth - 20, 200);
    }
   return [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - 5.Event Response

//TODO: 编辑功能未实现; 唯一标识问题
- (void)onTouchEdit:(id) sender {
    
    JSDEditNoteVC* editVC = [[JSDEditNoteVC alloc] init];
    
    editVC.model = self.model;
    editVC.viewModel = self.viewModel;
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

