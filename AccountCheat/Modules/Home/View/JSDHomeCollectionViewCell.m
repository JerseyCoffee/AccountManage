//
//  JSDHomeCollectionViewCell.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDHomeCollectionViewCell.h"

@interface JSDHomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JSDHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.iconImageView.backgroundColor = [UIColor grayColor];
    self.iconImageView.layer.cornerRadius = 20;
}

- (void)setModel:(JSDHomeModel *)model {
    
    _model = model;
    
    if (model.image) {
        self.iconImageView.image = [UIImage imageNamed:model.image];
    } else {
        self.iconImageView.image = nil;
    }
    
    self.titleLabel.text = model.title;
    
}

@end
