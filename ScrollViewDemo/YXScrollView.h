//
//  YXScrollView.h
//  ScrollViewDemo
//
//  Created by cimimorio on 16/4/8.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXScorllViewdDelegate <NSObject>

@optional
-(void)didSelectedPage:(long)index;

@end
@interface YXScrollView : UIScrollView
@property(nonatomic, strong)NSArray * dataSource;
@property (nonatomic, assign)id<YXScorllViewdDelegate> adDelegate;
-(void)reloadData;
@end
