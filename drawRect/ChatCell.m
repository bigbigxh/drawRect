//
//  ChatCell.m
//  drawRect
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import "ChatCell.h"
#import "UIImage+ClipImage.h"
#import "UIBezierPath+ChatCellBackgroundPath.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重写drawRect方法，将头像、文字、以及文字后的背景画到cell上
- (void)drawRect:(CGRect)rect{
//    由于此处用的是bezierPath，所以不需要获取layer上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //计算当文本(x=180,即文本的宽度超过180，默认换行。)的高度
    CGSize forHeight = CGSizeMake(180, MAXFLOAT);
    NSInteger textHeight = [self MaxheightForRowWithText:self.contentStr AndFont:14 maskSize:forHeight];
    //计算文本不超过180时(一行)的宽度
    CGSize forWidth = CGSizeMake(MAXFLOAT, 20);
    NSInteger textMaxWidth = [self MaxWidthWithText:self.contentStr AndFont:14 maskSize:forWidth];
    //调用UIImage的分类，将图片切成圆形。
    UIImage *img = [UIImage imageWithClipImage:self.IconImage];
    
    if (self.personType == PersonTypeOther) {
#pragma mark - 根据发送人 确定 头像、消息、消息背景 画在左边
        
        [img drawInRect:CGRectMake(10, 10, 30, 30)];
        //根据width是否大于180而选择画一行还是多行
        if (textMaxWidth > 180) {//画多行
            UIBezierPath *path = [UIBezierPath bezierPathWithWidth:180 Height:textHeight];
            [[UIColor grayColor]set];
            [path fill];
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
            //string中还有个drawInPoint，只需设置起点。但无法换行
            [self.contentStr drawInRect:CGRectMake(60, 15, 180, textHeight) withAttributes:dic];
            
        }else{//画一行
            UIBezierPath *path = [UIBezierPath bezierPathWithWidth:textMaxWidth];
            [[UIColor grayColor]set];
            [path fill];
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
            //string中还有个drawInPoint，只需设置起点。但无法换行
            [self.contentStr drawInRect:CGRectMake(60, 18, textMaxWidth, 20) withAttributes:dic];
        }
    }else{
#pragma mark - 根据发送人 确定 头像、消息、消息背景 画在右边
        //计算屏幕的宽度
        NSInteger hhhWidht = self.bounds.size.width;
        [img drawInRect:CGRectMake(hhhWidht - 40, 10, 30, 30)];
        
        if (textMaxWidth > 180) {//画多行
            UIBezierPath *path = [UIBezierPath bezierPathForPersonTypeMeWithHeight:textHeight andWindowWidth:hhhWidht];
            [[UIColor cyanColor]set];
            [path fill];
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]};
            [self.contentStr drawInRect:CGRectMake(hhhWidht - 230, 15, 180, textHeight) withAttributes:dic];
        }else{//画一行
            UIBezierPath *path = [UIBezierPath bezierPathForPersonTypeMeWithWidth:textMaxWidth andWindowWidth:hhhWidht];
            [[UIColor cyanColor]set];
            [path fill];
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]};
            [self.contentStr drawInRect:CGRectMake(hhhWidht - textMaxWidth - 55 , 17, textMaxWidth, 20) withAttributes:dic];
        }
    }
}

//计算高度
- (NSInteger)MaxheightForRowWithText:(NSString *)rowText AndFont:(NSInteger)font maskSize:(CGSize)size{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    
    //计算出label刚刚好自适应rowText的frame
    //size:宽高限制，在一定的区域内文本的高度。这里给出宽度就可以了，而高度是自适应的，所以高度要给出一个永远到不了的高度
    CGRect frame = [rowText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = frame.size.height;//文本的高度
    
    return height;
}

//计算宽度
- (NSInteger)MaxWidthWithText:(NSString *)rowText AndFont:(NSInteger)font maskSize:(CGSize)size{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];
    
    //计算出label刚刚好自适应rowText的frame
    //size:宽高限制，在一定的区域内文本的宽度。这里给出高度就可以了
    CGRect frame = [rowText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat width = frame.size.width;//文本的高度
   
    return width;
}


@end
