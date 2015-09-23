//
//  CustomView.m
//  LessonPassValues----Block
//
//  Created by lanouhn on 15/9/17.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "CustomView.h"



@implementation CustomView

//重写dealloc释放掉block
- (void)dealloc {
    Block_release(_changeSelfColor);
    NSLog(@"kkkkkkkkkk");
    [super dealloc];
}

//触摸时
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIColor *color = [UIColor yellowColor];
    self.changeSelfColor(color);
}

@end
