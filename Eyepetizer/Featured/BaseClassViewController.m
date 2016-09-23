//
//  BaseClassViewController.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "BaseClassViewController.h"
#import "FeaturedTableViewController.h"

@interface BaseClassViewController ()

@end

@implementation BaseClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupVIew];
}

- (void)setupVIew{
    NSLog(@"---%s", __FUNCTION__);
    
    _featuredVC = [[FeaturedTableViewController alloc] initWithStyle: (UITableViewStyleGrouped)];
    [self addChildViewController:_featuredVC];
    [self.view addSubview:_featuredVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
