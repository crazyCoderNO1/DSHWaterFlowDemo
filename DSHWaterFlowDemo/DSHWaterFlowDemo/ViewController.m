//
//  ViewController.m
//  DSHWaterFlowDemo
//
//  Created by 杜世豪 on 17/2/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "DSHCollectionViewLayout.h"
#import "UIImageView+WebCache.h"
#import "DSHCollectionViewCell.h"

static NSString *const cellID = @"cellID";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DSHCollectionViewLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *itemsArray; //模型数组
@property (strong, nonatomic) NSMutableArray *imageViewsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.itemsArray = [NSMutableArray arrayWithCapacity:10];
    self.imageViewsArray = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 3951; i < 3990; ++i) {
        NSString *imageStr = [NSString stringWithFormat:@"IMG_%@.PNG",@(i)];
        UIImage *image = [UIImage imageNamed:imageStr];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.itemsArray addObject:image];
        [self.imageViewsArray addObject:imageView];
    }
    DSHCollectionViewLayout *layout = [[DSHCollectionViewLayout alloc]init] ;
    layout.delegate = self;
    self.collectionView.collectionViewLayout  = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DSHCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DSHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIImageView *imageView = self.imageViewsArray[indexPath.row];
    cell.imageView.image = imageView.image;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)DSHCollectionViewLayoutHeightForIndexPath:(NSIndexPath *)indexPath width:(CGFloat)width {
    
    UIImageView *imageView = self.imageViewsArray[indexPath.row];
    CGFloat w = imageView.frame.size.width;
    CGFloat h = imageView.frame.size.height;
    
    return width * h / w + 40;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
