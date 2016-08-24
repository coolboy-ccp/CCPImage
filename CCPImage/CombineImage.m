//
//  CombineImage.m
//  CCPImage
//
//  Created by liqunfei on 16/8/23.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "CombineImage.h"

@interface CombineImage ()
@property (weak, nonatomic) IBOutlet UIImageView *combineImgView;

@end

@implementation CombineImage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.combineImgView.image = [self combineImagesWithSize:[UIScreen mainScreen].bounds.size bigImage:[UIImage imageNamed:@"1.jpg"] smallImage:[UIImage imageNamed:@"2.jpg"]];
    
}

/**
 * @brief 将两张图片合成为一张图片
 * @pragma size 合成图片的大小
 * @pragma big 大图片
 * @pragma small 小图片
 */

- (UIImage *)combineImagesWithSize:(CGSize)size bigImage:(UIImage *)big smallImage:(UIImage *)small {
    UIImage *combineImg;
    UIGraphicsBeginImageContext(size);
    [big drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [small drawInRect:CGRectMake((size.width - 200) / 2, (size.height - 200) / 2, 200, 200)];
    combineImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return combineImg;
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
