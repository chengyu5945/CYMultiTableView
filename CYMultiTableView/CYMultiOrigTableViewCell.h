//
//  CYMultiOrigTableViewCell.h
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYColumnCell.h"

@protocol CYColumnDelegate <NSObject>
//delegate
- (UIColor *)backgroundColorForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (UIColor *)titleColorForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (BOOL)showMarkForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (UIColor *)backgroundColorForLeftTitle;
- (UIColor *)leftTitleColor;
- (CGFloat)widthForRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (void)didSelectedAtRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;

//dataSource
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleAtRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (NSString *)titleOfSection:(NSInteger)section;
@end


@interface CYMultiOrigTableViewCell : UITableViewCell

@property (nonatomic, assign)id<CYColumnDelegate> delegate;

@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)NSInteger rowCounts;
@property (nonatomic, assign)NSInteger columnCounts;
@property (nonatomic, assign)CGFloat columnWidth;
@property (nonatomic, assign)CGFloat columnHeight;
@property (nonatomic, assign)CGFloat lineWidth;//default 1pt
@property (nonatomic, strong)UIColor *columnColor;
@property (nonatomic, assign)CGFloat leftTitleWidth;
@property (nonatomic, assign)BOOL showHLine;//是否显示竖线

- (void)seupView;

@end
