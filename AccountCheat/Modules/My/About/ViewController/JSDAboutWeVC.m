//
//  JSDAboutWeVC.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDAboutWeVC.h"

#import "JSDPublic.h"
@interface JSDAboutWeVC ()

@end

@implementation JSDAboutWeVC

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
    self.navigationItem.title = @"关于我们";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor jsd_grayColor];
    
    [self.collectionView registerClass:[MDCCollectionViewTextCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MDCCollectionViewTextCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"App 版本";
        cell.detailTextLabel.text = @"1.0.0";
        
    } else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"App 评分";
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.text = @"非常感谢你使用我们App, 如果您喜欢它,请点击前往评论页进行评论!";
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"数据安全";
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.text = @"请放心,该 App 数据信息(账号密码等)仅存储在手机内, 不会再服务器进行备份";
    } else {
        
        cell.detailTextLabel.numberOfLines = 2;
        cell.textLabel.text = @"官网";
        cell.detailTextLabel.text = @"https://www.jianshu.com/p/216691edbd0d";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    if (indexPath.row == 1) {
        NSString* appId = @"1473619521";
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action=write-review", appId];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    } else if (indexPath.row == 3) {
        JSDSnackManage* snackManage = [JSDSnackManage sharedInstance];
        UIPasteboard* pasterboard = [[UIPasteboard alloc] init];
        //TODO:官网
        pasterboard.string = @"https://www.jianshu.com/p/216691edbd0d";
        [snackManage showText:@"官网已复制到剪切板"];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    
    return CGSizeMake(size.width, 100);
}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

