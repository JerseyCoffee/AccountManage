//
//  JSDMyCenterTextCell.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMyCenterTextCell.h"

#import "JSDPublic.h"

@implementation JSDMyCenterTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    self.textLabel.text = @"Jersey";
    self.imageView.image = [UIImage jsd_imageName:@"mac_note"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
