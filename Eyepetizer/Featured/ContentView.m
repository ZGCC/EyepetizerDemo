//
//  ContentView.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "ContentView.h"
#import "FeaturedModel.h"
#import "CustomView.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width Model:(FeaturedModel *)model Color:(UIColor *)color{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kWidth, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = color;
        [self addSubview:_titleLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 35, 200, 1)];
        _lineView.backgroundColor = color;
        [self addSubview:_lineView];
        
        _littleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 46, kWidth, 20)];
        _littleLabel.textColor = color;
        _littleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_littleLabel];
        
        _descriptLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, kWidth - 10, 90)];
        _descriptLabel.font = [UIFont systemFontOfSize:14];
        _descriptLabel.numberOfLines = 0;
        _descriptLabel.textColor = color;
        [self addSubview:_descriptLabel];
        
        CGFloat y = self.bounds.size.height - width;
        _collectionCustom = [[CustomView alloc] initWithFrame:CGRectMake(5, y, (kWidth - 10) / 4, 30) Width:width LabelString:model.collecttionCount color:color];
        [self addSubview:_collectionCustom];
        
        _shareCustom = [[CustomView alloc] initWithFrame:CGRectMake((kWidth - 10) / 4 + 5, y, (kWidth - 10) / 4, 30) Width:width LabelString:model.sharedCount color:color];
        [self addSubview:_shareCustom];
        
        _cacheCustom = [[CustomView alloc] initWithFrame:CGRectMake(_shareCustom.frame.origin.x + _shareCustom.frame.size.width, y, (kWidth - 10) / 4, 30) Width:width LabelString:@"缓存" color:color];
        [self addSubview:_cacheCustom];
        
        _replyCustom = [[CustomView alloc] initWithFrame:CGRectMake(_cacheCustom.frame.origin.x + _cacheCustom.frame.size.width, y, (kWidth - 10) / 4, 30) Width:width LabelString:model.replyCount color:color];
        [self addSubview:_replyCustom];
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
        
        [self setData:model];
        
    }
    
    return self;
}

- (void)setData:(FeaturedModel *)model{
    
    self.titleLabel.text = model.title;
    self.descriptLabel.text = model.descript;
    [self.shareCustom setTitle:model.sharedCount];
    [self.replyCustom setTitle:model.replyCount];
    [self.collectionCustom setTitle:model.collecttionCount];
    
    NSInteger time = [model.duration integerValue];
    NSString *timeString = [NSString stringWithFormat:@"%02ld'%02ld''", time / 60, time % 60];
    NSString *string = [NSString stringWithFormat:@"#%@ / %@", model.category, timeString];
    self.littleLabel.text = string;
    
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.coverBlurred] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (image) {
            
            CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
            contentsAnimation.duration = 1.0f;
            contentsAnimation.fromValue = self.imageView.image;
            contentsAnimation.toValue = image;
            
            contentsAnimation.removedOnCompletion = YES;
            contentsAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [weakSelf.imageView.layer addAnimation:contentsAnimation forKey:nil];
            weakSelf.imageView.image = image;
        }
        
    }];
    
    
}

@end
