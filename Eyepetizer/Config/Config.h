//
//  Config.h
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#ifndef Config_h
#define Config_h

#pragma mark - TabBar
#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

#pragma mark - 屏宽高
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height

#pragma mark - 请求路径
#define kEyepetizer @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"

#pragma mark - cell高
#define CellHeight 170.0

#endif /* Config_h */
