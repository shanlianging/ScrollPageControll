//
//  SLScrollViewOneLineItem.m
//  sudaizhijia
//
//  Created by 武传亮 on 2017/9/7.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "SLScrollViewOneLineItem.h"

#define kTag 2001

// 指示器高度
#define kIndicatorH 5
// 指示器宽度
#define kIndicatorW 16
// 指示器背景宽度
#define kIndicatorBackViewW 48

@interface SLScrollViewOneLineItem ()<UIScrollViewDelegate>



/**  */
@property (weak, nonatomic) id<SLScrollViewOneLineItemDelegate> delegate;

/** 个数 */
@property (assign, nonatomic) NSInteger itemCounts;


/** 边缘 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;


/** 列间距 */
@property (assign, nonatomic) CGFloat columnSpace;

/** item宽度 */
@property (assign, nonatomic) CGFloat itemWidth;


/** 指示器背景 */
@property (strong, nonatomic) UIView *indicatorBackView;
/** 指示器 */
@property (strong, nonatomic) UIView *indicatorView;


@end

@implementation SLScrollViewOneLineItem

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SLScrollViewOneLineItemDelegate>)delegate {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _delegate = delegate;
        
        [self initValue];
        
        [self setupView];
    }
    return self;
    
}

- (void)initValue {
    
    _itemCounts = 10;
    _edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _columnSpace = 10;
    _itemWidth = 100;
    
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfItemsInView:)]) {
        _itemCounts = [_delegate numberOfItemsInView:self];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(edgeInsetsOfItemsInView:)]) {
        _edgeInsets = [_delegate edgeInsetsOfItemsInView:self];
    }
   
    if (_delegate && [_delegate respondsToSelector:@selector(columnSpaceOfItemsInView:)]) {
        _columnSpace = [_delegate columnSpaceOfItemsInView:self];
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(columnSpaceOfItemsInView:)]) {
        _itemWidth = [_delegate itemWidthForView:self];
    }
    
    
}

- (void)updateView {
    
    [self initValue];
    
    [self setupView];
    
}


- (void)setupView {
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.scrollView];
    
    [self addSubview:self.indicatorBackView];
    self.indicatorBackView.center = CGPointMake(self.center.x, CGRectGetMaxY(self.scrollView.frame) + 10);
    
    [self.indicatorBackView addSubview:self.indicatorView];

    
    
    self.scrollView.contentSize = CGSizeMake((self.edgeInsets.left + self.edgeInsets.right + self.itemWidth * self.itemCounts + (self.itemCounts - 1) * self.columnSpace), self.frame.size.height);
    
//    NSInteger pageCount = ceilf(((self.itemWidth * self.itemCounts) + ((self.itemCounts - 1) * self.columnSpace) + self.edgeInsets.left + self.edgeInsets.right) / self.frame.size.width);
    
    
    // 几行
    for (NSInteger x = 0; x < self.itemCounts; x ++) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(itemForView:index:)]) {
            
            UIView *view = [_delegate itemForView:self index:x];
            
            CGRect frame = view.frame;
            frame.origin.x = self.edgeInsets.left + (self.itemWidth * x) + (self.columnSpace * x);
            frame.origin.y = 0;
            frame.size.width = self.itemWidth;
            frame.size.height = self.scrollView.frame.size.height;
            view.frame = frame;
            
            [self.scrollView addSubview:view];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [view addGestureRecognizer:tap];
            view.tag = kTag + x;
            view.userInteractionEnabled = YES;
        
        }
    
    }
    
        
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
        
    if (_delegate && [_delegate respondsToSelector:@selector(item:didSelectItemAtIndex:)]) {
        [_delegate item:tap.view didSelectItemAtIndex:tap.view.tag - kTag];
    }
}


#pragma mark -
#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect frame = self.indicatorView.frame;
    frame.origin.x = scrollView.contentOffset.x * (kIndicatorBackViewW -  kIndicatorW) / (scrollView.contentSize.width - self.frame.size.width);
    self.indicatorView.frame = frame;
    
}


#pragma mark -
#pragma mark -- 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}


- (UIView *)indicatorBackView {
    if (!_indicatorBackView) {
        _indicatorBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kIndicatorBackViewW, kIndicatorH)];
        _indicatorBackView.backgroundColor = [UIColor whiteColor];
        _indicatorBackView.layer.borderWidth = 1;
        _indicatorBackView.layer.borderColor = [UIColor blueColor].CGColor;
    }
    return _indicatorBackView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kIndicatorW, kIndicatorH)];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}




@end
