//
//  FeaturedModel.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "FeaturedModel.h"

@implementation FeaturedModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        self.descript = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.ID = [value stringValue];
    }
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"duration"]) {
        self.duration = [value stringValue];
    }
    
}

@end
