//
//  ImageContentView.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "ImageContentView.h"
#import "ContentView.h"
#import "FeaturedModel.h"

@implementation ImageContentView

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width Model:(FeaturedModel *)model Color:(UIColor *)color{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.clipsToBounds = YES;
        _picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 1.7)];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_picture];
    }
    
    return self;
}

- (void)imageOffset{
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:nil];
    
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.window.center;
    
    CGFloat cellOffsetX = centerY - windowCenter.x;
    CGFloat offsetDig = cellOffsetX / self.window.frame.size.height * 2;
    
    CGAffineTransform transX = CGAffineTransformMakeTranslation(-offsetDig * kWidth * 0.7, 0);
    self.picture.transform = transX;
    
}

@end
