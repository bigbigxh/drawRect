//
//  UIImage+ClipImage.m
//  textImage
//
//  Created by ios on 16/7/12.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import "UIImage+ClipImage.h"

@implementation UIImage (ClipImage)

+ (UIImage *)imageWithClipImage:(UIImage *)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [path addClip];
    
    [image drawAtPoint:CGPointZero];
    
    //获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return clipImage;
}

+ (UIImage *)imageWithClipImage:(UIImage *)image borderWith:(NSInteger)borderWith borderColor:(UIColor *)borderColor{
    //图片的宽度和高度
    CGFloat imageWH = image.size.width;//宽高一致
    //圆形的宽度和高度
    CGFloat ovalWH = imageWH + 2*borderWith;//borderWith:圆环的宽度
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    //画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    [path fill];
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWith, borderWith, imageWH, imageWH)];
    
    [clipPath addClip];
    //绘制图片
    [image drawAtPoint:CGPointMake(borderWith, borderWith)];
    //获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}

+ (UIImage *)imageWithCaputureView:(UIView *)view{
    CGSize size = view.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithImage:(UIImage *)image TextColor:(UIColor *)textColor Text:(NSString *)text withFont:(NSInteger)font{
    
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //绘制原生的图片
    [image drawAtPoint:CGPointZero];
    
    //设置文本默认的颜色和字体大小
    textColor?textColor:[UIColor blackColor];
    (font == 0)?(font = 15):font;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //为文本设置属性
    dic[NSForegroundColorAttributeName] = textColor;
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    
    //计算文本的长度
    NSInteger width = [self widthForRowWithText:text AndFont:font];
    
    //计算文本应该开始渲染的点,默认右下角(spaceToRight=10,spaceToBottom~=10)
    CGFloat x = image.size.width - width - 10;
    CGFloat y = image.size.height - 25;
    
    //渲染文字
    [text drawAtPoint:CGPointMake(x, y) withAttributes:dic];
    
    //获取图片
    UIImage *watterImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭位图上下文
    UIGraphicsEndImageContext();
    
    return watterImage;
}

//根据文本自动计算出文本的长度
+ (NSInteger)widthForRowWithText:(NSString *)rowText AndFont:(NSInteger)font{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    
    CGSize textSize = CGSizeMake(MAXFLOAT, 20);
    
    //计算出label刚刚好自适应rowText的frame
    //size:宽高限制，计算出在一定高度内的str的宽度，宽度MAXFLOAT无限制，即默认无限延长
    CGRect frame = [rowText boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat width = frame.size.width;//文本的宽度
    
    return width;
}

@end
