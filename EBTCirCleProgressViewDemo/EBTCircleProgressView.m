//
//  EBTCircleProgressView.m
//  EBaoTongDai
//
//  Created by ebaotong on 15/7/2.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//
#define kGrayFontColor  [UIColor colorWithRed:0.096 green:0.034 blue:0.100 alpha:0.100]
#define kRedLightFontColor  [UIColor colorWithRed:0.725 green:0.000 blue:0.000 alpha:1.000]
#import "EBTCircleProgressView.h"

@interface EBTCircleProgressView ()
{
    CAShapeLayer *layerBottom;//底部形状的图层
    CAShapeLayer *layerTop;//顶部形状的图层
    UIBezierPath *pathBottom;//底部布赛尔曲线
    UIBezierPath *pathTop;//顶部布赛尔曲线
    CATextLayer *layerText; //显示进度值

}
@end
@implementation EBTCircleProgressView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
          [self setUp];
        
    }
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    
    layerBottom = [CAShapeLayer layer];
    layerBottom.fillColor = nil;
    layerBottom.frame = self.bounds;
    
    layerTop = [CAShapeLayer layer];
    layerTop.fillColor = nil;
    layerTop.frame = self.bounds;
    
    layerText = [CATextLayer layer];
    layerText.fontSize = 10.f;
    layerText.contentsScale = [UIScreen mainScreen].scale;
    layerText.foregroundColor = kGrayFontColor.CGColor;
    layerText.alignmentMode = kCAAlignmentCenter;
    layerText.frame = CGRectMake((self.bounds.size.width -CGRectGetWidth(self.bounds)/4.f)/2.f,(self.bounds.size.height -CGRectGetHeight(self.bounds)/6.f)/2.f, CGRectGetWidth(self.bounds)/4.f+10.f, CGRectGetHeight(self.bounds)/6.f);

    [self.layer addSublayer:layerBottom];
    [self.layer addSublayer:layerTop];
    [self.layer addSublayer:layerText];

}

 - (void)setProgressTrackStokeColor:(UIColor *)progressTrackStokeColor
{
    _progressTrackStokeColor = progressTrackStokeColor;
    layerBottom.strokeColor = progressTrackStokeColor.CGColor;
    pathBottom = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.f, CGRectGetHeight(self.bounds)/2.f) radius:(CGRectGetWidth(self.bounds)-self.progressStorkeWidth)/4.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    layerBottom.path = pathBottom.CGPath;
}

- (void)setProgressStorkeWidth:(CGFloat)progressStorkeWidth
{
    _progressStorkeWidth = progressStorkeWidth;
    layerBottom.lineWidth = 1.f;
    layerTop.lineWidth = progressStorkeWidth;
}
- (void)setProgressStokeColor:(UIColor *)progressStokeColor
{
    _progressStokeColor = progressStokeColor;
    layerTop.strokeColor = progressStokeColor.CGColor;
}

- (void)setProgress:(CGFloat)progress
{
   
    if (progress<0.f) {
        _progress = 0.f;
    }
    else if (progress<=1.f)
    {
     _progress = progress;
    }
    else
    {
        _progress = 1.f;
    }
    pathTop = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.f, CGRectGetHeight(self.bounds)/2.f) radius:(CGRectGetWidth(self.bounds)-self.progressStorkeWidth)/4.f startAngle:-M_PI_2 endAngle:(2*M_PI)*_progress-M_PI_2 clockwise:YES];
    layerTop.path = pathTop.CGPath;
    /**富文本*/
    NSString *result = [NSString stringWithFormat:@"%ld%%",(long)(_progress*100)];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:result];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:kRedLightFontColor,NSFontAttributeName:[UIFont systemFontOfSize:20.f]} range:NSMakeRange(0, result.length-1)];
    layerText.string = attributeStr;
    /**加旋转动画*/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(-M_PI_2);
    animation.toValue = @((2*M_PI)*_progress-M_PI_2);
    animation.repeatCount = 1;
    animation.duration = 0.5f;
    [layerTop addAnimation:animation forKey:@"RotationAnimation"];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_progress<0.f)
    {
        _progress = 0.f;
    }
    else if (_progress>1.0f)
    {
        _progress = 1.f;
    }
    [layerTop removeAnimationForKey:@"RotationAnimation"];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(-M_PI_2);
    animation.toValue = @((2*M_PI)*_progress-M_PI_2);
    animation.repeatCount = 1;
    animation.duration = 0.5f;
     [layerTop addAnimation:animation forKey:@"RotationAnimation"];
}
@end
