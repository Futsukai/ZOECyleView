//
//  ZOECollectionViewCell.m
//  TestCyleImage
//
//  Created by zhangwei on 16/4/11.
//  Copyright © 2016年 zhangwei. All rights reserved.
//

#import "ZOECollectionViewCell.h"
@interface ZOECollectionViewCell()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UILabel *monthLabel;
@property(nonatomic,strong)UILabel *middleMonthLabel;

@property(nonatomic,strong)UIView *cellBackgroundView;
@property(nonatomic,strong)UIView *cellSelectView;

@property(nonatomic,weak)UIView *lineView;


@end
static NSString *const kTitleString = @"预计年化收益";
static inline CGFloat FONTSCALS(CGFloat fontSize){
    return [UIScreen mainScreen].bounds.size.width / 375 * fontSize;//5s
}

@implementation ZOECollectionViewCell
-(void)setMonth:(NSString *)month
{
    _month = month;
    [self.monthLabel setText:_month];
    [self.middleMonthLabel setText:self.month];
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    [self.textLabel setText:_title];
    NSString *titleString = @"预计年化收益";
    [self.titleLabel setText:titleString];
    [self.lineView setHidden: NO];
}
-(void)run
{
    [self.cellSelectView setHidden:NO];
    [self.textLabel setHidden:NO];
    [self.titleLabel setHidden: NO];
    [self.monthLabel setHidden: NO];
    [self.cellBackgroundView setAlpha:1.0];
    [self.middleMonthLabel setHidden:YES];

}
-(void)close
{
    [self.cellSelectView setHidden:YES];
    [self.textLabel setHidden:YES];
    [self.titleLabel setHidden: YES];
    [self.monthLabel setHidden: YES];
    [self.cellBackgroundView setAlpha:0.5];
    [self.middleMonthLabel setHidden:NO];

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpUIView];
}
-(void)setUpUIView
{
//    NSLog(@"%@",NSStringFromCGRect(self.contentView.bounds));
    self.cellSelectView = [[UIView alloc]initWithFrame:self.contentView.frame];
    [self.cellSelectView  setBackgroundColor:[UIColor colorWithRed:248 / 255.0 green:109 / 255.0 blue:66 / 255.0 alpha:0.15]];
    [self.contentView addSubview: self.cellSelectView];
    [self.cellSelectView.layer setCornerRadius:self.cellSelectView.bounds.size.width / 2];
    
    
    self.cellBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(8, 8, self.contentView.bounds.size.width - 16, self.contentView.bounds.size.height - 16)];
    [self.cellBackgroundView setBackgroundColor:[UIColor colorWithRed:248 / 255.0 green:109 / 255.0 blue:66 / 255.0 alpha:1.0f]];
    [self.cellBackgroundView.layer setCornerRadius: self.cellBackgroundView.bounds.size.width / 2];
    [self.contentView addSubview: self.cellBackgroundView];
    [self.cellSelectView  setHidden:self.cellSelectViewHide];
    [self.contentView addSubview: self.textLabel];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.monthLabel];
    [self.contentView addSubview: self.middleMonthLabel];
    

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, -(FONTSCALS(12)), self.monthLabel.bounds.size.width, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithWhite:255.f alpha:.7]];
    [self.monthLabel addSubview:lineView];
    self.lineView = lineView;
    [self.lineView setHidden: YES];


    
    if (self.cellSelectViewHide) {
        [self close];
    }else{
        [self run];
    }
}
#pragma  mark  - layz
-(UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.contentView.bounds.size.width - 20, 40)];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [_textLabel setTextColor:[UIColor whiteColor]];
        [_textLabel setCenter:self.contentView.center];
        [_textLabel setFont:[UIFont systemFontOfSize:FONTSCALS(30)]];
    }
    return _textLabel;
}
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.textLabel.frame) - 15, self.contentView.bounds.size.width, 20)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize: FONTSCALS(11)]];
    }
    return _titleLabel;
}

-(UILabel *)monthLabel
{
    if (_monthLabel == nil) {
        CGFloat labelX = 16;
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake( labelX, self.bounds.size.height - FONTSCALS(35), self.contentView.bounds.size.width - labelX * 2, 20)];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [_monthLabel setTextColor:[UIColor whiteColor]];
        [_monthLabel setFont:[UIFont systemFontOfSize: FONTSCALS(16)]];
    }
    return _monthLabel;
}
-(UILabel *)middleMonthLabel
{
    if (_middleMonthLabel == nil) {
        _middleMonthLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.contentView.bounds.size.width - 20, 40)];
        [_middleMonthLabel setCenter:self.contentView.center];
        [_middleMonthLabel setTextAlignment:NSTextAlignmentCenter];
        [_middleMonthLabel setTextColor:[UIColor whiteColor]];
        [_middleMonthLabel setFont:[UIFont systemFontOfSize: FONTSCALS(30)]];
    }
    return _middleMonthLabel;

}
@end
