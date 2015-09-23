//
//  SecondViewController.h
//  LessonPassValues----Block
//
//  Created by lanouhn on 15/9/17.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark 代理传值 第一步 制定协议
@protocol PassValueToFont <NSObject>

- (void)passValue:(NSString *)text;

@end

@interface SecondViewController : UIViewController

@property (nonatomic,retain) NSString *text;

#pragma mark 代理传值  第二步 设置代理属性
@property (nonatomic,assign) id<PassValueToFont> delegate;


@end
