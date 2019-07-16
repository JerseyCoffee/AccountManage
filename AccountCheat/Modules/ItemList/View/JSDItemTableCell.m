//
//  JSDItemTableCell.m
//  AccountCheat
//
//  Created by ada on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemTableCell.h"

#import "JSDPublic.h"

@interface JSDItemTableCell ()

@property (weak, nonatomic) IBOutlet UIView *flagBackgroundView;
@property (weak, nonatomic) IBOutlet MDCButton *flagButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwrodLabel;
@property (weak, nonatomic) IBOutlet MDCButton *collectionButton;

@end

@implementation JSDItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.collectionButton setImage:JSDImageOfFile(@"collection_default") forState:UIControlStateNormal];
//    [self.collectionButton setImage:JSDImageOfFile(@"collection_selected") forState:UIControlStateSelected];
    
    [self.collectionButton setBackgroundImage:JSDImageOfFile(@"collection_default") forState:UIControlStateNormal];
    [self.collectionButton setBackgroundImage:JSDImageOfFile(@"collection_selected") forState:UIControlStateSelected];
    [self.collectionButton addTarget:self action:@selector(onTouchCollection:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(JSDItemListModel *)viewModel {
    
    _viewModel = viewModel;
    self.flagBackgroundView.backgroundColor = [UIColor redColor];
    self.titleLabel.text = viewModel.name;
    self.accountLabel.text = viewModel.account;
    self.passwrodLabel.text = viewModel.password;
    self.collectionButton.selected = viewModel.isCollection;
    
}

- (void)onTouchCollection:(MDCButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if ([self.itemdelegate respondsToSelector:@selector(onTouchCollectionWithModel:)]) {
        [self.itemdelegate onTouchCollectionWithModel: self.viewModel];
    }
}


@end
