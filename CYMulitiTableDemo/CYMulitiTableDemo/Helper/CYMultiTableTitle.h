//
//  CYMultiTableTitle.h
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RecordListTitleFont [UIFont systemFontOfSize:15];
#define RecordListTitleColor UIColorFromHex(0X333333);
#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]


@interface CYMultiTableTitle : UIView

+ (CGFloat)widthWithType:(NSInteger)type columnCount:(NSInteger)columnCount;

+ (UIView *)cellTitleWithType:(NSInteger)type
                   viewHeight:(CGFloat)height
                  columnCount:(NSInteger)columnCount
                        title:(NSString *)title
                    subTitles:(NSArray *)subTitles;


+ (UIView *)getLineWithFrame:(CGRect)frame;
+ (UIView *)getLineWithIntegerFrame:(CGRect)rect;


+ (UIView *)cellTitleWithFrame:(CGRect)frame title:(NSString *)title;
@end
