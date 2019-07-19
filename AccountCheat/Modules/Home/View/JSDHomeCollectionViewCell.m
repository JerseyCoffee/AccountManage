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
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setModel:(JSDHomeModel *)model {
    
    _model = model;
    
    if (model.image) {
        self.imageView.image = [UIImage imageNamed:model.image];
    } else {
        self.imageView.image = nil;
    }
    
    self.textLabel.numberOfLines = 3;
    self.textLabel.text = model.title;
    
}

@end
