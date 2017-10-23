//
//  SLOneLineViewController.m
//  ScrollPageControllDemo
//
//  Created by 武传亮 on 2017/9/11.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "SLOneLineViewController.h"
#import "SLScrollViewOneLineItem.h"

@interface SLOneLineViewController ()<SLScrollViewOneLineItemDelegate>


/**  */
@property (strong, nonatomic) SLScrollViewOneLineItem *scrollVHItem;
@property (strong, nonatomic) NSArray *dataArray;


@end

@implementation SLOneLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"SLOneLineViewController";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    [self.view addSubview:self.scrollVHItem];
    
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicatorView];
    activityIndicatorView.center = self.scrollVHItem.center;
    
    
    [activityIndicatorView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [activityIndicatorView stopAnimating];

        NSMutableArray *array = [NSMutableArray new];
        for (NSInteger i = 0; i < 11; i++) {
            [array addObject:@(i)];
        }
        self.dataArray = array;
        
        [self.scrollVHItem removeFromSuperview];
        self.scrollVHItem = nil;
        
        [self.scrollVHItem updateView];
        [self.view addSubview:self.scrollVHItem];
        
    });
    
    


}

- (UIView *)itemForView:(UIView *)view index:(NSInteger)index {
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor brownColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%@", self.dataArray[index]];
    
    return label;
    
}



-(NSInteger)numberOfItemsInView:(UIView *)view {
    
    return self.dataArray.count;
}


- (CGFloat)columnSpaceOfItemsInView:(UIView *)view {
    return 10.f;
}

- (UIEdgeInsets)edgeInsetsOfItemsInView:(UIView *)view  {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)itemWidthForView:(UIView *)view {
    return 100;
}

- (void)item:(UIView *)item didSelectItemAtIndex:(NSInteger)index {
    

    NSLog(@"第 %ld 个", index);
    
    
}

#pragma mark -
#pragma mark -- 懒加载


- (SLScrollViewOneLineItem *)scrollVHItem {
    if (!_scrollVHItem) {
        _scrollVHItem = [[SLScrollViewOneLineItem alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100) delegate:self];
        _scrollVHItem.scrollView.bounces = NO;
        _scrollVHItem.backgroundColor = [UIColor cyanColor];
        
    }
    return _scrollVHItem;
}






@end
