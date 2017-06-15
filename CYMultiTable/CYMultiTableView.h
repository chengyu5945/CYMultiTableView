//
//  CYMultiTableView.h
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYMultiTableViewDelegate <NSObject>

@optional
/**
 title的整体高度，有默认值
 */
- (CGFloat)heightForTitle;
/**
 title对应列的宽度
 */
- (CGFloat)widthForTitleAtColumn:(NSInteger)column;

/**
 左侧第一列的宽度
 */
- (CGFloat)widthForLeftColumn;

/**
 section的高度，可以不设置，自己计算正方形
 */
- (CGFloat)heightForSection:(NSInteger)section;

/**
 对应section中cell的宽度，可以不设置，自己计算等宽度
 */
- (CGFloat)widthForRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;

/**
 选中了第几行第几列
 */
- (void)didSelectedAtRow:(NSInteger)row cloumn:(NSInteger)cloumn section:(NSInteger)section;

- (UIColor *)backgroundColorForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (UIColor *)titleColorForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
// 是否显示角标
- (BOOL)showMarkForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section;
- (UIColor *)backgroundColorForLeftTitle;
- (UIColor *)leftTitleColor;
@end

@protocol CYMultiTableViewDataSource <NSObject>
@required

/**
 section的个数，日期当天
 */
- (NSInteger)numberOfSections;

/**
 对应section的title
 */
- (NSString *)titleOfSection:(NSInteger)section;

/**
 对应section的行数
 */
- (NSInteger)numbersOfRowsInSection:(NSInteger)section;
/**
 列数
 */
- (NSInteger)numbersOfColumns;
/**
 对应行列 所在的cell的title
 */
- (NSString *)titleAtRow:(NSInteger)row column:(NSInteger)column inSection:(NSInteger)section;

@optional

/**
 title列数
 */
- (NSInteger)numbersForTitleOfColumns;

/**
 对应列的title
 */
- (UIView *)titleViewWithColumn:(NSInteger)column;



@end

@interface CYMultiTableView : UIView

@property (nonatomic, assign)id<CYMultiTableViewDelegate> delegate;
@property (nonatomic, assign)id<CYMultiTableViewDataSource> dataSource;

@property (nonatomic, strong, readonly)UITableView *tableView;

@property (nonatomic, strong)UIColor *columLineColor;
@property (nonatomic, strong)UIColor *titleBackgroundColor;
@property (nonatomic, assign, readonly)CGFloat titleHeight;
@property (nonatomic, assign)BOOL showHLine;//是否显示竖线

- (void)setupSubviews;
- (void)reloadData;
@end
