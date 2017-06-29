//
//  ViewController.m
//  videoControlView
//
//  Created by 丁健 on 17/6/21.
//  Copyright © 2017年 丁健. All rights reserved.
//

#import "ViewController.h"

#import "DJPlayControlView.h"
@interface ViewController ()<ZFPlayerControlViewDelagate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *modelV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    modelV.center = self.view.center;
    modelV.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:modelV];
    
    
	DJPlayControlView *controlV = [[DJPlayControlView alloc] init];
    controlV.frame = CGRectMake(0, 0, 400, 300);
    //代理
    controlV.conTrolDelegate = self;

    controlV.titleLabel.text= @"视频标题";
    [modelV addSubview:controlV];

}
#pragma mark ==========================DJControlViewDelegate控制栏协议======================
#pragma mark 全屏按钮事件
- (void)zf_controlView:(UIView *)controlView fullScreenAction:(UIButton *)sender {
    
    NSLog(@"全屏按钮事件");
    
}
#pragma mark 返回(退出)按钮事件
- (void)zf_controlView:(UIView *)controlView backAction:(UIButton *)sender {
    
    //退出全屏
     NSLog(@"返回(退出)按钮事件");
    
}
#pragma mark 播放/暂停
- (void)zf_controlView:(UIView *)controlView playAction:(UIButton *)sender {
    
     NSLog(@"播放/暂停按钮事件");
}
#pragma mark/** 开始触摸slider */
- (void)zf_controlView:(UIView *)controlView progressSliderTouchBegan:(UISlider *)slider{
    NSLog(@"开始触摸slider");
}
#pragma mark/** slider触摸中 */
- (void)zf_controlView:(UIView *)controlView progressSliderValueChanged:(UISlider *)slider{
    
   NSLog(@"slider触摸中");
}
#pragma mark/** slider触摸结束 */
- (void)zf_controlView:(UIView *)controlView progressSliderTouchEnded:(UISlider *)slider{
    
  NSLog(@"slider触摸结束");
}
#pragma mark/** 单击手势事件 */
- (void)zf_controlView:(UIView *)controlView SingleTapGesture:(UITapGestureRecognizer *)sender{
    
	NSLog(@"单击手势事件");
}
#pragma mark/** 声音按钮事件 */
- (void)zf_controlView:(UIView *)controlView downloadVideoAction:(UIButton *)sender{
    

    NSLog(@"声音按钮事件");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
