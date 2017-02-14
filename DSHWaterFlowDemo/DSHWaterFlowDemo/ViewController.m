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

@property (strong,nonatomic)NSArray *itemsArray; //模型数组

@end

@implementation ViewController

- (NSArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [[NSArray alloc]init];
    }
    return _itemsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
    self.itemsArray = [NSArray arrayWithContentsOfFile:path];
    DSHCollectionViewLayout *layout = [[DSHCollectionViewLayout alloc]init] ;
    layout.delegate = self;
    self.collectionView.collectionViewLayout  = layout;
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DSHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.itemsArray[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
   /*
    cell.backgroundColor = [UIColor redColor];
    NSDictionary *dic = self.itemsArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
   */
    
    for (UIView *view in cell.contentView.subviews) {
     [view removeFromSuperview];
     }
    UIImageView *imageView =[[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
    [cell.contentView addSubview:imageView];
    //VFL
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableArray *layoutArr = [NSMutableArray array];
    NSString *VisualFormats[2];
    VisualFormats[0] = @"H:|[imageView]|";
    VisualFormats[1] = @"V:|[imageView]|";
    NSDictionary *imageViews = NSDictionaryOfVariableBindings(imageView);
    for (NSInteger i =0;i<2;i++) {
      [layoutArr addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:VisualFormats[i] options:kNilOptions metrics:nil views:imageViews]];
    }
    [NSLayoutConstraint activateConstraints:layoutArr];
     
    
    
    
    return cell;
}

- (CGFloat)DSHCollectionViewLayoutHeightForIndexPath:(NSIndexPath *)indexPath width:(CGFloat)width{
    
    NSDictionary *dic = self.itemsArray[indexPath.row];
    CGFloat w = [dic[@"w"] floatValue];
    CGFloat h = [dic[@"h"] floatValue];
    
    return width * h / w ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
