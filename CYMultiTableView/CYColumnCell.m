//
//  CYColumnCell.m
//  TableTest
//
//  Created by Yu Cheng on 16/6/6.
//  Copyright © 2016年 Yu Cheng. All rights reserved.
//

#import "CYColumnCell.h"
@interface CYColumnCell ()

@property (nonatomic, strong, readwrite)UIView *contentView;
@property (nonatomic, strong, readwrite)UIButton *textButton;

@end


@implementation CYColumnCell

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_contentView];

        _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _textButton.frame = _contentView.bounds;
        [_textButton addTarget:self action:@selector(cellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_textButton];
        
        [self showMarkIcon];
        
        [self setDefaultValues];
    }
    return self;
}

- (void)showMarkIcon {
    // 添加单元格右上角蓝色角标
    CGFloat markX = _contentView.bounds.size.width - 10;
    CGFloat markY = 0;
    CGFloat markW = 10;
    CGFloat markH = markW;
    _markImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(markX, markY, markW, markH)];
    [_contentView addSubview:_markImgeView];
}

- (void)setDefaultValues {
//    _textButton.titleLabel.font = [UIFont systemFontOfSize:14.];
    // 4.0上的类似10.44这样的四位数显示不全，只能用13的字体。
    _textButton.titleLabel.font = [UIFont systemFontOfSize:13.];
}

- (void)cellButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCell:)]) {
        [self.delegate didSelectedCell:self];
    }
}

@end
