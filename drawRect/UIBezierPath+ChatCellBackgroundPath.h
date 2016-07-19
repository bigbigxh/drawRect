//
//  UIBezierPath+ChatCellBackgroundPath.h
//  drawRect
//
//  Created by ios on 16/7/19.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (ChatCellBackgroundPath)

//输入的长度大于180的bezierPath  personTypeOther
+ (UIBezierPath *)bezierPathWithWidth:(NSInteger)textWidth Height:(NSInteger)textHeight;

//输入长度小于180的bizierPath  personTyptOther
+ (UIBezierPath *)bezierPathWithWidth:(NSInteger)textWidth;


//输入长度大于180的bezierPath  personTypeMe
+ (UIBezierPath *)bezierPathForPersonTypeMeWithHeight:(NSInteger)textHeight andWindowWidth:(NSInteger)windowWidth;

//输入长度小于180的bezierPath  personTypeMe
+ (UIBezierPath *)bezierPathForPersonTypeMeWithWidth:(NSInteger)textWidth andWindowWidth:(NSInteger)windowWidth;


@end
