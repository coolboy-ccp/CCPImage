//
//  ScrollScale.m
//  CCPImage
//
//  Created by liqunfei on 16/8/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "ScrollScale.h"

@interface ScrollScale ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation ScrollScale

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.myImgView;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    self.myScrollView.zoomScale = 1.0;
}
@end
