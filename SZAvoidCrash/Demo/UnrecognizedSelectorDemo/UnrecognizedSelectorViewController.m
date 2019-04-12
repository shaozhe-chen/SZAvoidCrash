//
//  UnrecognizedSelectorViewController.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/11.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "UnrecognizedSelectorViewController.h"
@interface UnrecognizedSelectorViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy) NSMutableArray *array;
@property (nonatomic, copy) NSMutableDictionary *dic;
@end

@implementation UnrecognizedSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"点我" forState:UIControlStateNormal];
    _btn.frame = CGRectMake(100, 200, 100, 100);
    SEL sel = NSSelectorFromString(@"abc");
    [_btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [_btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_btn];
}

- (void)abc {
    _array = @[].copy;
    //    [_array addObject:@"1"];
    [_array insertObject:@"2" atIndex:2];
    NSLog(@"%@",_array);
    
    _dic = @{}.copy;
    [_dic setObject:@"1" forKey:@"dic1"];
    NSLog(@"%@",_dic);
    
}

- (void)dealloc {
    NSLog(@"%@  %@",NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}
@end
