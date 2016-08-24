//
//  CurvePart.m
//  CCPImage
//
//  Created by liqunfei on 16/8/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "CurvePart.h"

#define mainScreenSize  [UIScreen mainScreen].bounds.size

@interface CurvePart ()

@property (nonatomic,strong) CALayer *topLayer;
@property (nonatomic,strong) CALayer *bottomLayer;

@end

@implementation CurvePart

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer insertSublayer:self.topLayer atIndex:0];
    [self.view.layer insertSublayer:self.bottomLayer atIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)animationWithLayer:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    animation.duration = 2.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    if (layer == self.topLayer) {
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        [self.topLayer addAnimation:animation forKey:@"an"];
    }
    else {
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        [self.bottomLayer addAnimation:animation forKey:@"an"];
    }
}

- (CALayer *)topLayer {
    if (!_topLayer) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(-1, -1)];
        [path addLineToPoint:CGPointMake(mainScreenSize.width + 1, -1)];
        [path addCurveToPoint:CGPointMake(mainScreenSize.width / 2 + 1, mainScreenSize.height / 2 +1) controlPoint1:CGPointMake(mainScreenSize.width + 1, 1) controlPoint2:CGPointMake(343.5 +1, 242.5 + 1)];
        [path addCurveToPoint:CGPointMake(-1, mainScreenSize.height + 2) controlPoint1:CGPointMake(31.5 + 2, 424.5 + 2) controlPoint2:CGPointMake(2, mainScreenSize.height + 2)];
        [path addLineToPoint:CGPointMake(-1, -1)];
        [path closePath];
        CAShapeLayer *shapeLyer = [CAShapeLayer layer];
        shapeLyer.path = path.CGPath;
        _topLayer = [CALayer layer];
        _topLayer.frame = [UIScreen mainScreen].bounds;
        _topLayer.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage;
        _topLayer.mask = shapeLyer;
    }
    return _topLayer;
}

- (IBAction)part:(UIButton *)sender {
    [self animationWithLayer:self.bottomLayer];
    [self animationWithLayer:self.topLayer];
}

- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(mainScreenSize.width, 0)];
        [path addCurveToPoint:CGPointMake(mainScreenSize.width / 2, mainScreenSize.height / 2) controlPoint1:CGPointMake(mainScreenSize.width, 0) controlPoint2:CGPointMake(343.5, 242.5)];
        [path addCurveToPoint:CGPointMake(0, mainScreenSize.height) controlPoint1:CGPointMake(34.5, 424.5) controlPoint2:CGPointMake(0, mainScreenSize.height)];
        [path addLineToPoint:CGPointMake(mainScreenSize.width, mainScreenSize.height)];
        [path addLineToPoint:CGPointMake(mainScreenSize.width, 0)];
        [path closePath];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        _bottomLayer = [CALayer layer];
        _bottomLayer.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage;
        _bottomLayer.frame = [UIScreen mainScreen].bounds;
        _bottomLayer.mask = shapeLayer;
    }
    return _bottomLayer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self.topLayer removeFromSuperlayer];
        [self.bottomLayer removeFromSuperlayer];
        self.topLayer = nil;
        self.bottomLayer = nil;
    }
}
@end
