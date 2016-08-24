//
//  PinScale.m
//  CCPImage
//
//  Created by liqunfei on 16/8/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "PinScale.h"

@interface PinScale ()
{
    CGFloat lastScale;
    CGFloat totalScale;
}
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;

@end

@implementation PinScale

- (void)viewDidLoad {
    [super viewDidLoad];
    totalScale = 1.0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)pin:(UIPinchGestureRecognizer *)sender {
    if ([sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    CGFloat scale = 1.0 - (lastScale - sender.scale);
    if (scale > 1.0) {
        if (totalScale > 1.5) {
            return;
        }
    }
    else if (scale < 1.0) {
        if (totalScale < 0.5) {
            return;
        };
    }
    self.myImgView.transform = CGAffineTransformScale(self.myImgView.transform, scale, scale);
    lastScale = [sender scale];
    totalScale *= scale;
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:sender.view];
    sender.view.center = CGPointMake(sender.view.center.x + point.x, sender.view.center.y + point.y);
    [sender setTranslation:CGPointZero inView:sender.view];
}

@end
