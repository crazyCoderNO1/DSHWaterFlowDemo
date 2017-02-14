//
//  DSHCollectionViewLayout.h
//  DSHWaterFlowDemo
//
//  Created by 杜世豪 on 17/2/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  DSHCollectionViewLayoutDelegate <NSObject>

@required
- (CGFloat)DSHCollectionViewLayoutHeightForIndexPath:(NSIndexPath *)indexPath
                                               width:(CGFloat)width;

@end

@interface DSHCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,weak) id<DSHCollectionViewLayoutDelegate> delegate;

@end
