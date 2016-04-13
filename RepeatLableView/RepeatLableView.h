//
//  RepeatLableView.h
//  RepeatLableView
//
//  Created by chenjie on 16/4/13.
//  Copyright © 2016年 chenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepeatLableView : UIView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) NSString *text; //文字
@property (nonatomic, assign) float durationTime;
@property (nonatomic, assign) NSUInteger repeatCount; // 循环滚动次数(为0时无限滚动)

@end
