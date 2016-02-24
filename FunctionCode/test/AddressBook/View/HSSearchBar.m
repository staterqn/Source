//
//  HSSearchBar.m
//  test
//
//  Created by chuanshuangzhang chuan shuang on 16/2/24.
//  Copyright © 2016年 chuanshuangzhang. All rights reserved.
//

#import "HSSearchBar.h"

@implementation HSSearchBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        for (UIView  *subView in view.subviews) {
            if([subView isKindOfClass:[UITextField class]])
            {
                subView.frame = CGRectMake(8, 0, self.bounds.size.width-16, self.bounds.size.height);
            }
        }
    }
}
@end
