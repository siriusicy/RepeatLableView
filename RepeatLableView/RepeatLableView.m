//
//  RepeatLableView.m
//  RepeatLableView
//
//  Created by chenjie on 16/4/13.
//  Copyright © 2016年 chenjie. All rights reserved.
//

#import "RepeatLableView.h"

@interface RepeatLableView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation RepeatLableView

//用代码初始化
- (instancetype)initWithFrame:(CGRect)frame Text:(NSString *)text Font:(UIFont *)font{
    self = [super initWithFrame:frame];
    if (self && text.length > 0) {
        
        //超出主view部分剪切.
        self.clipsToBounds = YES;
        
        _label = [self creatLabelWithStr:text font:font];
        
        [self reloadView];
    }
    return self;
}

//创建label
- (UILabel *)creatLabelWithStr:(NSString *)str font:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = font ? font : [UIFont systemFontOfSize:15];
    label.text = str;
    [label sizeToFit];
    _label.origin = CGPointMake(0, (CGRectGetHeight(self.frame) - CGRectGetHeight(_label.frame))/2.0);
    
    return label;
    
}
//创建view
- (void)reloadView{
    
    if (CGRectGetWidth(self.frame) >= CGRectGetWidth(_label.frame)) { //不需要滚动
        [self addSubview:_label];
        return;
    }
    
    //不添加这个view的话整个视图就跟着跑了
    UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
    
    //宽度增加30,作为间隔
    CGRect rect = _label.frame;
    rect.size.width += 30;
    _label.frame = rect;
    [contentView addSubview:_label];
    
    //创建label-2
    UILabel *next = [self creatLabelWithStr:_label.text font:_label.font];
    rect = _label.frame;
    rect.origin.x += CGRectGetWidth(_label.frame);
    next.frame = rect;
    [contentView addSubview:next];
    
    //动画 - > 改变x
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    //关键帧.动画对象在指定时间内依次执行关键帧.
    //从x=0开始,执行到x=0(需求:停顿一下) 再从x = 0 执行到最后.
    moveAnimation.values = @[@0,@0 ,@(-CGRectGetWidth(_label.frame))];
    moveAnimation.keyTimes = @[@0, @0.15, @1.0];
    moveAnimation.duration = 5;
    moveAnimation.repeatCount = INT16_MAX;
    
    [contentView.layer addAnimation:moveAnimation forKey:@"move"];
    
}

@end

