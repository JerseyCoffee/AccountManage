//
//  JSDItemTableCell.m
//  AccountCheat
//
//  Created by ada on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemTableCell.h"

@implementation JSDItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setViewModel:(JSDItemListModel *)viewModel {
    
    _viewModel = viewModel;
    
}

@end
