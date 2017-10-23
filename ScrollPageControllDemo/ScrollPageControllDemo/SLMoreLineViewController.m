//
//  SLMoreLineViewController.m
//  ScrollPageControllDemo
//
//  Created by 武传亮 on 2017/9/11.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "SLMoreLineViewController.h"
#import "SLScrollViewHorizontalItem.h"

@interface SLMoreLineViewController ()<SLScrollViewHorizontalItemDelegate>
@property (assign, nonatomic) NSInteger count;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) SLScrollViewHorizontalItem *scrollViewHorizontalItem;


@end

@implementation SLMoreLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"SLMoreLineViewController";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollViewHorizontalItem = [[SLScrollViewHorizontalItem alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) delegate:self];
    self.scrollViewHorizontalItem.backgroundColor = [UIColor colorWithRed:(218 / 255.0f) green:(255 / 255.0f) blue:(226 / 255.0f) alpha:1];
    [self.view addSubview:self.scrollViewHorizontalItem];
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < 11; i++) {
        [array addObject:@(i)];
    }
    self.dataArray = array;
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicatorView];
    activityIndicatorView.center = self.scrollViewHorizontalItem.center;
    
    [activityIndicatorView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [activityIndicatorView stopAnimating];
        [self.scrollViewHorizontalItem updateView];
    });
    
    
}

- (NSInteger)numberOfItemsInView:(UIView *)view {
    return self.dataArray.count;
}

- (NSInteger)lineNumberOfItemsInView:(UIView *)view {
    return 2;
}

- (NSInteger)columnNumberOfItemsInView:(UIView *)view {
    return 4;
}

- (CGFloat)lineSpaceOfItemsInView:(UIView *)view {
    return 10;
}

- (CGFloat)columnSpaceOfItemsInView:(UIView *)view {
    return 10;
}


- (UIEdgeInsets)edgeInsetsOfItemsInView:(UIView *)view {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UIView *)itemForView:(UIView *)view index:(NSInteger)index {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor brownColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%ld", [self.dataArray[index] integerValue]];
    
    return label;
    
}

- (void)item:(UIView *)item didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}

//- (SLDistributionDirection)distributionDirectionAtView:(UIView *)view {
//    return SLDistributionDirectionVertical;
//}




@end
