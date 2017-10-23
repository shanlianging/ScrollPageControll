//
//  SLScrollViewHorizontalItem.m
//  ScrollPageControllTest
//
//  Created by 武传亮 on 2017/8/14.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "SLScrollViewHorizontalItem.h"

#define kTag 1001


@interface SLScrollViewHorizontalItem ()<UIScrollViewDelegate>



/**  */
@property (weak, nonatomic) id<SLScrollViewHorizontalItemDelegate> delegate;

/** 个数 */
@property (assign, nonatomic) NSInteger itemCounts;
/** 行数 */
@property (assign, nonatomic) NSInteger lineNumber;
/** 列数 */
@property (assign, nonatomic) NSInteger columnNumber;
/**  */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
/** 行间距 */
@property (assign, nonatomic) CGFloat lineSpace;
/** 列间距 */
@property (assign, nonatomic) CGFloat columnSpace;
/** 排布方向 */
@property (assign, nonatomic) SLDistributionDirection distributionDirection;

@end

@implementation SLScrollViewHorizontalItem


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SLScrollViewHorizontalItemDelegate>)delegate {
    
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
    _lineNumber = 2;
    _columnNumber = 4;
    _edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _lineSpace = 10;
    _columnSpace = 10;
    _distributionDirection = SLDistributionDirectionHorizontal;
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfItemsInView:)]) {
        _itemCounts = [_delegate numberOfItemsInView:self];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lineNumberOfItemsInView:)]) {
        _lineNumber = [_delegate lineNumberOfItemsInView:self];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(columnNumberOfItemsInView:)]) {
        _columnNumber = [_delegate columnNumberOfItemsInView:self];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(edgeInsetsOfItemsInView:)]) {
        _edgeInsets = [_delegate edgeInsetsOfItemsInView:self];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lineSpaceOfItemsInView:)]) {
        _lineSpace = [_delegate lineSpaceOfItemsInView:self];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(columnSpaceOfItemsInView:)]) {
        _columnSpace = [_delegate columnSpaceOfItemsInView:self];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(distributionDirectionAtView:)]) {
        _distributionDirection = [_delegate distributionDirectionAtView:self];
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
//    self.scrollView = nil;
    
    [self addSubview:self.scrollView];
    
    CGFloat width = (self.frame.size.width - (self.edgeInsets.left + self.edgeInsets.right + self.lineSpace * (self.columnNumber - 1))) / self.columnNumber;
    CGFloat height = (self.frame.size.height - (self.edgeInsets.top + self.edgeInsets.bottom + self.lineSpace * (self.lineNumber - 1))) / self.lineNumber;
    
    NSInteger pageCount = ceilf((CGFloat)self.itemCounts / (self.lineNumber * self.columnNumber));
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);
    
    NSInteger countNumber = 0;
    
    
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:(164 / 255.0f) green:(164 / 255.0f) blue:(164 / 255.0f) alpha:1];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:(73 / 255.0f) green:(73 / 255.0f) blue:(73 / 255.0f) alpha:1];
    [self addSubview:self.pageControl];
    
    
    
    switch (self.distributionDirection) {
        case SLDistributionDirectionHorizontal:
            
            // 几页
            for (NSInteger page = 0; page < pageCount; page ++) {
                
                // 几行
                for (NSInteger x = 0; x < self.lineNumber; x ++) {
                    // 几列
                    for (NSInteger y = 0; y < self.columnNumber; y ++) {
                        
                        if (countNumber == self.itemCounts) {
                            return;
                        }
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(itemForView:index:)]) {
                            UIView *view = [_delegate itemForView:self index:countNumber];
                            view.frame = CGRectMake(self.edgeInsets.left + (page * self.frame.size.width) + (y * (self.lineSpace + width)), self.edgeInsets.top + (x * (height + self.lineSpace)), width, height);
                            [self.scrollView addSubview:view];
                            
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                            [view addGestureRecognizer:tap];
                            view.tag = kTag + countNumber;
                            view.userInteractionEnabled = YES;
                            
                            countNumber ++;
                            
                        }
                        
                    }
                }
            }            
            
            break;
        case SLDistributionDirectionVertical:
            
            // 几页
            for (NSInteger page = 0; page < pageCount; page ++) {
                // 几列
                for (NSInteger y = 0; y < self.columnNumber; y ++) {
                    // 几行
                    for (NSInteger x = 0; x < self.lineNumber; x ++) {
                        
                        
                        if (countNumber == self.itemCounts) {
                            return;
                        }
                        
                        if (_delegate && [_delegate respondsToSelector:@selector(itemForView:index:)]) {
                            UIView *view = [_delegate itemForView:self index:countNumber];
                            view.frame = CGRectMake(self.edgeInsets.left + (page * self.frame.size.width) + (y * (self.lineSpace + width)), self.edgeInsets.top + (x * (height + self.lineSpace)), width, height);
                            [self.scrollView addSubview:view];
                            
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                            [view addGestureRecognizer:tap];
                            view.tag = kTag + countNumber;
                            view.userInteractionEnabled = YES;
                            
                            countNumber ++;
                            
                        }
                        
                    }
                }
            }
            
            
            break;
            
        default:
            break;
    }
    
    
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    //    NSLog(@"%ld", tap.view.tag - kTag);
    
    if (_delegate && [_delegate respondsToSelector:@selector(item:didSelectItemAtIndex:)]) {
        [_delegate item:tap.view didSelectItemAtIndex:tap.view.tag - kTag];
    }
}


#pragma mark -- 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        //        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}




#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger n = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = n;
}



@end
