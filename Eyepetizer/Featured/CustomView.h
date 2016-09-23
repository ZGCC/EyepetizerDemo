//
//  CustomView.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width LabelString:(id)labelString color:(UIColor *)color;

- (void)setTitle:(id)title;
- (void)setColor:(UIColor *)color;

@end
