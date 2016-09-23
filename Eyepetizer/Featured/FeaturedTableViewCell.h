//
//  FeaturedTableViewCell.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeaturedModel;

@interface FeaturedTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picture;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *littleLabel;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) FeaturedModel *model;

- (CGFloat)cellOffset;

@end
