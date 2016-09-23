//
//  FeaturedTableViewCell.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "FeaturedTableViewCell.h"
#import "FeaturedModel.h"

@implementation FeaturedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        
        _picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(kHeight / 1.7 - CellHeight) / 2, kWidth, kHeight / 1.7)];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_picture];
        
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, CellHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
        [self.contentView addSubview:_coverView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CellHeight / 2 - 30, kWidth, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:0.7];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
        _littleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CellHeight / 2, kWidth, 30)];
        _littleLabel.font = [UIFont systemFontOfSize:14];
        _littleLabel.textAlignment = NSTextAlignmentCenter;
        _littleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_littleLabel];
        
    }
    return self;
}

- (void)setModel:(FeaturedModel *)model{
    
    if (_model != model) {
        
        [_picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
        
        _titleLabel.text = model.title;
        
        NSInteger time = [model.duration integerValue];
        
        NSString *timeString = [NSString stringWithFormat:@"%02ld '%02ld''", time / 60, time % 60];
        NSString *string = [NSString stringWithFormat:@"#%@ / %@", model.category, timeString];
        
        _littleLabel.text = string;
    }
    
}

- (CGFloat)cellOffset{
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig = cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset = -offsetDig * (kHeight / 1.7 - CellHeight) / 2;
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0, offset);
    
    self.picture.transform = transY;
    
    return offset;
}

@end
