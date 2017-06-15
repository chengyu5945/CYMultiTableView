//
//  CYMultiOrigTableViewCell.m
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import "CYMultiOrigTableViewCell.h"

@interface CYMultiOrigTableViewCell () <CYColumnCellDelegate>

@property (nonatomic, strong)NSMutableArray *columnArr;
@end


@implementation CYMultiOrigTableViewCell


- (void)layoutCellViewsAtRow:(NSInteger)row {
    
    CGRect rect = CGRectMake(self.leftTitleWidth, _columnHeight * row, _columnWidth, _columnHeight);
    for (NSInteger i = 0; i < self.columnCounts; i++) {
        //config element width
        CGFloat elementCellWidth = 0;
        if (self.delegate && [self.delegate respondsToSelector:@selector(widthForRow:column:section:)]) {
            elementCellWidth = [self.delegate widthForRow:row column:i section:self.section];
        }
        if (elementCellWidth == 0) {
            elementCellWidth = _columnWidth;
        }
        rect.size.width = elementCellWidth;
        
        //cell
        CYColumnCell *columnCell = [[CYColumnCell alloc] initWithFrame:rect];
        columnCell.delegate = self;
        columnCell.section = self.section;
        columnCell.row = row;
        columnCell.column = i;
        
        [self.contentView addSubview:columnCell];
        [_columnArr addObject:columnCell];
        
        rect.origin.x += rect.size.width;
        if (i != _columnCounts - 1) {
            rect.size.width = self.lineWidth;
            if (_showHLine) {
                UIView *lineView = [self getLineWithFrame:rect];
                [self addSubview:lineView];
            }
            rect.origin.x += rect.size.width;
            rect.size.width = _columnWidth;
        }
        
    }

    UIView *bottomLine = [self getLineWithFrame:CGRectMake(self.leftTitleWidth, CGRectGetMaxY(rect) - self.lineWidth, _columnWidth * _columnCounts + _lineWidth * (_columnCounts - 1), self.lineWidth)];
    [self.contentView addSubview:bottomLine];
}

- (UIView *)getLineWithFrame:(CGRect)rect {
    rect.origin.x = (int)rect.origin.x;
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.backgroundColor = self.columnColor;
    return lineView;
}

- (void)setupLeftTitleWithRowCounts:(NSInteger)rowCounts {
    UILabel *leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.leftTitleWidth, self.columnHeight * rowCounts)];
    NSString *title = [self.delegate titleOfSection:self.section];
    leftTitleLabel.text = title;
    leftTitleLabel.font = [UIFont systemFontOfSize:13];
    leftTitleLabel.textAlignment = NSTextAlignmentCenter;
    leftTitleLabel.adjustsFontSizeToFitWidth = YES;
    if ([self.delegate respondsToSelector:@selector(backgroundColorForLeftTitle)]) {
        leftTitleLabel.backgroundColor = [self.delegate backgroundColorForLeftTitle];
    } else {
        leftTitleLabel.backgroundColor = [UIColor whiteColor];
    }
    if ([self.delegate respondsToSelector:@selector(leftTitleColor)]) {
        leftTitleLabel.textColor = [self.delegate leftTitleColor];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(leftTitleLabel.frame) - self.lineWidth, 0, self.lineWidth, CGRectGetHeight(leftTitleLabel.frame))];
    lineView.backgroundColor = self.columnColor;
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(leftTitleLabel.frame) - self.lineWidth, CGRectGetWidth(leftTitleLabel.frame), self.lineWidth)];
    bottomLineView.backgroundColor = self.columnColor;
    
    [self.contentView addSubview:leftTitleLabel];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:bottomLineView];
    
}

#pragma mark - Button Pressed
- (void)textButtonPressed:(UIButton *)sender {
    //NSInteger column = sender.tag;
    //[self.delegate didSelectedAtRow:self.row column:column];
}

#pragma mark - Public
- (void)seupView {
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (!self.columnArr) {
        self.columnArr = [NSMutableArray array];
        
    }

    [self.columnArr removeAllObjects];
    
    NSInteger rowCounts = [self.delegate numberOfRowsInSection:self.section];
    
    [self setupLeftTitleWithRowCounts:rowCounts];

    for (int i = 0; i < rowCounts; i++) {
        [self layoutCellViewsAtRow:i];
    }
    
    for (CYColumnCell * columnCell in self.columnArr) {
        
        NSString *title = [self.delegate titleAtRow:columnCell.row column:columnCell.column section:columnCell.section];
        
        [columnCell.textButton setTitle:title forState:UIControlStateNormal];
        
        UIColor *titleColor = [self.delegate titleColorForCellWithRow:columnCell.row column:columnCell.column section:columnCell.section];
        if (titleColor) {
            [columnCell.textButton setTitleColor:titleColor forState:UIControlStateNormal];
        }
        
        UIColor *backgourndColor = [self.delegate backgroundColorForCellWithRow:columnCell.row column:columnCell.column section:columnCell.section];
        if (backgourndColor) {
            columnCell.contentView.backgroundColor = backgourndColor;
        }
        // 右上角蓝色角标
        BOOL showMark = [self.delegate showMarkForCellWithRow:columnCell.row column:columnCell.column section:columnCell.section];
        if (showMark) {
            columnCell.markImgeView.image = [UIImage imageNamed:@"blood_list_mark"];
        }

    }
}

#pragma mark - CYColumnCell Delegate
- (void)didSelectedCell:(CYColumnCell *)columnCell {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedAtRow:column:section:)]) {
        [self.delegate didSelectedAtRow:columnCell.row column:columnCell.column section:columnCell.section];
    }
}

@end
