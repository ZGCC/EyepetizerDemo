//
//  ContentView.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomView;
@class FeaturedModel;

@interface ContentView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *littleLabel;
@property (nonatomic, strong) UILabel *descriptLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) CustomView *collectionCustom;
@property (nonatomic, strong) CustomView *shareCustom;
@property (nonatomic, strong) CustomView *cacheCustom;
@property (nonatomic, strong) CustomView *replyCustom;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width Model:(FeaturedModel *)model Color:(UIColor *)color;

- (void)setData:(FeaturedModel *)model;

@end
