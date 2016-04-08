//
//  YXScrollView.h
//  ScrollViewDemo
//
//  Created by cimimorio on 16/4/8.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXScrollView : UIScrollView
@property(nonatomic, strong)NSArray * dataSource;
-(void)reloadData;
@end
