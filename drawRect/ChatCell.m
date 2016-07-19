//
//  ChatCell.m
//  drawRect
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import "ChatCell.h"
#import "UIImage+ClipImage.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect{
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIImage *img = [UIImage imageWithClipImage:self.IconImage];
    [img drawInRect:CGRectMake(10, 10, 30, 30)];
    
    CGSize forHeight = CGSizeMake(180, MAXFLOAT);
    NSInteger textHeight = [self MaxheightForRowWithText:self.contentStr AndFont:13 maskSize:forHeight];
    
    CGSize forWidth = CGSizeMake(MAXFLOAT, 20);
    NSInteger textMaxWidth = [self MaxWidthWithText:self.contentStr AndFont:13 maskSize:forWidth];
    
    if (textMaxWidth > 180) {
        UIBezierPath *path = [self MaxWidthbezierPathWithWidth:180 Height:textHeight];
        [[UIColor grayColor]set];
        [path fill];
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
        [self.contentStr drawInRect:CGRectMake(60, 15, 180, textHeight) withAttributes:dic];
    }else{
        UIBezierPath *path = [self MaxHeightbezierPathWithWidth:textMaxWidth];
        
        [[UIColor grayColor]set];
        [path fill];
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
        [self.contentStr drawInRect:CGRectMake(60, 18, textMaxWidth, 20) withAttributes:dic];
    }
    
}

//如果输入的长度大于180的
- (UIBezierPath *)MaxWidthbezierPathWithWidth:(NSInteger)textWidth Height:(NSInteger)textHeight{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(55, 15)];
    
    [path addArcWithCenter:CGPointMake(55, 15) radius:5 startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(235, 10)];
    
    [path addArcWithCenter:CGPointMake(235, 15) radius:5 startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    NSInteger maxHeight = 10 + textHeight;
    
    
    [path addLineToPoint:CGPointMake(240, maxHeight - 5)];
    
    [path addArcWithCenter:CGPointMake(235, maxHeight - 5) radius:5 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(55, maxHeight)];
    
    [path addArcWithCenter:CGPointMake(55, maxHeight - 5) radius:5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [path addLineToPoint:CGPointMake(50, 24)];
    [path addLineToPoint:CGPointMake(45, 22)];
    [path addLineToPoint:CGPointMake(50, 20)];
    [path addLineToPoint:CGPointMake(50, 10)];
    
    [[UIColor grayColor] set];
//    [path fill];
    
    return path;
}

- (UIBezierPath *)MaxHeightbezierPathWithWidth:(NSInteger)textWidth{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSLog(@"%ld",textWidth);
    
    [path moveToPoint:CGPointMake(50, 10)];
    
    [path addArcWithCenter:CGPointMake(55, 15) radius:5 startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
    
     NSInteger maxWidth = 50 + textWidth + 15;
    
    [path addLineToPoint:CGPointMake(maxWidth - 5, 10)];
    
    [path addArcWithCenter:CGPointMake(maxWidth - 5, 15) radius:5 startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(maxWidth, 35)];
    
    [path addArcWithCenter:CGPointMake(maxWidth - 5, 35) radius:5 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(55, 40)];
    
    [path addArcWithCenter:CGPointMake(55, 35) radius:5 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    
    [path addLineToPoint:CGPointMake(50, 24)];
    [path addLineToPoint:CGPointMake(45, 22)];
    [path addLineToPoint:CGPointMake(50, 20)];
    [path addLineToPoint:CGPointMake(50, 10)];

    return path;
}

- (NSInteger)MaxheightForRowWithText:(NSString *)rowText AndFont:(NSInteger)font maskSize:(CGSize)size{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    
    //计算出label刚刚好自适应rowText的frame
    //size:宽高限制，在一定的区域内文本的高度。这里给出宽度就可以了，而高度是自适应的，所以高度要给出一个永远到不了的高度
    CGRect frame = [rowText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = frame.size.height;//文本的高度
    
    return height;
}

- (NSInteger)MaxWidthWithText:(NSString *)rowText AndFont:(NSInteger)font maskSize:(CGSize)size{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
    
    //计算出label刚刚好自适应rowText的frame
    //size:宽高限制，在一定的区域内文本的宽度。这里给出高度就可以了
    CGRect frame = [rowText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat width = frame.size.width;//文本的高度
   
    return width;
}


@end
