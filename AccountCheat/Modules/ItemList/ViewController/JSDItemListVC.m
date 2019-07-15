//
//  JSDItemListVC.m
//  AccountCheat
//
//  Created by ada on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemListVC.h"

#import "JSDItemTableCell.h"
#import "JSDPublic.h"
#import "JSDItemShowVC.h"
#import "JSDEditNoteVC.h"

static NSString *const kItemCellIdentifier = @"ItemCellIdentifier";
@interface JSDItemListVC () <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) JSDItemListViewModel* viewModel;
@property (nonatomic, strong) MDCFloatingButton* addItemButton;

@end

@implementation JSDItemListVC

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

// TODO: 用通知回调刷新;
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.viewModel updata];
    [self.tableView reloadData];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewModel.itemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDItemTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kItemCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JSDItemTableCell" owner:nil options:nil].lastObject;
    }
    
    cell.delegate = self;
    cell.backgroundColor = [UIColor blueColor];
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor]],
                          [MGSwipeButton buttonWithTitle:@"More" backgroundColor:[UIColor lightGrayColor]]];
    cell.rightSwipeSettings.transition = indexPath.section;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView* footerView = [[UIView alloc] init];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MGSwipeTableCellDelegate

- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion {
    
    NSLog(@"选中");
    
    return YES;
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

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"JSDItemTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kItemCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (JSDItemListViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[JSDItemListViewModel alloc] init];
        _viewModel.type = self.title;
    }
    return _viewModel;
}

@end
