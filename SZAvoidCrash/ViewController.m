//
//  ViewController.m
//  SZAvoidCrash
//
//  Created by shaozhe on 2019/4/2.
//  Copyright © 2019年 shaozhe. All rights reserved.
//

#import "ViewController.h"
#import "KVOCrashController.h"
#import "UnrecognizedSelectorViewController.h"
#import "NSTimerViewController.h"
#import "KVOObservObj.h"
static NSString *kObjName = @"szObj";
@interface ViewController ()<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSHashTable *table;
@property (nonatomic, copy) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _datas = @[@"kvoCrashDemo", @"UnrecognizedSelectorDemo", @"NSTimerCrashDemo"];
    [self.view addSubview:self.tableView];
    [self configItem];
}

- (void)configItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"age+1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ageAddClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:btn]];
}

- (void)ageAddClick {
    [KVOObservObj shareInstance].age ++;
}

#pragma makr UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"UITableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *text = _datas[indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        KVOCrashController *vc = [KVOCrashController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        UnrecognizedSelectorViewController *vc = [UnrecognizedSelectorViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {
        NSTimerViewController *vc = [NSTimerViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
    }
    return _tableView;
}
@end
