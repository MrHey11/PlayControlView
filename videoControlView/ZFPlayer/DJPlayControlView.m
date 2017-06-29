//
//  DJPlayControlView.m
//  videoControlView
//
//  Created by 丁健 on 17/6/22.
//  Copyright © 2017年 丁健. All rights reserved.
//

#import "DJPlayControlView.h"
#import "ZFPlayer.h"

@implementation DJPlayControlView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self addSubview:self.placeholderImageView];
        [self addSubview:self.topImageView];
        [self addSubview:self.bottomImageView];
        [self.bottomImageView addSubview:self.startBtn];
        [self.bottomImageView addSubview:self.currentTimeLabel];
        [self.bottomImageView addSubview:self.progressView];
        [self.bottomImageView addSubview:self.videoSlider];
        [self.bottomImageView addSubview:self.fullScreenBtn];
        [self.bottomImageView addSubview:self.totalTimeLabel];
        
        [self.topImageView addSubview:self.downLoadBtn];
        [self addSubview:self.lockBtn];
        [self.topImageView addSubview:self.backBtn];
        
//        [self addSubview:self.activity];
        [self addSubview:self.repeatBtn];
        [self addSubview:self.playeBtn];
        [self addSubview:self.failBtn];
        
        [self addSubview:self.fastView];
        [self.fastView addSubview:self.fastImageView];
        [self.fastView addSubview:self.fastTimeLabel];
        [self.fastView addSubview:self.fastProgressView];
        
        [self.topImageView addSubview:self.resolutionBtn];
        [self.topImageView addSubview:self.titleLabel];
        [self addSubview:self.closeBtn];
        [self addSubview:self.bottomProgressView];
        
        // 添加子控件的约束
        [self makeSubViewsConstraints];
        
//       	 self.downLoadBtn.hidden     = YES;
        //        self.resolutionBtn.hidden   = YES;
        
        // 初始化时重置controlView
        [self zf_playerResetControlView];
        
//        // app退到后台
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
//        // app进入前台
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground) name:UIApplicationDidBecomeActiveNotification object:nil];
        
//        [self listeningRotating];
    }
    return self;
}

#pragma mark 初始化创建
/** 重置ControlView */
- (void)zf_playerResetControlView {
    
//    [self.activity stopAnimating];
    
    self.videoSlider.value           = 0;
    self.bottomProgressView.progress = 0;
    self.progressView.progress       = 0;
    self.currentTimeLabel.text       = @"00:00";
    self.totalTimeLabel.text         = @"00:00";
    self.fastView.hidden             = YES;
    self.repeatBtn.hidden            = YES;
    //    self.playeBtn.hidden             = YES;
    self.resolutionView.hidden       = YES;
    self.failBtn.hidden              = YES;
    self.resolutionBtn.hidden 		 = YES;
    self.backgroundColor             = [UIColor clearColor];
    self.downLoadBtn.enabled         = YES;
    self.downLoadBtn.hidden          = NO;
    self.shrink                      = NO;
    self.showing                     = NO;
    self.playeEnd                    = NO;
    self.lockBtn.hidden              = !self.isFullScreen;
    
    self.placeholderImageView.alpha  = 1;
    
    [self showControlView];
    
    //单击手势
    UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [sliderTap setNumberOfTapsRequired:1];
    [self addGestureRecognizer:sliderTap];

}
#pragma mark 添加子控件的约束
- (void)makeSubViewsConstraints {
    [self.placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(7);
        make.top.equalTo(self.mas_top).offset(-7);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(70);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topImageView.mas_leading).offset(10);
        make.top.equalTo(self.topImageView.mas_top).offset(20);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(49);
        make.trailing.equalTo(self.topImageView.mas_trailing).offset(-10);
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
    
    [self.resolutionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(25);
        make.trailing.equalTo(self.downLoadBtn.mas_leading).offset(-10);
        make.centerY.equalTo(self.backBtn.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backBtn.mas_trailing).offset(5);
        make.centerY.equalTo(self.backBtn.mas_centerY);
        make.trailing.equalTo(self.resolutionBtn.mas_leading).offset(-10);
    }];
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomImageView.mas_leading).offset(5);
        make.bottom.equalTo(self.bottomImageView.mas_bottom).offset(-5);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.startBtn.mas_trailing).offset(-3);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.trailing.equalTo(self.bottomImageView.mas_trailing).offset(-5);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.fullScreenBtn.mas_leading).offset(3);
        make.centerY.equalTo(self.startBtn.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentTimeLabel.mas_trailing).offset(4);
        make.trailing.equalTo(self.totalTimeLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.startBtn.mas_centerY);
    }];
    
    [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.currentTimeLabel.mas_trailing).offset(4);
        make.trailing.equalTo(self.totalTimeLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.currentTimeLabel.mas_centerY).offset(-1);
        make.height.mas_equalTo(30);
    }];
    
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(32);
    }];
    
    [self.repeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.playeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.center.equalTo(self);
    }];
    
//    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.with.height.mas_equalTo(45);
//    }];
    
    [self.failBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(33);
    }];
    
    [self.fastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(80);
        make.center.equalTo(self);
    }];
    
    [self.fastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(32);
        make.height.mas_offset(32);
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(self.fastView.mas_centerX);
    }];
    
    [self.fastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.with.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.fastImageView.mas_bottom).offset(2);
    }];
    
    [self.fastProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(12);
        make.trailing.mas_equalTo(-12);
        make.top.mas_equalTo(self.fastTimeLabel.mas_bottom).offset(10);
    }];
    
    [self.bottomProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
}

- (void)setFullScreen:(BOOL)fullScreen{

    _fullScreen = fullScreen;
    
    self.backBtn.hidden = !fullScreen;
    self.fullScreenBtn.selected = fullScreen;
}
#pragma mark --getter创建
#pragma mark 标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}
#pragma mark 返回
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:ZFPlayerImage(@"ZFPlayer_back_full") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
#pragma mark 上部背景
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView                        = [[UIImageView alloc] init];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.alpha                  = 0;
        _topImageView.image                  = ZFPlayerImage(@"ZFPlayer_top_shadow");
    }
    return _topImageView;
}
#pragma mark 底部背景
- (UIImageView *)bottomImageView {
    if (!_bottomImageView) {
        _bottomImageView                        = [[UIImageView alloc] init];
        _bottomImageView.userInteractionEnabled = YES;
        _bottomImageView.alpha                  = 0;
        _bottomImageView.image                  = ZFPlayerImage(@"ZFPlayer_bottom_shadow");
    }
    return _bottomImageView;
}
#pragma mark 锁屏
- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:ZFPlayerImage(@"ZFPlayer_unlock-nor") forState:UIControlStateNormal];
        [_lockBtn setImage:ZFPlayerImage(@"ZFPlayer_lock-nor") forState:UIControlStateSelected];
        [_lockBtn addTarget:self action:@selector(lockScrrenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _lockBtn;
}
#pragma mark 开始
- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:ZFPlayerImage(@"ZFPlayer_play") forState:UIControlStateNormal];
        [_startBtn setImage:ZFPlayerImage(@"ZFPlayer_pause") forState:UIControlStateSelected];
        
        [_startBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
#pragma mark 关闭
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:ZFPlayerImage(@"ZFPlayer_close") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}
#pragma mark 当前播放时间
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel               = [[UILabel alloc] init];
        _currentTimeLabel.textColor     = [UIColor whiteColor];
        _currentTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
#pragma mark 总时间
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel               = [[UILabel alloc] init];
        _totalTimeLabel.textColor     = [UIColor whiteColor];
        _totalTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

#pragma mark 进度视图
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView                   = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _progressView.trackTintColor    = [UIColor clearColor];
    }
    return _progressView;
}
#pragma mark 进度条
- (ASValueTrackingSlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider                       = [[ASValueTrackingSlider alloc] init];
        _videoSlider.popUpViewCornerRadius = 0.0;
        _videoSlider.popUpViewColor = RGBA(19, 19, 9, 1);
        _videoSlider.popUpViewArrowLength = 8;
        
        [_videoSlider setThumbImage:ZFPlayerImage(@"ZFPlayer_slider") forState:UIControlStateNormal];
        _videoSlider.maximumValue          = 1;
        _videoSlider.minimumTrackTintColor = [UIColor whiteColor];
        _videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        
        // slider开始滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        
        // slider滑动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        // slider结束滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        
        
//        UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
//        [_videoSlider addGestureRecognizer:sliderTap];
//        
//        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
//        panRecognizer.delegate = self;
//        [panRecognizer setMaximumNumberOfTouches:1];
//        [panRecognizer setDelaysTouchesBegan:YES];
//        [panRecognizer setDelaysTouchesEnded:YES];
//        [panRecognizer setCancelsTouchesInView:YES];
//        [_videoSlider addGestureRecognizer:panRecognizer];
    }
    return _videoSlider;
}

#pragma mark 全屏按钮
- (UIButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:ZFPlayerImage(@"ZFPlayer_fullscreen") forState:UIControlStateNormal];
        [_fullScreenBtn setImage:ZFPlayerImage(@"ZFPlayer_shrinkscreen") forState:UIControlStateSelected];
        [_fullScreenBtn addTarget:self action:@selector(fullScreenBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}

//- (MMMaterialDesignSpinner *)activity {
//    if (!_activity) {
//        _activity = [[MMMaterialDesignSpinner alloc] init];
//        _activity.lineWidth = 1;
//        _activity.duration  = 1;
//        _activity.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
//    }
//    return _activity;
//}

- (UIButton *)repeatBtn {
    if (!_repeatBtn) {
        _repeatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repeatBtn setImage:ZFPlayerImage(@"ZFPlayer_repeat_video") forState:UIControlStateNormal];
        [_repeatBtn addTarget:self action:@selector(repeatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repeatBtn;
}

- (UIButton *)downLoadBtn {
    if (!_downLoadBtn) {
        _downLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downLoadBtn setImage:[UIImage imageNamed:@"静音-3.png"] forState:UIControlStateNormal];
        [_downLoadBtn setImage:[UIImage imageNamed:@"声音-3.png"] forState:UIControlStateSelected];
        [_downLoadBtn addTarget:self action:@selector(downloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadBtn;
}

- (UIButton *)resolutionBtn {
    if (!_resolutionBtn) {
        _resolutionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _resolutionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _resolutionBtn.backgroundColor = RGBA(0, 0, 0, 0.7);
        [_resolutionBtn addTarget:self action:@selector(resolutionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resolutionBtn;
}

- (UIButton *)playeBtn {
    if (!_playeBtn) {
        _playeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playeBtn setImage:ZFPlayerImage(@"ZFPlayer_play_btn") forState:UIControlStateNormal];
        [_playeBtn addTarget:self action:@selector(centerPlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playeBtn;
}

- (UIButton *)failBtn {
    if (!_failBtn) {
        _failBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_failBtn setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _failBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _failBtn.backgroundColor = RGBA(0, 0, 0, 0.7);
        [_failBtn addTarget:self action:@selector(failBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failBtn;
}

- (UIView *)fastView {
    if (!_fastView) {
        _fastView                     = [[UIView alloc] init];
        _fastView.backgroundColor     = RGBA(0, 0, 0, 0.8);
        _fastView.layer.cornerRadius  = 4;
        _fastView.layer.masksToBounds = YES;
    }
    return _fastView;
}

- (UIImageView *)fastImageView {
    if (!_fastImageView) {
        _fastImageView = [[UIImageView alloc] init];
    }
    return _fastImageView;
}

- (UILabel *)fastTimeLabel {
    if (!_fastTimeLabel) {
        _fastTimeLabel               = [[UILabel alloc] init];
        _fastTimeLabel.textColor     = [UIColor whiteColor];
        _fastTimeLabel.textAlignment = NSTextAlignmentCenter;
        _fastTimeLabel.font          = [UIFont systemFontOfSize:14.0];
    }
    return _fastTimeLabel;
}

- (UIProgressView *)fastProgressView {
    if (!_fastProgressView) {
        _fastProgressView                   = [[UIProgressView alloc] init];
        _fastProgressView.progressTintColor = [UIColor whiteColor];
        _fastProgressView.trackTintColor    = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    return _fastProgressView;
}

- (UIImageView *)placeholderImageView {
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc] init];
        _placeholderImageView.userInteractionEnabled = YES;
    }
    return _placeholderImageView;
}

- (UIProgressView *)bottomProgressView {
    if (!_bottomProgressView) {
        _bottomProgressView                   = [[UIProgressView alloc] init];
        _bottomProgressView.progressTintColor = [UIColor whiteColor];
        _bottomProgressView.trackTintColor    = [UIColor clearColor];
    }
    return _bottomProgressView;
}

#pragma mark 显示控制栏
- (void)showControlView {
//    self.showing = YES;
    if (self.lockBtn.isSelected) {
        self.topImageView.alpha    = 0;
        self.bottomImageView.alpha = 0;
    } else {
        self.topImageView.alpha    = 1;
        self.bottomImageView.alpha = 1;
    }
    self.backgroundColor           = RGBA(0, 0, 0, 0.2);
    self.lockBtn.alpha             = 1;
    if (self.isCellVideo) {
        self.shrink                = NO;
    }
    self.bottomProgressView.alpha  = 0;
    ZFPlayerShared.isStatusBarHidden = NO;
    
    
}
#pragma mark 隐藏控制栏
- (void)hideControlView {
//    self.showing = NO;
    self.backgroundColor          = RGBA(0, 0, 0, 0);
    self.topImageView.alpha       = self.playeEnd;
    self.bottomImageView.alpha    = 0;
    self.lockBtn.alpha            = 0;
    self.bottomProgressView.alpha = 1;
   
    // 隐藏resolutionView
    self.resolutionBtn.selected = YES;
    
//    [self resolutionBtnClick:self.resolutionBtn];
    
    if (self.isFullScreen && !self.playeEnd && !self.isShrink) {
        ZFPlayerShared.isStatusBarHidden = YES;
    }
}
/**
 *  显示控制层
 */
- (void)zf_playerShowControlView {
//    if ([self.delegate respondsToSelector:@selector(zf_controlViewWillShow:isFullscreen:)]) {
//        [self.delegate zf_controlViewWillShow:self isFullscreen:self.isFullScreen];
//    }
//    [self zf_playerCancelAutoFadeOutControlView];
//    
//    [UIView animateWithDuration:ZFPlayerControlBarAutoFadeOutTimeInterval animations:^{
//        [self showControlView];
//    } completion:^(BOOL finished) {
//        self.showing = YES;
//        [self autoFadeOutControlView];
//    }];
}

/**
 *  隐藏控制层
 */
- (void)zf_playerHideControlView {
//    if ([self.delegate respondsToSelector:@selector(zf_controlViewWillHidden:isFullscreen:)]) {
//        [self.delegate zf_controlViewWillHidden:self isFullscreen:self.isFullScreen];
//    }
//    [self zf_playerCancelAutoFadeOutControlView];
//    [UIView animateWithDuration:ZFPlayerControlBarAutoFadeOutTimeInterval animations:^{
//        [self hideControlView];
//    } completion:^(BOOL finished) {
//        self.showing = NO;
//    }];
}

#pragma mark ---------按钮点击--------------
#pragma mark 返回按钮
- (void)backBtnClick:(UIButton *)sender {
    
    
    // 状态条的方向旋转的方向,来判断当前屏幕的方向
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    // 在cell上并且是竖屏时候响应关闭事件
//    if (self.isCellVideo && orientation == UIInterfaceOrientationPortrait) {
//        if ([self.delegate respondsToSelector:@selector(zf_controlView:closeAction:)]) {
//            [self.delegate zf_controlView:self closeAction:sender];
//        }
//    } else {
//        if ([self.delegate respondsToSelector:@selector(zf_controlView:backAction:)]) {
//            [self.delegate zf_controlView:self backAction:sender];
//        }
//    }
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:backAction:)]) {
        
        [self.conTrolDelegate zf_controlView:self backAction:sender];
        
    }

}

- (void)lockScrrenBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.showing = NO;
//    [self zf_playerShowControlView];
//    if ([self.delegate respondsToSelector:@selector(zf_controlView:lockScreenAction:)]) {
//        [self.delegate zf_controlView:self lockScreenAction:sender];
//    }
}
#pragma mark 播放按钮
- (void)playBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:playAction:)]) {
        [self.conTrolDelegate zf_controlView:self playAction:sender];
    }
}
#pragma mark 中心播放按钮
- (void)centerPlayBtnClick:(UIButton *)sender {
    
    self.startBtn.selected = !self.startBtn.selected;

    //    if ([self.delegate respondsToSelector:@selector(zf_controlView:cneterPlayAction:)]) {
    //        [self.delegate zf_controlView:self cneterPlayAction:sender];
    //    }
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:playAction:)]) {
        [self.conTrolDelegate zf_controlView:self playAction:self.startBtn];
    }

}
- (void)closeBtnClick:(UIButton *)sender {
    
    
//    if ([self.delegate respondsToSelector:@selector(zf_controlView:closeAction:)]) {
//        [self.delegate zf_controlView:self closeAction:sender];
//    }
}

#pragma mark 全屏按钮
- (void)fullScreenBtnClick1:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:fullScreenAction:)]) {
        [self.conTrolDelegate zf_controlView:self fullScreenAction:sender];
    }
}

- (void)repeatBtnClick:(UIButton *)sender {
    // 重置控制层View
//    [self zf_playerResetControlView];
//    [self zf_playerShowControlView];
//    if ([self.delegate respondsToSelector:@selector(zf_controlView:repeatPlayAction:)]) {
//        [self.delegate zf_controlView:self repeatPlayAction:sender];
//    }
}

#pragma mark 声音按钮
- (void)downloadBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:downloadVideoAction:)]) {
        [self.conTrolDelegate zf_controlView:self downloadVideoAction:sender];
    }
}

- (void)resolutionBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 显示隐藏分辨率View
    self.resolutionView.hidden = !sender.isSelected;
}



- (void)failBtnClick:(UIButton *)sender {
//    self.failBtn.hidden = YES;
//    if ([self.delegate respondsToSelector:@selector(zf_controlView:failAction:)]) {
//        [self.delegate zf_controlView:self failAction:sender];
//    }
}

#pragma mark 进度条滑动
- (void)progressSliderTouchBegan:(ASValueTrackingSlider *)sender {
    /***  取消延时隐藏controlView的方法*/
    [self zf_playerCancelAutoFadeOutControlView];
    self.videoSlider.popUpView.hidden = YES;
   
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:progressSliderTouchBegan:)]) {
        [self.conTrolDelegate zf_controlView:self progressSliderTouchBegan:sender];
    }
}

- (void)progressSliderValueChanged:(ASValueTrackingSlider *)sender {
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:progressSliderValueChanged:)]) {
        [self.conTrolDelegate zf_controlView:self progressSliderValueChanged:sender];
    }
}

- (void)progressSliderTouchEnded:(ASValueTrackingSlider *)sender {
    self.showing = YES;
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:progressSliderTouchEnded:)]) {
        [self.conTrolDelegate zf_controlView:self progressSliderTouchEnded:sender];
    }
}
#pragma mark --单击手势
- (void)tapAction:(UITapGestureRecognizer *)tap {
//    if ([tap.view isKindOfClass:[UISlider class]]) {
//        UISlider *slider = (UISlider *)tap.view;
//        CGPoint point = [tap locationInView:slider];
//        CGFloat length = slider.frame.size.width;
//        // 视频跳转的value
//        CGFloat tapValue = point.x / length;
//        if ([self.delegate respondsToSelector:@selector(zf_controlView:progressSliderTap:)]) {
//            [self.delegate zf_controlView:self progressSliderTap:tapValue];
//        }
//    }
    self.showing = !self.showing;
    if(self.showing){
    
        [self showControlView];
    }else{
    
        [self hideControlView];
    }
    if ([self.conTrolDelegate respondsToSelector:@selector(zf_controlView:SingleTapGesture:)]) {
        [self.conTrolDelegate zf_controlView:self SingleTapGesture:tap];
    }

}
#pragma mark /** 播放按钮状态 */

- (void)zf_playerPlayBtnState:(BOOL)state {
    self.startBtn.selected = state;
    self.playeBtn.hidden = state;
}

#pragma mark/***  取消延时隐藏controlView的方法*/
- (void)zf_playerCancelAutoFadeOutControlView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
/**
 slider滑块的bounds
 */
- (CGRect)thumbRect {
    return [self.videoSlider thumbRectForBounds:self.videoSlider.bounds
                                      trackRect:[self.videoSlider trackRectForBounds:self.videoSlider.bounds]
                                          value:self.videoSlider.value];
}
@end
