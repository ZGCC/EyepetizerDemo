//
//  ContentScrollView.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentScrollView;
@class ImageContentView;

@protocol ContentScrollViewDelegate <UIScrollViewDelegate>

- (void)headerScroll:(ContentScrollView *)scroll DidSelectItemAtIndex:(NSInteger)index;

- (void)headerScroll:(ContentScrollView *)scroll DidClose:(BOOL)close;

@end

@interface ContentScrollView : UIScrollView

@property (nonatomic, assign, readonly) NSInteger currentIndex;

- (void)setCurrentIndex:(NSInteger)currentIndex;

- (instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray Index:(NSInteger)index;

@end
