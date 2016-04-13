//
//  RepeatLableView.m
//  test2
//
//  Created by chenjie on 16/4/13.
//  Copyright © 2016年 chenjie. All rights reserved.
//

#import "RepeatLableView.h"

@implementation RepeatLableView

//用代码初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _font = (_font == nil) ? [UIFont systemFontOfSize:15] : _font;
        _durationTime = (_durationTime == 0) ? 5 : _durationTime;
        _repeatCount = (_repeatCount != 0) ? _repeatCount : 0;
        //超出主view部分剪切.
        self.clipsToBounds = YES;
        
    }
    return self;
}

//重写set方法添加控件
- (void)setText:(NSString *)text{
    
    _text = text;
    [self reloadView];
    
}

//创建view
- (void)reloadView{

    //计算宽度
    NSDictionary *attr = @{NSFontAttributeName : self.font};
    //CGFLOAT_MAX 宽度范围是不确定的所以要用MAX
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:0 attributes:attr context:nil].size;
    CGFloat width = size.width;
    
    //是否需要移动
    BOOL moveNeed = (width > self.bounds.size.width) ? YES : NO;
    
    //创建label-1  宽度增加了30,起到间隔作用,不需要可不加
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width + 30, self.bounds.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = _font;
    label.text = _text;

    if (!moveNeed) {
        
        [self addSubview:label];
        
    }else{
    
        //不添加这个view的话整个视图就跟着跑了
        UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
        contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];
        
        [contentView addSubview:label];

        //创建label-2
        UILabel *next = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.size.width, 0, label.frame.size.width, label.frame.size.height)];
        next.backgroundColor = [UIColor clearColor];
        next.textAlignment = NSTextAlignmentLeft;
        next.text = _text;
        next.font = _font;

        [contentView addSubview:next];

        //动画 - > 改变x
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        //关键帧.动画对象在指定时间内依次执行关键帧.
        //从x=0开始,执行到x=0(需求:停顿一下) 再从x = 0 执行到最后.
        moveAnimation.values = @[@0,@0 ,@(- label.frame.size.width)];
        //keyTimes对应执行上面的values属性,x = 0到x = 0 执行了总时间的0.1(因为keyTimes与values是一一对应的)达到停顿效果,x = 0 到最后可以自定义.
        moveAnimation.keyTimes = @[@0, @0.100, @0.868, @1.0];
        moveAnimation.duration = _durationTime;
        moveAnimation.repeatCount = (self.repeatCount == 0 )? INT16_MAX : self.repeatCount;

        [contentView.layer addAnimation:moveAnimation forKey:@"move"];
    }
}

@end
