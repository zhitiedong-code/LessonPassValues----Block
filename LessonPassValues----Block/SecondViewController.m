//
//  SecondViewController.m
//  LessonPassValues----Block
//
//  Created by lanouhn on 15/9/17.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomView.h"

@interface SecondViewController () <UITextFieldDelegate>

@property (nonatomic,retain) UITextField *tf;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"second";
    [self layoutSubviews];
    [self setUpCustomView];
   
}

/*
- (void)setUpCustomView {
    CustomView *custom = [[CustomView alloc] initWithFrame:CGRectMake(100, 500, 175, 50)];
    custom.backgroundColor = [UIColor greenColor];
    [self.view addSubview:custom];
    [custom release];
    
    custom.changeColor = ^(UIColor *color) {
        
    };
    
#pragma mark Block传值 第三步  实现block
    
    __block SecondViewController *secondVC = self;
    custom.changeColor = ^(UIColor *color) {
        
        //在controller中定义block实现，如果controller持有block的所有权，则第一 不能直接使用self去调用 ；第二 不能通过self调用属性或方法  第三 不能直接使用实例变量
//        self.view.backgroundColor = color;//错误写法，此时block空间无法被会使
        
        //上面的写法 block 会使controller引用计数加1，controller又拥有block，会造成循环引用，controller和block就都不能被释放
        
        //正确写法
        secondVC.view.backgroundColor = color;
        
    };
    
}
*/

- (void)setUpCustomView {
    CustomView *custom = [[CustomView alloc] initWithFrame:CGRectMake(100, 500, 175, 50)];
    custom.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:custom];
    [custom release];
    
    //使用__block解决这种循环引用问题
    __block SecondViewController *secondVC = self;
    
    //触摸视图 通过block回调 改变视图控制器根视图的背景颜色
    custom.changeSelfColor = ^(UIColor *color) {
      //在controller定义block实现,在controller里的block内部不能使用
        /**
         1.不能直接使用self
         2.不能用self调用方法，属性
         3.不能使用实例变量
         */
        //下面的代码 controller持有block，block又会使controller的引用计数加1，造成循环引用问题。controller和block就都不会被释放
//        self.view.backgroundColor = color;
        
        secondVC.view.backgroundColor = color;
        
        
        
    };
    
}

//布局
- (void)layoutSubviews {
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 175, 50)];
    _tf.borderStyle = UITextBorderStyleRoundedRect;
    _tf.placeholder = @"请输入";
    _tf.font = [UIFont boldSystemFontOfSize:30];
    _tf.delegate = self;
    [self.view addSubview:_tf];
    [_tf release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 175, 50)];
    label.backgroundColor = [UIColor cyanColor];
    label.text = self.text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:30];
    label.layer.cornerRadius = 20;
    label.layer.masksToBounds = YES;
    [self.view addSubview:label];
    [label release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 400, 175, 50);
    [button setTitle:@"POP" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


- (void)handleAction:(UIButton *)sender {
    
#pragma mark 代理传值 第六步 6.1 在合适的时机去通知代理对象执行传值操作 可以在返回前一个界面时通知
    if (_delegate && [self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:self.tf.text];
    }
    NSLog(@"将要进first");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 代理传值 第六步 6.2 也可以在后一个界面消失时 去通知；
- (void)viewWillDisappear:(BOOL)animated {
    if (_delegate && [self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:self.tf.text];
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//重写dealloc方法 将block释放
- (void)dealloc {
    self.tf = nil;
    self.text = nil;
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
