//
//  InputView.m
//  drawRect
//
//  Created by ios on 16/7/19.
//  Copyright © 2016年 dozer. All rights reserved.
//

#import "InputView.h"

@implementation InputView

- (void)awakeFromNib{
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.sendBtn.layer.cornerRadius = 5;
    self.sendBtn.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
