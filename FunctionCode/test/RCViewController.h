//
//  RCViewController.h
//  test
//
//  Created by chuanshuangzhang chuan shuang on 16/2/1.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCRegionListViewControllerDelegate <NSObject>

- (void)test:(NSString *)str;

@end

@interface RCViewController : UIViewController
@property (nonatomic,weak) id<RCRegionListViewControllerDelegate> delegate;
@end
