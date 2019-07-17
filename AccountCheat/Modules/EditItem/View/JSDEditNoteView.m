//
//  JSDEditNoteView.m
//  AccountCheat
//
//  Created by ada on 2019/7/14.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDEditNoteView.h"

#import "JSDPublic.h"
#import "JSDFlagColorModel.h"

@interface JSDEditNoteView ()

@property (nonatomic, strong) NSArray<MDCButton* >* flagBtnArray;

@property (weak, nonatomic) IBOutlet UIView *flagContentView;
@property (weak, nonatomic) IBOutlet MDCRaisedButton *flagBtn;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn2;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn3;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn4;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn5;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn6;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn7;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn8;
@property (weak, nonatomic) IBOutlet MDCButton *cancelFlagButton;

@property (nonatomic, strong) JSDFlagColorModel* colorModel;

@end

@implementation JSDEditNoteView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchContentView:)];
    [self.contentView addGestureRecognizer:tap];
    
    self.selectedFlagView.layer.cornerRadius = 4;
    self.selectedFlagView.backgroundColor = [UIColor jsd_grayColor];
    self.selectedFlagImageView.backgroundColor = [UIColor whiteColor];
    self.selectedFlagImageView.layer.cornerRadius = 4;

    self.flagBtnArray = @[self.flagBtn, self.flagBtn2, self.flagBtn3, self.flagBtn4, self.flagBtn5, self.flagBtn6, self.flagBtn7, self.flagBtn8];
    
    JSDFlagColorModel* colorModel = [[JSDFlagColorModel alloc] init];
    _colorModel = colorModel;
    for (NSInteger i = 0 ; i < self.flagBtnArray.count; i ++) {
        MDCButton* btn = self.flagBtnArray[i];
        btn.backgroundColor = [UIColor jsd_colorWithHexString:colorModel.colorArray[i]];
        btn.tag = i;
        [btn addTarget:self action:@selector(onTouchFlagSender:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton* btn in self.flagBtnArray) {
        
        [btn addTarget:self action:@selector(onTouchFlagSender:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.selectedFlagLabel.adjustsFontSizeToFitWidth = YES;
    self.selectedFlagLabel.text = @"可点击下方标签块,设置标签(可通过关键字进行搜索)";
    self.selectedFlagLabel.numberOfLines = 3;
    self.selectedFlagLabel.textColor = [UIColor lightGrayColor];
    
    self.flagTitleLabel.textColor = [UIColor lightGrayColor];
    self.flagTitleLabel.text = @"选择标签";
    
    [self.cancelFlagButton setTitle:@"重置" forState:UIControlStateNormal];
    [self.cancelFlagButton addTarget:self action:@selector(onTouchCancel:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)onTouchContentView:(id)sender {
    
    [self endEditing:YES];
}

- (void)onTouchFlagSender:(UIButton* )sender {
    
    NSLog(@"选中%ld", sender.tag);
    
    self.selectedFlagImageView.backgroundColor = [UIColor jsd_colorWithHexString:self.colorModel.colorArray[sender.tag]];
    self.selectedFlagLabel.text = [NSString stringWithFormat:@"当前选择标签为: %@", self.colorModel.colorNameArray[sender.tag]];
    self.selectedFlagLabel.font = [UIFont systemFontOfSize:18];
    self.selectedFlagLabel.textColor = [UIColor blackColor];
    
    self.selectedFlagColorName = self.colorModel.colorArray[sender.tag];
}

- (void)onTouchCancel:(id)sender {
    
    self.selectedFlagImageView.backgroundColor = [UIColor whiteColor];
    self.selectedFlagLabel.text = @"可点击下方标签块,设置标签(可通过关键字进行搜索)";
    self.selectedFlagLabel.font = [UIFont systemFontOfSize:14];
    self.selectedFlagLabel.textColor = [UIColor lightGrayColor];
    
    self.selectedFlagColorName = nil;
}


@end
