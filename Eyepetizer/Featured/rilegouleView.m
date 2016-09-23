//
//  rilegouleView.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "rilegouleView.h"
#import "ContentView.h"
#import "ContentScrollView.h"
#import "FeaturedModel.h"
#import "FeaturedTableViewCell.h"

@implementation rilegouleView

- (instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray Index:(NSInteger)index{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        
        _scrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) ImageArray:imageArray Index:index];
        [self addSubview:_scrollView];
        
        self.scrollView.userInteractionEnabled = YES;
        
        FeaturedModel *model = imageArray[index];
        
        _contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, kHeight / 1.7, kWidth, kHeight - kHeight / 1.7) Width:35 Model:model Color:[UIColor whiteColor]];
        [_contentView setData:model];
        [self addSubview:_contentView];
        
        _playView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth - 100) / 2, (kHeight / 1.7 - 100) / 2, 100, 100)];
        _playView.image = [UIImage imageNamed:@"video-play"];
        [self addSubview:_playView];
        
        _animationView = [[FeaturedTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        [_animationView.coverView removeFromSuperview];
        
        [self addSubview:_animationView];
        
        _playView.alpha = 0;
        _scrollView.alpha = 0;
        
    }
    
    return self;
    
}

- (void)animationShow{
    NSLog(@"---%s", __FUNCTION__);
    
    self.contentView.frame = CGRectMake(0, self.offsetY, kWidth, CellHeight);
    self.animationView.frame = CGRectMake(0, self.offsetY, kWidth, CellHeight);
    self.animationView.picture.transform = self.animationTrans;
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.animationView.frame = CGRectMake(0, 0, kWidth, kHeight / 1.7);
        self.animationView.picture.transform = CGAffineTransformMakeTranslation(0, (kHeight / 1.7 - CellHeight) / 2);
        
        self.contentView.frame = CGRectMake(0, kHeight / 1.7, kWidth, kHeight - kHeight / 1.7);
        
    } completion:^(BOOL finished) {
        
        self.scrollView.alpha = 1;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.animationView.alpha = 0;
            self.playView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete{
    NSLog(@"---%s", __FUNCTION__);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.animationView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        self.scrollView.alpha = 0;
        self.playView.alpha = 0;
        
        [UIView animateWithDuration:.5 animations:^{
            
            CGRect rec = self.animationView.frame;
            rec.origin.y = self.offsetY + 44;
            rec.size.height = CellHeight;
            self.animationView.frame = rec;
            self.animationView.picture.transform = self.animationTrans;
            self.contentView.frame = rec;
            
        } completion:^(BOOL finished) {
            
            self.animationTrans = CGAffineTransformIdentity;
            [self.contentView removeFromSuperview];
            [UIView animateWithDuration:.25 animations:^{
                self.animationView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                complete();
            }];
            
        }];
        
    }];
    
}

@end
