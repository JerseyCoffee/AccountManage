//
//  JSDItemTableCell.h
//  AccountCheat
//
//  Created by ada on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "JSDItemListViewModel.h"


@class JSDItemTableCell;
@protocol JSDItemTableCellDelegate <NSObject>

- (void)onTouchCollectionWithModel:(JSDItemListModel *_Nullable)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface JSDItemTableCell : MGSwipeTableCell

@property (strong, nonatomic) JSDItemListModel *viewModel;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id<JSDItemTableCellDelegate> itemdelegate;

@end

NS_ASSUME_NONNULL_END
