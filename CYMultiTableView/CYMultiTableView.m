//
//  CYMultiTableView.m
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import "CYMultiTableView.h"
#import "CYMultiTableHeaderView.h"
#import "CYMultiOrigTableViewCell.h"

#define CY_Default_Line_Width 1

@interface CYMultiTableView () <UITableViewDelegate, UITableViewDataSource, CYColumnDelegate>

@property (nonatomic, strong)CYMultiTableHeaderView *titleView;
@property (nonatomic, strong, readwrite)UITableView *tableView;

//data
@property (nonatomic, assign)NSInteger columnCounts;
@property (nonatomic, assign)CGFloat columnWidth;
@property (nonatomic, assign, readwrite)CGFloat titleHeight;
@property (nonatomic, assign)CGFloat leftTitleWidth;

@end

@implementation CYMultiTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDefaultValues];
        [self initSubviews];
    }
    return self;
}

- (void)initDefaultValues {
    CGFloat padding = (9 - 1) * CY_Default_Line_Width;
    _columnWidth = (CGRectGetWidth(self.frame) - padding)/9;
    _leftTitleWidth = _columnWidth + 1;
}

- (void)initSubviews {
    
    _titleView = [[CYMultiTableHeaderView alloc] init];
    [self addSubview:_titleView];
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), _columnWidth * 2);
    _titleHeight = CGRectGetHeight(_titleView.frame);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(_titleView.frame));
}

- (void)setupSubviews {
    //title View
    if (self.delegate && [self.delegate respondsToSelector:@selector(widthForLeftColumn)]) {
        self.leftTitleWidth = [self.delegate widthForLeftColumn];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numbersForTitleOfColumns)]) {
        
        //number of columns
        NSInteger columns = [self.dataSource numbersForTitleOfColumns];
        //height
        CGFloat titleHeight = CGRectGetHeight(_titleView.frame);
        if (self.delegate && [self.delegate respondsToSelector:@selector(heightForTitle)]) {
            titleHeight = [self.delegate heightForTitle];
            _titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), titleHeight);
            _titleHeight = CGRectGetHeight(_titleView.frame);

            [self setNeedsLayout];

        }
        //header cell
        NSMutableArray *titleCellsArr = [NSMutableArray array];
        for (NSInteger i = 0; i < columns; i++) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleViewWithColumn:)]) {
                UIView *cellTitle = [self.dataSource titleViewWithColumn:i];
                CGFloat cellWidth = _columnWidth;
                if (self.delegate && [self.delegate respondsToSelector:@selector(widthForTitleAtColumn:)]) {
                    cellWidth = [self.delegate widthForTitleAtColumn:i];
                    cellTitle.frame = CGRectMake(0, 0, cellWidth, CGRectGetHeight(_titleView.frame));
                    
                }
                if (cellTitle) [titleCellsArr addObject:cellTitle];
            }
        }
        _titleView.headerViewCells = titleCellsArr;
    }
    
    //tableView
    self.columnCounts = [self.dataSource numbersOfColumns];
}

#pragma mark - Setter
- (void)setColumnCounts:(NSInteger)columnCounts {
    _columnCounts = columnCounts;
    CGFloat padding = (_columnCounts - 1) * CY_Default_Line_Width;//一个line一个像素
    
    _columnWidth = (CGRectGetWidth(self.frame) - _leftTitleWidth - padding)/_columnCounts;
    
}

- (void)setColumLineColor:(UIColor *)columLineColor {
    _columLineColor = columLineColor;
    _titleView.columnColor = _columLineColor;
}

- (void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor {
    _titleBackgroundColor = titleBackgroundColor;
    _titleView.backgroundColor = _titleBackgroundColor;
}

#pragma mark - Public

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowCount = [self.dataSource numbersOfRowsInSection:indexPath.row];
    
    CGFloat height = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForSection:)]) {
        height = [self.delegate heightForSection:indexPath.row];
    } else {
        height = self.columnWidth;
    }
    return height * rowCount;
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [self.dataSource numberOfSections];
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifierIdCell = @"indentifierIdCell";
    CYMultiOrigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifierIdCell];
    if (cell == nil) {
        cell = [[CYMultiOrigTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifierIdCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.columnColor = self.columLineColor;
        cell.lineWidth = CY_Default_Line_Width;
        cell.columnWidth = self.columnWidth;
        cell.leftTitleWidth = self.leftTitleWidth;
        cell.columnCounts = self.columnCounts;
        cell.showHLine = self.showHLine;
    }
    cell.section = indexPath.row;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForSection:)]) {
        cell.columnHeight = [self.delegate heightForSection:indexPath.row];
    } else {
        cell.columnHeight = self.columnWidth;
    }

    [cell seupView];
    
    return cell;
    
}

#pragma mark - CYColumnCellDelegate

- (UIColor *)backgroundColorForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section {
    UIColor *backgroundColor = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundColorForCellWithRow:column:section:)]) {
        backgroundColor = [self.delegate backgroundColorForCellWithRow:row column:column section:section];
    }
    return backgroundColor;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numbersOfRowsInSection:section];
}

- (NSString *)titleOfSection:(NSInteger)section {
    return [self.dataSource titleOfSection:section];
}

- (UIColor *)titleColorForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section {
    UIColor *titleColor = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleColorForCellWithRow:column:section:)]) {
        titleColor = [self.delegate titleColorForCellWithRow:row column:column section:section];
    }
    return titleColor;

}
// 是否显示角标
- (BOOL)showMarkForCellWithRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section {
    BOOL showMark = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(showMarkForCellWithRow:column:section:)]) {
        showMark = [self.delegate showMarkForCellWithRow:row column:column section:section];
    }
    return showMark;
    
}


- (NSString *)titleAtRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section{
    NSString *title = [self.dataSource titleAtRow:row column:column inSection:section];
    return title;
}

- (void)didSelectedAtRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedAtRow:cloumn:section:)]) {
        [self.delegate didSelectedAtRow:row cloumn:column section:section];
    }
}

- (UIColor *)backgroundColorForLeftTitle {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundColorForLeftTitle)]) {
        return [self.delegate backgroundColorForLeftTitle];
    }
    return nil;
}
- (UIColor *)leftTitleColor {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftTitleColor)]) {
        return [self.delegate leftTitleColor];
    }
    return nil;
}

- (CGFloat)widthForRow:(NSInteger)row column:(NSInteger)column section:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(widthForRow:column:section:)]) {
        return [self.delegate widthForRow:row column:column section:section];
    }
    return 0.;
}
@end
