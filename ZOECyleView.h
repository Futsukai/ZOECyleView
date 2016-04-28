//
//  ZOECyleViwe.h
//  TestCyleImage
//
//  Created by zhangwei on 16/4/18.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectItemNum)(NSInteger selectItemNum,BOOL isCikUp);
@interface ZOECyleView : UIView
@property(nonatomic,strong)NSArray *titlesAry;

+(instancetype)ZOECyleViewinitWithFrame:(CGRect)frame andMonthsWithTitles:(NSArray *)titlesAry selectItem:(selectItemNum)callBack;
-(void)restarViewForMiddleView;
@end
