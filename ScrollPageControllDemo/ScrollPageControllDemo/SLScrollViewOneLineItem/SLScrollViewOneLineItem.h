//
//  SLScrollViewOneLineItem.h
//  sudaizhijia
//
//  Created by 武传亮 on 2017/9/7.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLScrollViewOneLineItemDelegate <NSObject>

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
 item视图的宽度
 
 @param view 视图
 @return 列宽
 */
- (CGFloat)itemWidthForView:(UIView *)view;


/**
 item边缘距离
 
 @param view 视图
 @return item的边缘距离
 */
- (UIEdgeInsets)edgeInsetsOfItemsInView:(UIView *)view;


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



@end


@interface SLScrollViewOneLineItem : UIView


/** 滑动视图 */
@property (strong, nonatomic) UIScrollView *scrollView;

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
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SLScrollViewOneLineItemDelegate>)delegate;




@end
