//
//  JSDSearchViewCell.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDSearchViewCell.h"

@interface JSDSearchViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end

@implementation JSDSearchViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setModel:(JSDItemListModel *)model {
    
    _model = model;
    
    self.titleLabel.text = model.name;
    self.accountLabel.text = model.account;
    self.passwordLabel.text = model.password;
}

@end
