//
//  rilegouleView.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentView;
@class ContentScrollView;
@class FeaturedTableViewCell;

@interface rilegouleView : UIView

@property (nonatomic, strong) ContentView *contentView;

@property (nonatomic, strong) ContentScrollView *scrollView;

@property (nonatomic, strong) FeaturedTableViewCell *animationView;

@property (nonatomic, strong) UIImageView *playView;

@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray Index:(NSInteger)index;

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGAffineTransform animationTrans;

- (void)animationShow;
- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete;

@end
