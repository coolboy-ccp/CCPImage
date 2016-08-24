//
//  IrregularClipView.m
//  CCPImage
//
//  Created by liqunfei on 16/8/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "IrregularClipView.h"

@implementation IrregularClipView

- (void)drawRect:(CGRect)rect {
    //此处为椭圆形，若要别的图像用path自己画
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 100, 80));
    CGContextClip(ctx);
    UIImage *img = [UIImage imageNamed:@"2.jpg"];
    [img drawInRect:CGRectMake(100, 100, 100, 100)];
    // Drawing code
}

- (IBAction)back:(id)sender {
    UIViewController *vc = (UIViewController *)[self nextResponder];
    [vc.navigationController popViewControllerAnimated:YES];
}

@end
