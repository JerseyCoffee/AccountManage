//
//  JSDEditNoteView.h
//  AccountCheat
//
//  Created by ada on 2019/7/14.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MaterialComponents/MaterialTextFields.h>
#import <MDCChipField.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDEditNoteView : UIView

@property (weak, nonatomic) IBOutlet MDCTextField *nameTextField;

@property (weak, nonatomic) IBOutlet MDCTextField *accountTextField;

@property (weak, nonatomic) IBOutlet MDCTextField *passwordTextField;

@property (weak, nonatomic) IBOutlet MDCTextField *typeTextField;

@property (weak, nonatomic) IBOutlet MDCMultilineTextField *remarkTextField;



@end

NS_ASSUME_NONNULL_END
