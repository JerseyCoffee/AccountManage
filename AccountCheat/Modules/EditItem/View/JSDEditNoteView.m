//
//  JSDEditNoteView.m
//  AccountCheat
//
//  Created by ada on 2019/7/14.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDEditNoteView.h"

@interface JSDEditNoteView ()

@end

@implementation JSDEditNoteView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchContentView:)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)onTouchContentView:(id)sender {
    
    [self endEditing:YES];
}


@end
