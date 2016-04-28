//
//  ZoeLayout.m
//  TestCyleImage
//
//  Created by zhangwei on 16/4/10.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import "ZoeLayout.h"

@implementation ZoeLayout
- (void)prepareLayout
{
    [super prepareLayout];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *temp = [[NSArray alloc]initWithArray:original copyItems:YES];
    
    
    
    for (int i = 0; i < temp.count; i ++) {
        UICollectionViewLayoutAttributes *att = temp[i];
        
        CGFloat distance = ABS(att.center.x - self.collectionView.frame.size.width * 0.5 - self.collectionView.contentOffset.x);
        
        CGFloat scale = 0.1;

        CGFloat w = (self.collectionView.frame.size.width + self.itemSize.width) * 0.5;
        if (distance >= w) {
            scale = 0.1;
        }else{
            scale = scale +  (1- distance / w ) * 1.3;
        }
        

        CGFloat angle = 1.0;
        
        CGFloat angleW = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
        if (distance >= angleW) {
            angle = 1.0;
        }else{
            angle = distance / angleW ;
        }
        
        CGFloat m34 = 800;
        CGFloat value = 360 * angle;
        CATransform3D transfrom =CATransform3DIdentity;
        transfrom.m34 = 1.0 /m34;
        CGFloat radiants= value / 360.0 * 2 * M_PI;
        transfrom = CATransform3DRotate(transfrom, radiants,0.0f, 3.0f, 0.0f);
        transfrom = CATransform3DScale(transfrom, scale, scale, 1);
        
        att.transform3D = transfrom;
        if (att.center.x == self.collectionView.center.x) {
            
        }
    }
    return  temp;
    
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGRect  rect;
    
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    NSArray *tempArray  = [super  layoutAttributesForElementsInRect:rect];
    
    CGFloat  gap = 1000;
    
    CGFloat  a = 0;
    
    for (int i = 0; i < tempArray.count; i++) {
        if (gap > ABS([(UIView *)tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5)) {
            
            gap =  ABS([(UIView *)tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5);
            a = [(UIView *)tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5;
        }
    }
    
    CGPoint  point  =CGPointMake(proposedContentOffset.x + a , proposedContentOffset.y);
    return point;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    return  YES;
}
@end
