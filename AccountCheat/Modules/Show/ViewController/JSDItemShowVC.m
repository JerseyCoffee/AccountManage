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

@interface JSDItemShowVC ()

@end

@implementation JSDItemShowVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSDItemShowViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
}

- (void)setupNavigation {
    
    self.navigationItem.title = @"详情";
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSDItemShowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = self.model.name;
            break;
        case 1:
            cell.titleLabel.text = self.model.account;
            break;
        case 2:
            cell.titleLabel.text = self.model.password;
            break;
        case 3:
            cell.titleLabel.text = self.model.type;
            break;
        case 4:
            cell.titleLabel.text = self.model.remark;
            break;
        case 5:
            cell.titleLabel.text = self.model.isCollection ? @"已收藏" : @"未收藏";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

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

@end
