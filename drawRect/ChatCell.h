//
//  ChatCell.h
//  drawRect
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import <UIKit/UIKit.h>

//发送消息的人
typedef NS_ENUM(NSUInteger, PersonType) {
    PersonTypeMe = 0,  //发送消息的是自己
    PersonTypeOther = 1, //发送消息的是别人
};

@interface ChatCell : UITableViewCell

@property(nonatomic,copy)UIImage *IconImage; //头像
@property(nonatomic,copy)NSString *contentStr;//要发送的消息
@property(nonatomic)PersonType personType;//发送人(自己、他人)

@end
