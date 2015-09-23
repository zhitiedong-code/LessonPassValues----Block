//
//  CustomView.h
//  LessonPassValues----Block
//
//  Created by lanouhn on 15/9/17.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeColor)(UIColor *);


@interface CustomView : UIView

//修饰block使用copy，retain对block无效；

@property (nonatomic,copy) changeColor changeSelfColor;

@end
