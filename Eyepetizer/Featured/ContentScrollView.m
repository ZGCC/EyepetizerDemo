//
//  ContentScrollView.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "ContentScrollView.h"
#import "ImageContentView.h"
#import "FeaturedModel.h"

@interface ContentScrollView ()
@property (nonatomic, assign, readwrite) NSInteger currentIndex;
@end

@implementation ContentScrollView

- (instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray Index:(NSInteger)index{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentSize = CGSizeMake([imageArray count] * kWidth, 0);
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(index * kWidth, 0);
        
        for (int i = 0; i < [imageArray count]; i++) {
            
            ImageContentView *sonView = [[ImageContentView alloc] initWithFrame:CGRectMake(i * kWidth, 0, kWidth, kHeight) Width:35 Model:imageArray[i] Color:[UIColor whiteColor]];
            
            FeaturedModel *model = [[FeaturedModel alloc] init];
            model = imageArray[i];
            [sonView.picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
            [self addSubview:sonView];
        }
        
    }
    
    return self;
}

@end
