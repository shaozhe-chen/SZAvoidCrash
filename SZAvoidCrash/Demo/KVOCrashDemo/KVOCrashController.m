//
//  KVOCrashController.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/11.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "KVOCrashController.h"
#import "KVOObservObj.h"

@interface KVOCrashController ()
@property (weak, nonatomic) IBOutlet UIButton *addObserveBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeObserve;
@property (assign, nonatomic) NSInteger age;
@end

@implementation KVOCrashController

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
- (IBAction)addObserveClick:(id)sender {
    [[KVOObservObj shareInstance] addObserver:self forKeyPath:@"age_" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
}

- (IBAction)removeObserveClick:(id)sender {
    [[KVOObservObj shareInstance] removeObserver:self forKeyPath:@"age"];
    [self removeObserver:[KVOObservObj shareInstance] forKeyPath:@"age"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath:%@  change:%@", keyPath, change);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
