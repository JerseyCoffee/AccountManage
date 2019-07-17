//
//  JSDItemShowViewCell.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemShowViewCell.h"

@implementation JSDItemShowViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLabel.font = [MDCTypography subheadFont];
    _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography subheadFontOpacity]];
    _titleLabel.shadowColor = nil;
    _titleLabel.shadowOffset = CGSizeZero;
    _titleLabel.textAlignment = NSTextAlignmentNatural;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 2;
    
    _detailLabel.font = [MDCTypography body1Font];
    _detailLabel.textColor = [UIColor colorWithWhite:0 alpha:[MDCTypography captionFontOpacity]];
    _detailLabel.shadowColor = nil;
    _detailLabel.shadowOffset = CGSizeZero;
    _detailLabel.textAlignment = NSTextAlignmentNatural;
    _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailLabel.numberOfLines = 1;
    
    
    
}


@end
