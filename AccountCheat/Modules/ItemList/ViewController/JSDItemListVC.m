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
@interface JSDItemListVC () <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate, JSDItemTableCellDelegate>

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
        make.left.right.top.mas_equalTo(0);
        if (@available(iOS 11.0,*)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.bottom.mas_equalTo(0);
        }
    }];
    
    _addItemButton = [[MDCFloatingButton alloc] init];
    [_addItemButton jsd_setsize:CGSizeMake(65, 65)];
    [_addItemButton jsd_setright:ScreenWidth - 30];
    [_addItemButton jsd_setbottom:ScreenHeight - 30];
    [_addItemButton addTarget:self action:@selector(touchAddItemSender:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_addItemButton];
    [_addItemButton setBackgroundImage:JSDImageOfFile(@"add") forState:UIControlStateNormal];
    _addItemButton.backgroundColor = [UIColor clearColor];
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
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JSDItemTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kItemCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JSDItemTableCell" owner:nil options:nil].lastObject;
    }
    
    cell.delegate = self;
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"编辑" backgroundColor:[UIColor blueColor]],
                          [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]]
                          ];
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    cell.viewModel = self.viewModel.itemList[indexPath.section];
    cell.section = indexPath.section;
    cell.itemdelegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* header = [[UIView alloc] init];
    header.backgroundColor = [UIColor jsd_grayColor];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView* footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor jsd_grayColor];
    
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showItemModel:self.viewModel.itemList[indexPath.section]];
}

#pragma mark - MGSwipeTableCellDelegate

- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion {
    
    JSDItemTableCell* itemCell = (JSDItemTableCell *)cell;
    NSLog(@"%ld", itemCell.section);
    switch (index) {
        case 1:{ //删除
        [self deleteItemModel: itemCell.viewModel];
        }
            break;
        case 0:{ //编辑
        [self editItemModel: itemCell.viewModel];
        }
        default:
            break;
    }
    return YES;
}

#pragma mark - JSDItemTableCellDelegate

- (void)onTouchCollectionWithModel:(JSDItemListModel *)model {
    
    NSLog(@"点击收藏");
    model.isCollection = !model.isCollection; //取反
    
    [self.viewModel replaceItemModel:model complectionBlock:^{
//        [self.tableView reloadData];
    }];
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

- (void)deleteItemModel:(JSDItemListModel *)model {
    
    @weakify(self)
    [self.viewModel removeItemModel:model complectionBlock:^{
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (void)showItemModel:(JSDItemListModel *)model {
    
    JSDItemShowVC* showVC = [[JSDItemShowVC alloc] init];
    showVC.model = model;
    showVC.title = model.name;
    
    [self.navigationController pushViewController:showVC animated:YES];
}

- (void)editItemModel:(JSDItemListModel *)model {
    
    JSDEditNoteVC* editVC = [[JSDEditNoteVC alloc] init];
    editVC.model = model;
    
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - 7.GET & SET

- (UITableView *)tableView {
    
    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"JSDItemTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kItemCellIdentifier];
        _tableView.backgroundColor = [UIColor jsd_grayColor];
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
