//
//  ViewController.m
//  ScrollPageControllDemo
//
//  Created by 武传亮 on 2017/8/16.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "ViewController.h"
#import "SLOneLineViewController.h"
#import "SLMoreLineViewController.h"


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ScrollPageControllDemo";
    
    
}


- (IBAction)oneAction:(UIButton *)sender {
    
    SLOneLineViewController *one = [SLOneLineViewController new];
    [self.navigationController pushViewController:one animated:YES];
    
    
}


- (IBAction)moreAction:(id)sender {
    
    SLMoreLineViewController *more = [SLMoreLineViewController new];
    [self.navigationController pushViewController:more animated:YES];
    
    
}

@end
