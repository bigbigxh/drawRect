//
//  UIBezierPath+ChatCellBackgroundPath.m
//  drawRect
//
//  Created by ios on 16/7/19.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import "UIBezierPath+ChatCellBackgroundPath.h"

@implementation UIBezierPath (ChatCellBackgroundPath)

//输入的长度大于180的bezierPath  personTypeOther
+ (UIBezierPath *)bezierPathWithWidth:(NSInteger)textWidth Height:(NSInteger)textHeight{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //第一个圆角(左上角)(顺时针)
    [path addArcWithCenter:CGPointMake(55, 15) radius:5 startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(235, 10)];
    
    //第二个圆角(右上角)(顺时针)
    [path addArcWithCenter:CGPointMake(235, 15) radius:5 startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    NSInteger maxHeight = 10 + textHeight;
    
    [path addLineToPoint:CGPointMake(240, maxHeight - 5)];
    
    //第三个圆角(右下角)(顺时针)
    [path addArcWithCenter:CGPointMake(235, maxHeight - 5) radius:5 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(55, maxHeight)];
    
    //第四个圆角(左下角)(顺时针)
    [path addArcWithCenter:CGPointMake(55, maxHeight - 5) radius:5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    //尖角
    [path addLineToPoint:CGPointMake(50, 24)];
    [path addLineToPoint:CGPointMake(45, 22)];
    [path addLineToPoint:CGPointMake(50, 20)];
    [path addLineToPoint:CGPointMake(50, 10)];
    
    [[UIColor grayColor] set];

    return path;
}


//输入长度小于180的bizierPath  personTyptOther
+ (UIBezierPath *)bezierPathWithWidth:(NSInteger)textWidth{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //第一个圆角(左上角)(顺时针)
    [path addArcWithCenter:CGPointMake(55, 15) radius:5 startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
    
    NSInteger maxWidth = 50 + textWidth + 15;
    
    [path addLineToPoint:CGPointMake(maxWidth - 5, 10)];
    //第二个圆角(右上角)(顺时针)
    [path addArcWithCenter:CGPointMake(maxWidth - 5, 15) radius:5 startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(maxWidth, 35)];
    //第三个圆角(右下角)(顺时针)
    [path addArcWithCenter:CGPointMake(maxWidth - 5, 35) radius:5 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(55, 40)];
    //第四个圆角(左下角)(顺时针)
    [path addArcWithCenter:CGPointMake(55, 35) radius:5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //尖角
    [path addLineToPoint:CGPointMake(50, 24)];
    [path addLineToPoint:CGPointMake(45, 22)];
    [path addLineToPoint:CGPointMake(50, 20)];
    [path addLineToPoint:CGPointMake(50, 10)];
    
    return path;
}

//输入长度大于180的bezierPath  personTypeMe
+ (UIBezierPath *)bezierPathForPersonTypeMeWithHeight:(NSInteger)textHeight andWindowWidth:(NSInteger)windowWidth{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //第一个center:(右上角圆角的center)
    CGPoint firstCenter = CGPointMake(windowWidth - 55, 15);
    //逆时针
    [path addArcWithCenter:firstCenter radius:5 startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    [path addLineToPoint:CGPointMake(windowWidth - 235, 10)];
    //第二个center:(左上角圆角的center)
    CGPoint seconCenter = CGPointMake(windowWidth - 235, 15);
    //逆时针
    [path addArcWithCenter:seconCenter radius:5 startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
    
     NSInteger ReallyHeight = 10 + textHeight;
    
    [path addLineToPoint:CGPointMake(windowWidth - 240, ReallyHeight - 5)];
    
    //第三个center:(左下角圆角的center)
    CGPoint thirdCenter = CGPointMake(windowWidth - 235, ReallyHeight - 5);
    //逆时针
    [path addArcWithCenter:thirdCenter radius:5 startAngle:-M_PI endAngle:-(3*M_PI_2) clockwise:NO];
    
    [path addLineToPoint:CGPointMake(windowWidth - 55, ReallyHeight)];
    
    //第四个center:(右下角圆角的center)
    CGPoint forthCenter = CGPointMake(windowWidth - 55, ReallyHeight - 5);
    //逆时针
    [path addArcWithCenter:forthCenter radius:5 startAngle:-(3*M_PI_2) endAngle:-2*M_PI clockwise:NO];
    //尖角
    [path addLineToPoint:CGPointMake(windowWidth - 50, 24)];
    [path addLineToPoint:CGPointMake(windowWidth - 45, 22)];
    [path addLineToPoint:CGPointMake(windowWidth - 50, 20)];
    [path addLineToPoint:CGPointMake(windowWidth - 50, 10)];
    
    return path;
}


//输入长度小于180的bezierPath  personTypeMe
+ (UIBezierPath *)bezierPathForPersonTypeMeWithWidth:(NSInteger)textWidth andWindowWidth:(NSInteger)windowWidth{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //第一个center
    CGPoint firstCenter = CGPointMake(windowWidth - 55, 15);
    //逆时针
    [path addArcWithCenter:firstCenter radius:5 startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    
    NSInteger reallyWidht = windowWidth - 50 - textWidth;
    
    [path addLineToPoint:CGPointMake(reallyWidht - 5, 10)];
    //第二个center
    CGPoint secondCenter = CGPointMake(reallyWidht - 5, 15);
    //逆时针
    [path addArcWithCenter:secondCenter radius:5 startAngle:-M_PI_2 endAngle:-M_PI  clockwise:NO];
    [path addLineToPoint:CGPointMake(reallyWidht - 10, 35)];
    //第三个center
    CGPoint thirdCenter = CGPointMake(reallyWidht - 5, 35);
    //逆时针
    [path addArcWithCenter:thirdCenter radius:5 startAngle:-M_PI endAngle:-(3*M_PI_2) clockwise:NO];
    
    [path addLineToPoint:CGPointMake(windowWidth - 55, 40)];
    //第四个center
    CGPoint point = CGPointMake(windowWidth - 55, 35);
    //逆时针
    [path addArcWithCenter:point radius:5 startAngle:-(3*M_PI_2) endAngle:-2*M_PI clockwise:NO];
    
    //尖角
    [path addLineToPoint:CGPointMake(windowWidth - 50, 24)];
    [path addLineToPoint:CGPointMake(windowWidth - 45, 22)];
    [path addLineToPoint:CGPointMake(windowWidth - 50, 20)];
    [path addLineToPoint:CGPointMake(windowWidth - 50, 10)];
    
    return path;
}



@end
