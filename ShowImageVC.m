//
//  ShowImageVC.m
//  PhotoWallDemo
//
//  Created by admin on 17/3/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShowImageVC.h"

@interface ShowImageVC ()

@end

@implementation ShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片展示";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 300)];
    self.iv.image = self.imge;
    [self.view addSubview:self.iv];
    
    //打开交互
    self.iv.userInteractionEnabled = YES;
    
    //添加单击放大手势
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSingle:)];
    tapSingle.numberOfTapsRequired = 1;
    tapSingle.numberOfTouchesRequired = 1;
    [self.iv addGestureRecognizer:tapSingle];
    
    //添加单击放大手势
    UITapGestureRecognizer *tapDouble = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDouble:)];
    //两次点击
    tapDouble.numberOfTapsRequired = 2;
    //一个手指
    tapDouble.numberOfTouchesRequired = 1;
    [self.iv addGestureRecognizer:tapDouble];
    
    [tapSingle requireGestureRecognizerToFail:tapDouble];
}

- (void)tapSingle:(UITapGestureRecognizer *)tap{
//    [UIView animateWithDuration:1 animations:^{
//        self.iv.frame = self.view.bounds;
//    }];
    [self doMove];
}

//翻页动画
- (void)docurlUp {
    [UIView beginAnimations:@"curlUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//指定动画曲线类型，该枚举是默认的，线性的是匀速的
    //设置动画时常
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    //设置翻页的方向
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.iv cache:YES];
    //关闭动画
    [UIView commitAnimations];
}

//偏移动画
- (void)doMove {
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    //改变它的frame的x,y的值
    self.iv.frame=CGRectMake(100,100, 120,100);
    [UIView commitAnimations];
}


//缩放动画
- (void)doScale {
    CGAffineTransform  transform;
    transform = CGAffineTransformScale(self.iv.transform,1.2,1.2);
    [UIView beginAnimations:@"scale" context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [self.iv setTransform:transform];
    [UIView commitAnimations];
}

//翻转动画
- (void)doFlip{
    //开始动画
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:1];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:self.iv cache:YES];
    //动画结束
    [UIView commitAnimations];
}

//旋转动画
- (void)doRotate {
    //创建一个CGAffineTransform  transform对象
    CGAffineTransform  transform;
    //设置旋转度数
    transform = CGAffineTransformRotate(self.iv.transform,M_PI/1.0);
    //动画开始
    [UIView beginAnimations:@"rotate" context:nil ];
    //动画时常
    [UIView setAnimationDuration:1];
    //添加代理
    [UIView setAnimationDelegate:self];
    //获取transform的值
    [self.iv setTransform:transform];
    //关闭动画
    [UIView commitAnimations];
}

- (void)position {
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"rotation.x"];
    ani.toValue = [NSValue valueWithCGPoint:self.view.center];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.iv.layer addAnimation:ani forKey:@"PostionAni"];
}

//设置values使其沿正方形运动
- (void)valueKeyframeAni {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(150, 200)];
    ani.values = @[value1, value2, value3, value4, value5];
    [self.iv.layer addAnimation:ani forKey:@"PostionKeyframeValueAni"];
}

//设置path使其绕圆圈运动
- (void)pathKeyframeAni {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(130, 200, 100, 100));
    ani.path = path;
    CGPathRelease(path);
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeBackwards;
    [self.iv.layer addAnimation:ani forKey:@"PostionKeyframePathAni"];
}

- (void)transitionAni {
    CATransition * ani = [CATransition animation];
    ani.type = kCATransitionFade;
    ani.subtype = kCATransitionFromLeft;
    ani.duration = 1.5;
//    self.centerShow.image = [UIImage imageNamed:@"Raffle"];
    [self.iv.layer addAnimation:ani forKey:@"transitionAni"];
}

- (void)tapDouble:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:1 animations:^{
        self.iv.frame = CGRectMake(100, 100, 200, 300);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
