//
//  HSConatctTableViewCell.m
//  HappySchool
//
//  Created by chuanshuangzhang on 16/2/19.
//  Copyright © 2016年 com.flxcolor.cszhang. All rights reserved.
//

#import "HSConatctTableViewCell.h"

@implementation HSConatctTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.imageView.frame;
    frame.origin.y = 5;
    frame.size.width = 45;
    frame.size.height = 45;
    self.imageView.frame = frame;
    frame = self.textLabel.frame;
    frame.origin.x = self.imageView.frame.origin.x + self.imageView.frame.size.width + 10;
    self.textLabel.frame = frame;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
