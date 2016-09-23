//
//  ImageContentView.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeaturedModel;
@class ContentView;

@interface ImageContentView : UIView

@property (nonatomic, strong) UIImageView *picture;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width Model:(FeaturedModel *)model Color:(UIColor *)color;

- (void)imageOffset;

@end
