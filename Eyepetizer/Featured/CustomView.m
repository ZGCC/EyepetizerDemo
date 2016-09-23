//
//  CustomView.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width LabelString:(id)labelString color:(UIColor *)color{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat totalWdith = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(0, 0, width, totalHeight);
        _button.tintColor = color;
        [self addSubview:_button];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(width, 0, totalWdith, totalHeight)];
        _label.textColor = color;
        
        NSString *string = [NSString stringWithFormat:@"%@", labelString];
        _label.text = string;
        _label.font = [UIFont systemFontOfSize:14];
        [self addSubview:_label];
        
    }
    
    return self;
}

- (void)setTitle:(id)title{
    self.label.text = [NSString stringWithFormat:@"%@", title];
}

- (void)setColor:(UIColor *)color{
    self.button.tintColor = color;
    self.label.textColor = color;
}

@end
