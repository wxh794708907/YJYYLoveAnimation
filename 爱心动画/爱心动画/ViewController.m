//
//  ViewController.m
//  爱心动画
//
//  Created by 远洋 on 16/2/28.
//  Copyright © 2016年 yuayang. All rights reserved.
//

#import "ViewController.h"
// 屏幕宽度
#define SCREENWIDTH    ([[UIScreen mainScreen] bounds].size.width)
// 屏幕高度
#define SCREENHEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()
//全局的CAReplicatorLayer
@property (nonatomic, strong) CAReplicatorLayer *loveLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    welcomeLabel.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:welcomeLabel];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.text = @"欢迎回来";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startLoveAnimate:(id)sender {

    //组成爱心路径的view
    UIView * pathView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    //中心点为爱心路径的起点
    pathView.center = CGPointMake(SCREENWIDTH/2.0, 300);
    //圆角
    pathView.layer.cornerRadius = 6;
    pathView.layer.masksToBounds = YES;
    pathView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    //添加动画效果
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //使用爱心路径来进行动画
    loveAnimation.path = [self lovePath].CGPath;
    //动画时长
    loveAnimation.duration = 8;
    //动画重复次数
    loveAnimation.repeatCount = MAXFLOAT;
    //添加动画
    [pathView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    //实例化CAReplicatorLayer
    _loveLayer = [CAReplicatorLayer layer];
    _loveLayer.instanceCount = 80;                // 40个layer
    _loveLayer.instanceDelay = 0.2;               // 每隔0.2出现一个layer
    _loveLayer.instanceColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
//    _loveLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
//    _loveLayer.instanceRedOffset = -0.02;         // 颜色值递减。
//    _loveLayer.instanceBlueOffset = -0.01;        // 颜色值递减。
    //添加子layer
    [_loveLayer addSublayer:pathView.layer];
    [self.view.layer addSublayer:_loveLayer];
}


/**
 *  创建爱心动画的路径
 *
 *  @return 路径
 */
- (UIBezierPath *)lovePath {
    //1.创建Love的路径
    UIBezierPath * lovePath = [UIBezierPath bezierPath];
    //1.1初始点
    [lovePath moveToPoint:CGPointMake(SCREENWIDTH/2.0, 300)];
    //1.2爱心的最底部 controlPoint是中间控制点
    [lovePath addQuadCurveToPoint:CGPointMake(SCREENWIDTH/2.0, 430) controlPoint:CGPointMake(SCREENWIDTH/2.0 + 240, 130)];
    //1.3回到初始点 且中间有一个控制点
    [lovePath addQuadCurveToPoint:CGPointMake(SCREENWIDTH/2.0, 300) controlPoint:CGPointMake(SCREENWIDTH/2.0 - 240, 130)];
    //1.4关闭路径
    [lovePath closePath];
    return lovePath;
}
@end
