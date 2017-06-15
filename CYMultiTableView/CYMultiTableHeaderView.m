//
//  CYMultiTableHeaderView.m
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import "CYMultiTableHeaderView.h"

@implementation CYMultiTableHeaderView

- (void)setHeaderViewCells:(NSArray<UIView *> *)headerViewCells {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    _headerViewCells = headerViewCells;
    
    //绘制竖线排版
    [self drawAndLayout];
}

- (void)drawAndLayout {
    CGFloat height = CGRectGetHeight(self.frame);
    CGRect rect = CGRectZero;
    rect.size.height = height;
    
    for (UIView *cellHeader in _headerViewCells) {
        CGFloat width = CGRectGetWidth(cellHeader.frame);
        rect.size.width = width;
        cellHeader.frame = rect;
        [self addSubview:cellHeader];
        
        if (cellHeader != [_headerViewCells lastObject]) {
            rect.origin.x += rect.size.width;
            rect.size.width = 1;
            UIView *lineView = [self getLineWithFrame:rect];
            [self addSubview:lineView];
            
            rect.origin.x += rect.size.width;
        }
    }
    
    //header和bottom两道竖线
    UIView *headerLine = [self getLineWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    [self addSubview:headerLine];
    
    UIView *bottomLine = [self getLineWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    [self addSubview:bottomLine];
}

- (UIView *)getLineWithFrame:(CGRect)rect {
    rect.origin.x = (int)rect.origin.x;
    NSLog(@"header x:%f", rect.origin.x);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.backgroundColor = self.columnColor;
    return lineView;
}
@end
