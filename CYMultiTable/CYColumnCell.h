//
//  CYColumnCell.h
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYColumnCell;

@protocol CYColumnCellDelegate <NSObject>

- (void)didSelectedCell:(CYColumnCell *)columnCell;
@end

@interface CYColumnCell : UIView

@property (nonatomic, assign)id<CYColumnCellDelegate> delegate;

@property (nonatomic, strong, readonly)UIView *contentView;
@property (nonatomic, strong, readonly)UIButton *textButton;

// 是否显示蓝色角标
@property (nonatomic, strong)UIImageView *markImgeView;


@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, assign)NSInteger column;

@end
