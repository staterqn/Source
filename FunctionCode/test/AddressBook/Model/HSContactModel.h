//
//  HSContactModel.h
//  HappySchool
//
//  Created by chuanshuangzhang on 16/2/19.
//  Copyright © 2016年 com.flxcolor.cszhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSContactModel : NSObject

/*联系人ID*/
@property (nonatomic,readwrite) NSString *contactId;
/*联系人名字*/
@property (nonatomic,readwrite) NSString *contactName;
/*联系人头像链接*/
@property (nonatomic,readwrite) NSString *contactPicUrl;
/*拼音名字*/
@property (nonatomic,readwrite) NSString *pinYinName;

@end
