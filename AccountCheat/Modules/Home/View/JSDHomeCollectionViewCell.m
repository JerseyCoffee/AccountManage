//
//  JSDHomeCollectionViewCell.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDHomeCollectionViewCell.h"

#import "UIColor+JSDStyle.h"
@interface JSDHomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JSDHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
//    self.iconImageView.backgroundColor = [UIColor jsd_grayColor];
//    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2;
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
