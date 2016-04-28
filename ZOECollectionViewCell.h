//
//  ZOECollectionViewCell.h
//  TestCyleImage
//
//  Created by zhangwei on 16/4/11.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZOECollectionViewCell : UICollectionViewCell
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,assign)BOOL cellSelectViewHide;
-(void)run;
-(void)close;
@end
