//
//  DSHCollectionViewLayout.m
//  DSHWaterFlowDemo
//
//  Created by 杜世豪 on 17/2/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import "DSHCollectionViewLayout.h"

//行间距
static const CGFloat rowMargin = 10.0;
//列间距
static const CGFloat columnMargin = 10.0;

/** 每一列之间的间距 top, left, bottom, right */
static const UIEdgeInsets DSHDefaultInsets = {10, 10, 10, 10};
//列数
static const NSUInteger defaultColumn = 2 ;

@interface DSHCollectionViewLayout()

//每一列高度数组
@property (strong,nonatomic)NSMutableArray *columnHeightsArrays;
//存放attributes 数组
@property (strong,nonatomic)NSMutableArray *attributesArrs;

@end

@implementation DSHCollectionViewLayout


#pragma mark = get method

- (NSMutableArray *)attributesArrs{
    if (!_attributesArrs) {
        _attributesArrs = [NSMutableArray array];
    }
    return _attributesArrs;
}

- (NSMutableArray *)columnHeightsArrays{
    if (!_columnHeightsArrays) {
        _columnHeightsArrays = [NSMutableArray array];
    }
    return _columnHeightsArrays;
}


#pragma mark = 重写4个方法实现
- (void)prepareLayout{
    //layout 准备工作
    [super prepareLayout];
    //清空数组
    //初始化数组
    [self.columnHeightsArrays removeAllObjects];
    [self.attributesArrs removeAllObjects];
    
    for (int i = 0; i<defaultColumn; i++) {
        [self.columnHeightsArrays addObject:@(DSHDefaultInsets.top)];
    }
    
    NSInteger row = [self.collectionView numberOfItemsInSection:0];
    
    for (int i= 0; i<row; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArrs addObject:attributes];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat xMargin = DSHDefaultInsets.left + DSHDefaultInsets.right + (defaultColumn - 1)*columnMargin;
    
    CGFloat w = (self.collectionView.frame.size.width - xMargin)/defaultColumn;
    CGFloat h = [self.delegate DSHCollectionViewLayoutHeightForIndexPath:indexPath width:w];
    
    CGFloat minHeight = [self.columnHeightsArrays[0] floatValue];
    NSInteger minColumn = 0;//最低列数
    for (NSInteger i = 0; i<self.columnHeightsArrays.count; i++) {
        if (minHeight > [self.columnHeightsArrays[i] floatValue]) {
            minHeight = [self.columnHeightsArrays[i] floatValue];
            minColumn = i;
        }
    }

    CGFloat x = DSHDefaultInsets.left + minColumn*(rowMargin+w);
    CGFloat y = minHeight ;
    if (y!=DSHDefaultInsets.top) {
        y += rowMargin ;
    }
    attributes.frame = CGRectMake(x, y, w, h);
    
    self.columnHeightsArrays[minColumn] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}

- (CGSize)collectionViewContentSize{
    
    //先找到最长的那一列
    CGFloat maxHeight = [self.columnHeightsArrays[0] floatValue];
    for (NSInteger i = 0;i < self.columnHeightsArrays.count; ++i) {
        if (maxHeight < [self.columnHeightsArrays[i] floatValue]) {
            maxHeight = [self.columnHeightsArrays[i] floatValue];
        }
    }
    
    return CGSizeMake(0, DSHDefaultInsets.bottom +  maxHeight);
}

@end
