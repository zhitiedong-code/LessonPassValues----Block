//
//  FirstViewController.m
//  LessonPassValues----Block
//
//  Created by lanouhn on 15/9/17.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CustomView.h"

#pragma mark 代理传值 第四步
@interface FirstViewController () <UITextFieldDelegate,PassValueToFont>

@property (nonatomic,retain) UITextField *tf;
@property (nonatomic,retain) UILabel *label;

@end

@implementation FirstViewController
/**
 *  属性传值
    1.
 */


/**
*  代理传值
1.在后一个界面定义协议
2.在后一个界面定义代理对象的属性
3.在前一个界面进入后一个界面之前 指定代理对象
4.前一个界面作为代理对象 所在的类服从相应协议
5.前一个界面对应实现协议的方法
6.通知代理对象执行方法（把后一界面的数据传到前一个界面）
*/

/**
*  Block
返回值类型 函数名（参数列表）
*/



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"first";
    [self layoutSubviews];
    [self blockLianXi];
    
}


- (void)blockLianXi {
    //1.
    void (^block)() = ^ {
        NSLog(@"haihai");
    };
    block();//小括号不可省
    
    //2.
    int (^sum)(int,int) = ^(int a,int b) {
        NSLog(@"%d",a + b);
        return a + b;
    };
    sum(8,3);
    NSLog(@"%d", sum(2,3));
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
    
   self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 175, 50)];
    _label.backgroundColor = [UIColor cyanColor];
    _label.font = [UIFont boldSystemFontOfSize:30];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.layer.cornerRadius = 20;
    _label.layer.masksToBounds = YES;
    [self.view addSubview:_label];
    [_label release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 400, 175, 50);
    [button setTitle:@"PUSH" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


#pragma mark --------handleAction ---------
- (void)handleAction:(UIButton *)sender {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    secondVC.text = _tf.text;
    
    
#pragma mark 代理传值 第三步
    secondVC.delegate = self;
    
    NSLog(@"将要进入second2");
    [self.navigationController pushViewController:secondVC animated:YES];
    [secondVC release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark 代理传值 第五步
- (void)passValue:(NSString *)text {
    self.label.text = text;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    self.tf = nil;
    self.label = nil;
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
