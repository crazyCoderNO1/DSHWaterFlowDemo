//
//  DSHCollectionViewCell.m
//  DSHWaterFlowDemo
//
//  Created by 杜世豪 on 17/2/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import "DSHCollectionViewCell.h"

@implementation DSHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)dianzanButtonClick:(id)sender {
    UIButton *thumbUpBtn = (UIButton *)sender;
    thumbUpBtn.selected = !thumbUpBtn.selected;
}

@end
