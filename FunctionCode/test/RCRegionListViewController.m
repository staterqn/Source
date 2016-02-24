//
//  RCRegionListViewController.m
//  test
//
//  Created by chuanshuangzhang chuan shuang on 16/2/1.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

#import "RCRegionListViewController.h"
#import "RCViewController.h"
@interface RCRegionListViewController ()<RCRegionListViewControllerDelegate>

@end

@implementation RCRegionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    __block CGRect frame = self.containerView.frame ;
    frame.origin.y = self.view.frame.size.height;
    self.containerView.frame = frame;
    [self.view layoutIfNeeded];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)tests:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self.delegate test:btn.titleLabel.text];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"tt"])
    {
        RCViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}
- (void)show
{
   __block CGRect frame = self.containerView.frame ;
    [UIView animateWithDuration:5 animations:^{
//        frame.origin.y = self.view.frame.size.height - self.containerView.frame.size.height;
//        self.containerView.frame = frame;
//        [self.view layoutIfNeeded];
    }];
}
-(void)test:(NSString *)str
{
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
