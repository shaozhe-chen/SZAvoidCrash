//
//  NSTimerViewController.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/12.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fireBtn;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)fireBtnClick:(id)sender {
    [self.timer fire];
}

#pragma mark timerCallBack
- (void)timerCallBack {
    NSLog(@"timerCallBack");
}

#pragma mark Getter
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerCallBack) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)dealloc {
    NSLog(@"%@  %@",NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}
@end
