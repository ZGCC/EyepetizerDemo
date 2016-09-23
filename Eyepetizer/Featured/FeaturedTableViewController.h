//
//  FeaturedTableViewController.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class rilegouleView;

@interface FeaturedTableViewController : UITableViewController

@property (nonatomic, strong) rilegouleView *rilegoule;

@property (nonatomic, strong) UIImageView *blurredView;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
