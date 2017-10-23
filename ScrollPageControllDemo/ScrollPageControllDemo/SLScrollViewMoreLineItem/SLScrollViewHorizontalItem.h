//
//  SLScrollViewHorizontalItem.h
//  ScrollPageControllTest
//
//  Created by 武传亮 on 2017/8/14.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    /** 横向排列 */
    SLDistributionDirectionHorizontal,
    /** 纵向排列 */
    SLDistributionDirectionVertical,
} SLDistributionDirection;


@protocol SLScrollViewHorizontalItemDelegate <NSObject>

@required;

/**
 item的个数

 @param view 视图
 @return item的个数
 */
- (NSInteger)numberOfItemsInView:(UIView *)view;


/**
 item视图

 @param view 视图
 @param index item的位置
 @return item视图
 */
- (UIView *)itemForView:(UIView *)view index:(NSInteger)index;

@optional

/**
 几行

 @param view 视图
 @return 行数
 */
- (NSInteger)lineNumberOfItemsInView:(UIView *)view;

/**
 几列

 @param view 视图
 @return 列数
 */
- (NSInteger)columnNumberOfItemsInView:(UIView *)view;

/**
 item边缘距离

 @param view 视图
 @return item的边缘距离
 */
- (UIEdgeInsets)edgeInsetsOfItemsInView:(UIView *)view;

/**
 item视图之间的行高
 
 @param view 视图
 @return 行高
 */
- (CGFloat)lineSpaceOfItemsInView:(UIView *)view;

/**
 item视图之间的列宽
 
 @param view 视图
 @return 列宽
 */
- (CGFloat)columnSpaceOfItemsInView:(UIView *)view;

/**
 选中的item

 @param item 选中的item视图
 @param index item的下标
 */
- (void)item:(UIView *)item didSelectItemAtIndex:(NSInteger)index;


/**
 排布方向

 @param view 视图
 @return 方向
 */
- (SLDistributionDirection)distributionDirectionAtView:(UIView *)view;

@end



@interface SLScrollViewHorizontalItem : UIView

/** 滑动视图 */
@property (strong, nonatomic) UIScrollView *scrollView;
/** 页码控制器 */
@property (strong, nonatomic) UIPageControl *pageControl;

/**
 更新视图
 */
- (void)updateView;


/**
 创建视图

 @param frame 视图的frame
 @param delegate 视图的代理方法
 @return 视图实例
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SLScrollViewHorizontalItemDelegate>)delegate;


@end
