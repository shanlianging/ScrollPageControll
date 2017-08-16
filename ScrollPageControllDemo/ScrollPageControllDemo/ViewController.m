//
//  ViewController.m
//  ScrollPageControllDemo
//
//  Created by 武传亮 on 2017/8/16.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "ViewController.h"
#import "SLScrollViewHorizontalItem.h"

@interface ViewController ()<SLScrollViewHorizontalItemDelegate>

@property (assign, nonatomic) NSInteger count;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) SLScrollViewHorizontalItem *scrollViewHorizontalItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.scrollViewHorizontalItem = [[SLScrollViewHorizontalItem alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) delegate:self];
    self.scrollViewHorizontalItem.backgroundColor = [UIColor colorWithRed:(218 / 255.0f) green:(255 / 255.0f) blue:(226 / 255.0f) alpha:1];
    [self.view addSubview:self.scrollViewHorizontalItem];
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < 11; i++) {
        [array addObject:@(i)];
    }
    self.dataArray = array;
    
    self.count = 10;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.count = 20;
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
