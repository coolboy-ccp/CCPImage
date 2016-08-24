//
//  PartWithBeeline.m
//  CCPImage
//
//  Created by liqunfei on 16/8/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "PartWithBeeline.h"
#define mainScreenSize  [UIScreen mainScreen].bounds.size

@interface PartWithBeeline ()
{
    BOOL isOpen;
}
@property (nonatomic,strong) UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UIImageView *backImgView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic,strong) UIImageView *rightImgView;
@end


@implementation PartWithBeeline

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.leftImgView aboveSubview:self.backImgView];
    [self.view insertSubview:self.rightImgView aboveSubview:self.backImgView];
    isOpen = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (isOpen) {
        self.infoLabel.text = @"点击屏幕打开";
        [UIView animateWithDuration:0.5 animations:^{
            self.leftImgView.transform = CGAffineTransformIdentity;
            self.rightImgView.transform = CGAffineTransformIdentity;
        }];
    }
    else {
        self.infoLabel.text = @"点击屏幕关闭";
        [UIView animateWithDuration:0.5 animations:^{
            self.leftImgView.transform = CGAffineTransformMakeRotation(-M_PI_4);
            self.rightImgView.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
    }
    isOpen = !isOpen;
}

/**
 * @brief 根据方向切图
 * @pragma img 原图
 * @pragma direction 方向
 */
- (UIImage *)clipImageWithOrignImage:(UIImage *)img direction:(NSString *)direction {
    UIImage *clipImg;
    CGRect rect;
    if ([direction isEqualToString:@"left"]) {
        rect = CGRectMake(0, 0, img.size.width / 2, img.size.height);
    }
    else if ([direction isEqualToString:@"right"]) {
        rect = CGRectMake(img.size.width / 2, 0, img.size.width / 2, img.size.height);
    }
    CGImageRef imgRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    clipImg = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    return clipImg;
}

//getter
- (UIImageView *)leftImgView {
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mainScreenSize.width / 2,mainScreenSize.height)];
        _leftImgView.image = [self clipImageWithOrignImage:[UIImage imageNamed:@"1.jpg"] direction:@"left"];
    }
    return _leftImgView;
}

- (UIImageView *)rightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(mainScreenSize.width / 2, 0, mainScreenSize.width / 2, mainScreenSize.height)];
        _rightImgView.image = [self clipImageWithOrignImage:[UIImage imageNamed:@"1.jpg"] direction:@"right"];
    }
    return _rightImgView;
}


@end
