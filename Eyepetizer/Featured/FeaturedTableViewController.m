//
//  FeaturedTableViewController.m
//  Eyepetizer
//
//  Created by ZGCC on 16/9/21.
//  Copyright © 2016年 ZGCC. All rights reserved.
//

#import "FeaturedTableViewController.h"
#import "rilegouleView.h"
#import "FeaturedModel.h"
#import "FeaturedTableViewCell.h"
#import "ContentScrollView.h"
#import "ContentView.h"
#import "CustomView.h"
#import "ImageContentView.h"

@interface SDWebImageManager (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url;

@end

@implementation SDWebImageManager (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url{
    
    NSString *key = [self cacheKeyForURL:url];
    return ([self.imageCache imageFromMemoryCacheForKey:key] != nil) ? YES : NO;
}

@end

@interface FeaturedTableViewController ()
@property (nonatomic, retain) NSMutableDictionary *selectDic;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *allData;
@property (nonatomic, strong) WMPlayer *WmPlayer;
@end

@implementation FeaturedTableViewController

#pragma mark - 数据解析

//懒加载
- (NSMutableDictionary *)selectDic{
    
    if (!_selectDic) {
        _selectDic = [[NSMutableDictionary alloc] init];
    }
    return _selectDic;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)allData{
    if (!_allData) {
        _allData = [[NSMutableArray alloc] init];
    }
    return _allData;
}

- (void)jsonSelection{
    NSLog(@"---%s", __FUNCTION__);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *url = [NSString stringWithFormat:kEyepetizer, dateString];
    
    [LORequestManger GET:url success:^(id response) {
        
        NSDictionary *dic = (NSDictionary *)response;
        
        NSArray *array = dic[@"dailyList"];
        
        for (NSDictionary *dic in array) {
            
            NSMutableArray *selectArray = [NSMutableArray array];
            NSArray *arr = dic[@"videoList"];
            
            for (NSDictionary *dic1 in arr) {
                FeaturedModel *model = [[FeaturedModel alloc] init];
                [model setValuesForKeysWithDictionary:dic1];
                model.collecttionCount = dic1[@"consumption"][@"collectionCount"];
                model.replyCount = dic1[@"consumption"][@"replyCount"];
                model.sharedCount = dic1[@"consumption"][@"shareCount"];
                
                [selectArray addObject:model];
                [_allData addObject:model];
            }
            NSString *date = [[dic[@"date"] stringValue] substringToIndex:10];
            
            [self.selectDic setValue:selectArray forKey:date];
        }
        
        NSComparisonResult (^priceBlock)(NSString *, NSString *) = ^(NSString *string1, NSString *string2){
            
            NSInteger number1 = [string1 integerValue];
            NSInteger number2 = [string2 integerValue];
            
            if (number1 > number2) {
                return NSOrderedAscending;
            }else if (number1 < number2){
                return NSOrderedDescending;
            }else{
                return NSOrderedSame;
            }
            
        };
        
        self.dataArray = [[[self.selectDic allKeys] sortedArrayUsingComparator:priceBlock] mutableCopy];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 加载页面

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self jsonSelection];
    
    [self.tableView setFrame:CGRectMake(0, -55, kWidth, kHeight - 49 + 55)];
    
    [self.tableView registerClass:[FeaturedTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo:) name:@"closeTheVideo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

- (void)videoDidFinished:(NSNotification *)notice{
    [_WmPlayer removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)closeTheVideo:(NSNotification *)notice{
    
    [_WmPlayer.player.currentItem cancelPendingSeeks];
    [_WmPlayer.player.currentItem.asset cancelLoading];
    
    [_WmPlayer.player pause];
    [_WmPlayer removeFromSuperview];
    [_WmPlayer.playerLayer removeFromSuperlayer];
    [_WmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _WmPlayer = nil;
    _WmPlayer.player = nil;
    _WmPlayer.currentItem = nil;
    
    _WmPlayer.playOrPauseBtn = nil;
    _WmPlayer.playerLayer = nil;
    
}

- (void)fullScreenBtnClick:(NSNotification *)notice{
    NSLog(@"---%s", __FUNCTION__);
    
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self toSmallScreen];
    }
    
}

- (void)toSmallScreen{
    
    [_WmPlayer removeFromSuperview];
    
    [UIView animateWithDuration:.5 animations:^{
        
        _WmPlayer.transform = CGAffineTransformIdentity;
        _WmPlayer.frame = CGRectMake(0, 20, kWidth, kHeight / 1.7);
        _WmPlayer.playerLayer.frame = _WmPlayer.bounds;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_WmPlayer];
        
        [_WmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_WmPlayer).with.offset(0);
            make.right.equalTo(_WmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_WmPlayer).with.offset(0);
        }];
        
        [_WmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_WmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_WmPlayer).with.offset(5);
        }];
        
    } completion:^(BOOL finished) {
        
        _WmPlayer.isFullscreen = NO;
        _WmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_WmPlayer];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
    }];
    
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    NSLog(@"---%s", __FUNCTION__);
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [_WmPlayer removeFromSuperview];
    
    _WmPlayer.transform = CGAffineTransformIdentity;
    _WmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _WmPlayer.frame = CGRectMake(0, 0, kWidth, kHeight);
    _WmPlayer.playerLayer.frame = CGRectMake(0, 0, kHeight, kWidth);
    
    [_WmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kWidth - 40);
        make.width.mas_equalTo(kHeight);
    }];
    
    [_WmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_WmPlayer).with.offset(-kHeight / 2);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_WmPlayer).with.offset(5);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_WmPlayer];
    _WmPlayer.isFullscreen = YES;
    _WmPlayer.fullScreenBtn.selected = YES;
    [_WmPlayer bringSubviewToFront:_WmPlayer.bottomView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FeaturedTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeaturedModel *model = self.allData[indexPath.row];
    
    if (![[SDWebImageManager sharedManager] memoryCachedImageExistsForURL:[NSURL URLWithString:model.coverForDetail]]) {
        
        CATransform3D rotation;
        rotation = CATransform3DMakeTranslation(0, 50, 20);
        rotation = CATransform3DScale(rotation, 0.9, .9, 1);
        rotation.m34 = 1.0 / -600;
        
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = rotation;
        
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.6];
        
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
        
    }
    
    [cell cellOffset];
    cell.model = model;
}

#pragma mark - 单元格代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---%s", __FUNCTION__);
    
    [self showImageAtIndexPath:indexPath];
}

#pragma mark - 设置待播放界面
- (void)showImageAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---%s", __FUNCTION__);
    
    _currentIndexPath = indexPath;
    
    FeaturedTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    CGFloat y = rect.origin.y;
    
    _rilegoule = [[rilegouleView alloc] initWithFrame:CGRectMake(0, -44, kWidth, kHeight + 44) ImageArray:_allData Index:indexPath.row];
    _rilegoule.offsetY = y;
    _rilegoule.animationTrans = cell.picture.transform;
    _rilegoule.animationView.picture.image = cell.picture.image;
    
    _rilegoule.scrollView.delegate = self;
    
    [[self.tableView superview] addSubview:_rilegoule];
    
    //收起
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    _rilegoule.contentView.userInteractionEnabled = YES;
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_rilegoule.contentView addGestureRecognizer:swipe];
    
    //播放
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_rilegoule.scrollView addGestureRecognizer:tap];
    
    [_rilegoule animationShow];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_rilegoule.scrollView]) {
        
        for (ImageContentView *subView in scrollView.subviews) {
            if ([subView respondsToSelector:@selector(imageOffset)]) {
                [subView imageOffset];
            }
        }
        
        CGFloat x = _rilegoule.scrollView.contentOffset.x;
        CGFloat off = ABS(((int)x % (int)kWidth) - kWidth / 2) / (kWidth / 2) + .2;
        
        [UIView animateWithDuration:1.0 animations:^{
            _rilegoule.playView.alpha = off;
            _rilegoule.contentView.titleLabel.alpha = off + 0.3;
            _rilegoule.contentView.littleLabel.alpha = off + 0.3;
            _rilegoule.contentView.lineView.alpha = off + 0.3;
            _rilegoule.contentView.descriptLabel.alpha = off + 0.3;
            _rilegoule.contentView.collectionCustom.alpha = off + 0.3;
            _rilegoule.contentView.shareCustom.alpha = off + 0.3;
            _rilegoule.contentView.cacheCustom.alpha = off + 0.3;
            _rilegoule.contentView.replyCustom.alpha = off + 0.3;
        }];
        
    }else{
        
        NSArray<FeaturedTableViewCell *> *array = [self.tableView visibleCells];
        
        [array enumerateObjectsUsingBlock:^(FeaturedTableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj cellOffset];
        }];
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_rilegoule.scrollView]) {
        
        int index = floor((_rilegoule.scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
        
        _rilegoule.scrollView.currentIndex = index;
        
        self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:self.currentIndexPath.section];
        
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
        
        [self.tableView setNeedsDisplay];
        
        FeaturedTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        [cell cellOffset];
        
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        _rilegoule.animationTrans = cell.picture.transform;
        _rilegoule.offsetY = rect.origin.y;
        
        FeaturedModel *model = _allData[index];
        
        [_rilegoule.contentView setData:model];
        [_rilegoule.animationView.picture setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
        
    }
    
}

#pragma mark - 平移手势
- (void)panAction:(UISwipeGestureRecognizer *)swipe{
    NSLog(@"---%s", __FUNCTION__);
    
    if (_WmPlayer.superview) {
        [_WmPlayer removeFromSuperview];
    }
    
    [_rilegoule animationDismissUsingCompeteBlock:^{
        _rilegoule = nil;
    }];
}

#pragma mark - 点击手势
- (void)tapAction{
    NSLog(@"---%s", __FUNCTION__);
    
    FeaturedModel *model = [_allData objectAtIndex:self.currentIndexPath.row];
    
    if (_WmPlayer) {
        [_WmPlayer setVideoURLStr:model.playUrl];
        [_WmPlayer.player play];
    }else{
        _WmPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 20, kWidth, kHeight / 1.7 - 20) videoURLStr:model.playUrl];
        [_WmPlayer.player play];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:_WmPlayer];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

@end
