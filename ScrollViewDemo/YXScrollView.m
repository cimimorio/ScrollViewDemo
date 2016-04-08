//
//  YXScrollView.m
//  ScrollViewDemo
//
//  Created by cimimorio on 16/4/8.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXScrollView.h"
#import "UIImageView+WebCache.h"


#define CURRENT_WIDTH self.frame.size.width
#define CURRENT_HEIGHT self.frame.size.height
#define SCROLL_INTERVAL 3

@interface YXScrollView ()<UIScrollViewDelegate>{
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    NSInteger _currentIndex;
    NSTimer * _timer;
    UIPageControl * _pageControl;
}
@end

@implementation YXScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化操作
        [self configUI];
        [self createTimer];
    }
    return self;
}

-(void)configUI{
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_WIDTH, CURRENT_HEIGHT)];
    _leftImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_leftImageView];
    
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_WIDTH, 0, CURRENT_WIDTH, CURRENT_HEIGHT)];
    _centerImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_centerImageView];
    
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_WIDTH * 2, 0, CURRENT_WIDTH, CURRENT_HEIGHT)];
    _rightImageView.backgroundColor = [UIColor blueColor];
    [self addSubview:_rightImageView];
    self.contentSize = CGSizeMake(CURRENT_WIDTH * 3, 0);
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.contentOffset = CGPointMake(CURRENT_WIDTH, 0);
    self.delegate = self;
    _currentIndex = 0;
}

-(void)createTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:SCROLL_INTERVAL target:self selector:@selector(autoScrollImage) userInfo:nil repeats:YES];
}

-(void)autoScrollImage{
    [self setContentOffset:CGPointMake(CURRENT_WIDTH * 2, 0) animated:YES];
}

-(void)setDataSource:(NSArray *)dataSource{
    // 设置初始图片
    if (dataSource) {
        _dataSource = dataSource;
        [self setImageWithName:[dataSource lastObject] toImageView:_leftImageView];
        [self setImageWithName:[dataSource firstObject] toImageView:_centerImageView];
        [self setImageWithName:dataSource[(_currentIndex + 1) % dataSource.count] toImageView:_rightImageView];
        [self createPageControl];
    }
}

-(void)reloadData{
    [self createPageControl];
}

-(void)createPageControl{
    if (self.superview) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + CURRENT_HEIGHT - 20, CURRENT_WIDTH, 20)];
        _pageControl.numberOfPages = _dataSource.count;
        _pageControl.currentPage = _currentIndex;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self.superview addSubview:_pageControl];
    }else{
        NSLog(@"请将YXScrollView对象添加到父视图再设置dataSource，或者调用reloadData方法");
    }
}

// Timer滚动图片完成后执行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollImage:scrollView];
}

// 手动滚动图片后完成
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:SCROLL_INTERVAL]];
    [self scrollImage:scrollView];
}

-(void)scrollImage:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    if (_dataSource){
        if (x == 0) {
            // 向左滑动一屏
            if (_currentIndex == 0) {
                _currentIndex = _dataSource.count - 1;
            }else{
                _currentIndex--;
            }
        }else if(x == CURRENT_WIDTH * 2){
            // 向右滑动一屏
            if (_currentIndex == _dataSource.count - 1) {
                _currentIndex = 0;
            }else{
                _currentIndex++;
            }
        }
        
        if (_currentIndex == 0) {
            [self setImageWithName:_dataSource[_dataSource.count-1] toImageView:_leftImageView];
        }else{
            [self setImageWithName:_dataSource[_currentIndex-1] toImageView:_leftImageView];
        }
        [self setImageWithName:_dataSource[_currentIndex] toImageView:_centerImageView];
        [self setImageWithName:_dataSource[(_currentIndex+1) % _dataSource.count] toImageView:_rightImageView];
    }
    
    _pageControl.currentPage = _currentIndex;
    
    self.contentOffset = CGPointMake(CURRENT_WIDTH, 0);
}

-(void)setImageWithName:(NSString *)name toImageView:(UIImageView *)imageView{
    if ([name hasPrefix:@"http://"] || [name hasPrefix:@"https://"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:name]];
    }else{
        [imageView setImage:[UIImage imageNamed:name]];
    }
}
@end