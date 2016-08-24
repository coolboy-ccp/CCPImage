//
//  ClipImage.m
//  CCPImage
//
//  Created by liqunfei on 16/8/23.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "ClipImage.h"

@interface ClipImage ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (nonatomic,strong) UIImage *img;
@property (nonatomic,strong) UIImageView *cutImgView;

@end

@implementation ClipImage

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 210, 210)];
    aview.center = self.view.center;
    aview.backgroundColor = [UIColor grayColor];
    aview.alpha = 0.4;
    [self.view insertSubview:aview aboveSubview:self.myImageView];
    self.cutImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.cutImgView.center = self.view.center;
    [self.view insertSubview:self.cutImgView aboveSubview:aview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clip:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.img = [self clipImgWithRect:CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2 - 100, 200, 200) originImage:[UIImage imageNamed:@"1.jpg"]];
    }
    else {
        self.img = nil;
    }
}

- (void)setImg:(UIImage *)img {
    _img = img;
    self.cutImgView.image = self.img;
}

/**
 * @brief 切图
 * @pragma rect 切图rect
 * @pragma orImg 原图
 */

- (UIImage *)clipImgWithRect:(CGRect)rect originImage:(UIImage *)orImg {
    UIImage *clipImg;
    CGRect clipRect = [self clipRect:self.view.bounds destinationRect:rect orImgSize:orImg.size];
    UIGraphicsBeginImageContext(clipRect.size);
    CGImageRef imgRef = CGImageCreateWithImageInRect(orImg.CGImage, clipRect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, clipRect, imgRef);
    clipImg = [UIImage imageWithCGImage:imgRef];
    UIGraphicsEndImageContext();
    return clipImg;
}

/**
 * @brief 得到裁剪的rect
 * @pragma orRect 原来的imageview的尺寸
 * @pragma desRect 想裁剪的大小
 * @pragma size 原图片尺寸
 */
- (CGRect)clipRect:(CGRect)orRect destinationRect:(CGRect)desRect orImgSize:(CGSize)size {
    CGRect rect;
    CGFloat w = desRect.size.width / orRect.size.width * size.width;
    CGFloat h = desRect.size.height / orRect.size.height * size.height;
    CGFloat x = desRect.origin.x / orRect.size.width * size.width;
    CGFloat y = desRect.origin.y / orRect.size.height * size.height;
    rect = CGRectMake(x, y, w, h);
    return rect;
}
@end
