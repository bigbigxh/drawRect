//
//  UIImage+ClipImage.h
//  textImage
//
//  Created by ios on 16/7/12.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClipImage)

//将图片裁剪成圆形
+ (UIImage *)imageWithClipImage:(UIImage *)image;

/**
 *  将图片裁剪成圆形
 *
 *  @param image       将要裁剪的图片
 *  @param borderWith  圆环的宽度
 *  @param borderColor 圆环的颜色
 *
 *  @return 裁剪完毕且带有圆环的图片
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWith:(NSInteger)borderWith borderColor:(UIColor *)borderColor;

/**
 *  控件截图，可以截全屏或者某个控件
 *
 *  @param view 要截图的view，全屏则传入self.view即可
 *
 *  @return 图片
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view;

/**
 *  添加水印,默认添加到右下角(spaceToRight=10,spaceToBottom~=10)
 *
 *  @param image     要添加水印的照片
 *  @param text      要添加的文字
 *  @param font      字体，如果不想设置就传 0，默认是15号字体
 *  @param textColor 颜色，如果不想设置就传nil，默认是黑色
 *
 *  @return 返回一张带有水印的照片
 */
+ (UIImage *)imageWithImage:(UIImage *)image TextColor:(UIColor *)textColor Text:(NSString *)text withFont:(NSInteger)font;

@end
