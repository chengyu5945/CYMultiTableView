//
//  CYMultiTableTitle.m
//  TableTest
//
//  Created by sinocare on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import "CYMultiTableTitle.h"

@implementation CYMultiTableTitle

+ (CGFloat)widthWithType:(NSInteger)type columnCount:(NSInteger)columnCount {
    CGRect CYreenRect = [UIScreen mainScreen].bounds;
    if (type == 1) {
        return (CYreenRect.size.width - (columnCount - 1))/columnCount;
    } else {
        return (CYreenRect.size.width - (columnCount - 1))/columnCount * 2 + 1;
    }
}

+ (UIView *)cellTitleWithType:(NSInteger)type
                   viewHeight:(CGFloat)height
                  columnCount:(NSInteger)columnCount
                        title:(NSString *)title
                    subTitles:(NSArray *)subTitles {
    
    CGFloat width = [self widthWithType:type columnCount:columnCount];
    if (type == 1) {
        // 表格头：合并两行
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 2;
        titleLabel.font = RecordListTitleFont;
        titleLabel.textColor = RecordListTitleColor;
        
        return titleLabel;
    } else {
        // 表格头：合并两列
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, (height - 1) / 2)];
        [contentView addSubview:titleLabel];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = RecordListTitleFont;
        titleLabel.textColor = RecordListTitleColor;
        titleLabel.text = title;
        
        //line
        UIView *lineView = [self getLineWithFrame:CGRectMake(0, (int)CGRectGetMaxY(titleLabel.frame), width, 1)];
        [contentView addSubview:lineView];
        
        lineView.backgroundColor = UIColorFromHex(0XE1E1E1);
        CGFloat cellWidth = (width - ([subTitles count] - 1)) / [subTitles count];
        CGFloat cellHeight = (height - 1) / 2;
        
        //subTitle
        CGRect subTitleRect = CGRectMake(0, CGRectGetMaxY(lineView.frame), cellWidth, cellHeight);
        for (NSInteger i = 0; i < [subTitles count]; i++) {
            UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:subTitleRect];
            subTitleLabel.textAlignment = NSTextAlignmentCenter;
            subTitleLabel.text = [subTitles objectAtIndex:i];
            subTitleLabel.font = RecordListTitleFont;
            subTitleLabel.textColor = RecordListTitleColor;
            [contentView addSubview:subTitleLabel];
            
            subTitleRect.origin.x += subTitleRect.size.width;

            if (i != [subTitles count] - 1) {
                subTitleRect.size.width = 1;
                UIView *subLineView = [self getLineWithFrame:subTitleRect];
                subLineView.backgroundColor = lineView.backgroundColor;
                [contentView addSubview:subLineView];
                
                subTitleRect.origin.x += subTitleRect.size.width;
                subTitleRect.size.width = cellWidth;
            }
            
        }
        return contentView;
    }
    
}

+ (UIView *)getLineWithFrame:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = UIColorFromHex(0XE1E1E1);
    return lineView;
}


+ (UIView *)getLineWithIntegerFrame:(CGRect)rect {
    rect.origin.x = (int)rect.origin.x;
    NSLog(@"cell x:%f", rect.origin.x);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.backgroundColor = UIColorFromHex(0XE1E1E1);
    return lineView;
}


+ (UIView *)cellTitleWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = UIColorFromHex(0X666666);
    return titleLabel;
}

@end
