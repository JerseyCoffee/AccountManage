//
//  JSDItemTableCell.h
//  AccountCheat
//
//  Created by ada on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "MGSwipeTableCell.h"

#import "JSDItemListViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDItemTableCell : MGSwipeTableCell

@property (strong, nonatomic) JSDItemListModel *viewModel;

@end

NS_ASSUME_NONNULL_END
