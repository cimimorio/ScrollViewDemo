//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by cimimorio on 16/4/8.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "ViewController.h"
#import "YXScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YXScrollView * sv = [[YXScrollView alloc]initWithFrame:CGRectMake(0, 100, 375, 160)];
    [self.view addSubview:sv];
    sv.dataSource = @[@"banner_1",@"banner_2",@"banner_3",@"banner_2",@"banner_3",@"banner_1"];
    
    [sv reloadData];
    
    
    YXScrollView * sv1 = [[YXScrollView alloc]initWithFrame:CGRectMake(0, 300, 375, 160)];
    [self.view addSubview:sv1];
    sv1.dataSource = @[@"banner_1",@"banner_2",@"banner_3", @"http://pic1.shejiben.com/hot_sjb/394_7979.jpg?1457506695",@"http://pic.shejiben.com/hot_sjb/394_7765.jpg?1457319423",@"http://pic.shejiben.com/hot_sjb/394_6575.jpg?1453084721"];
    [sv1 reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
