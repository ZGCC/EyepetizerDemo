//
//  FeaturedModel.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeaturedModel : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSNumber *collecttionCount;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSNumber *sharedCount;
@property (nonatomic, strong) NSString *coverBlurred;
@property (nonatomic, strong) NSString *coverForDetail;
@property (nonatomic, strong) NSString *descript;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *playUrl;

@end
