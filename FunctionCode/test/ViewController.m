//
//  ViewController.m
//  test
//
//  Created by chuanshuangzhang chuan shuang on 16/2/1.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

#import "ViewController.h"
#import "RCRegionListViewController.h"
#import "MusicDownloadListViewController.h"
#import "HSContactTableViewController.h"
#import "DITableViewController.h"

@interface ViewController ()<RCRegionListViewControllerDelegate>
@property (nonatomic,weak)  RCRegionListViewController *vc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)test:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MusicDownloadList" bundle:nil];
    MusicDownloadListViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MusicDownloadListViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)openAddress:(id)sender {
    HSContactTableViewController *vc = [[HSContactTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)openFile:(id)sender {
    DITableViewController *vc = [[DITableViewController alloc]init];
    vc.fileUrlString = @"HSCache/Movie";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
