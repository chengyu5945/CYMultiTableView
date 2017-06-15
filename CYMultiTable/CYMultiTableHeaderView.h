//
//  CYMultiTableHeaderView.h
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMultiTableHeaderView : UIView

@property (nonatomic, strong)UIColor *columnColor;

@property (nonatomic, strong)NSArray<UIView *> *headerViewCells;


@end
