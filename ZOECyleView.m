//
//  ZOECyleViwe.m
//  TestCyleImage
//
//  Created by zhangwei on 16/4/18.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import "ZOECyleView.h"
#import "ZoeLayout.h"
#import "ZOECollectionViewCell.h"

@interface ZOECyleView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, nonnull,strong)UICollectionView *mainView;
@property(nonatomic, nonnull,strong)ZoeLayout *layout;
@property (nonatomic,strong)ZOECollectionViewCell *cell;
@property(nonatomic,weak)ZOECollectionViewCell *currentCell;
@property(nonatomic,copy)selectItemNum block;

@property(nonatomic,assign)NSInteger stopCellIndex;

@property(nonatomic,assign)BOOL openView;

@property(nonatomic,assign)BOOL fistRun;


@property(nonatomic,strong)NSIndexPath *fistINdexPath;
@end

static NSString *const kCellId = @"CycleCell";

@implementation ZOECyleView
+(instancetype)ZOECyleViewinitWithFrame:(CGRect)frame andMonthsWithTitles:(NSArray *)titlesAry selectItem:(selectItemNum)callBack
{
    ZOECyleView *view = [[ZOECyleView alloc]initWithFrame:frame];
    view.titlesAry = titlesAry;
    view.block = callBack;
    return view;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview: self.mainView];
    self.fistINdexPath = [NSIndexPath indexPathForItem:300 / 2 inSection:0];
    [self.mainView scrollToItemAtIndexPath:self.fistINdexPath
                          atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

-(void)restarViewForMiddleView
{
    self.fistINdexPath = [NSIndexPath indexPathForItem:300 / 2 inSection:0];
    [self.mainView scrollToItemAtIndexPath:self.fistINdexPath
                          atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3 * 100;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    if (indexPath.row == self.fistINdexPath.row) {
        [self.cell setCellSelectViewHide: NO];
    }else{
        [self.cell setCellSelectViewHide: YES];
    }

    NSDictionary *dict = self.titlesAry[indexPath.row % 3];
    if (dict) {
        NSString *titleString = dict.allValues[0];
        NSString *monthString = dict.allKeys[0];
        [self.cell setTitle:titleString];
        [self.cell setMonth: monthString];
    }
    return self.cell;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView                                              // any offset changes
{
    if (self.mainView.visibleCells.count > 0) {
        for (ZOECollectionViewCell *view in self.mainView.visibleCells) {
        [view close];
        }
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeCell];

}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self changeCell];

}
-(void)changeCell
{
    for (ZOECollectionViewCell *view in self.mainView.visibleCells) {
        CGFloat distance = ABS(view.center.x - self.mainView.frame.size.width * 0.5 - self.mainView.contentOffset.x);
        if (distance <= 1) {
            self.currentCell = view;
            [self.currentCell run];
            NSIndexPath *index = [self.mainView indexPathForCell:self.currentCell];
            self.stopCellIndex = index.row % 3;
            [self doBlock];
        }else{
            [view close];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView setUserInteractionEnabled:NO];
    [self performSelector:@selector(setCollectionViewUseFace:) withObject:@(1) afterDelay:0.5];
    [self.mainView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (self.stopCellIndex == indexPath.row % 3) {
        self.openView = YES;
        [self doBlock];
    }
}

-(void)doBlock
{
    self.block(self.stopCellIndex, self.openView);
    self.openView = NO;
}
-(void)setCollectionViewUseFace:(BOOL)object
{
    [self.mainView setUserInteractionEnabled:!self.mainView.isUserInteractionEnabled];
}
-(UICollectionView *)mainView
{
    if (_mainView == nil) {
        _mainView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.layout];
        [_mainView registerClass:[ZOECollectionViewCell class] forCellWithReuseIdentifier:kCellId];
        [_mainView setDataSource: self];
        [_mainView setDelegate: self];
        [_mainView setShowsHorizontalScrollIndicator:NO];
        [_mainView setShowsVerticalScrollIndicator:NO];
        [_mainView setUserInteractionEnabled:YES];
        [_mainView setBackgroundColor:[UIColor clearColor]];
        [_mainView setUserInteractionEnabled: NO];

        [self.layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.layout.minimumInteritemSpacing = 0;
        [self.layout setItemSize:CGSizeMake(_mainView.bounds.size.width / 3, _mainView.bounds.size.width / 3)];
        
    }
    return _mainView;
}
-(void)setTitlesAry:(NSArray *)titlesAry
{
    _titlesAry = titlesAry;
    [_mainView setUserInteractionEnabled: YES];
    [_mainView reloadData];
}

-(ZoeLayout *)layout
{
    if (_layout == nil) {
        _layout = [[ZoeLayout alloc]init];
    }
    return _layout;
}

@end
