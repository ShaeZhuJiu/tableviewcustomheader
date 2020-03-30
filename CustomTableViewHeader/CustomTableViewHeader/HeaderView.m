//
//  HeaderView.m
//  CustomTableViewHeader
//
//  Created by 谢鑫 on 2019/5/31.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger currentPage;
@end
@implementation HeaderView
- (void)dealloc
{//timer在视图生命周期结束的时候禁用掉
    [self.timer invalidate];
    [self setTimer:nil];
}
+(instancetype)headerView{
    HeaderView *headerView=[[self alloc]init];
    [headerView setScrollView:[[UIScrollView alloc]init]];
    [headerView.scrollView setPagingEnabled:YES];//分页打开
    [headerView.scrollView setShowsHorizontalScrollIndicator:NO];
    [headerView.scrollView setDelegate:headerView];
    [headerView addSubview:headerView.scrollView];//headerView类的属性添加到headerView上
    return headerView;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{//完成header view和scrollview的frame的设置
    CGFloat width=CGRectGetWidth(newSuperview.bounds);
    CGFloat height=180;
    [self setFrame:CGRectMake(0, 0, width, height)];
    [self.scrollView setFrame:self.bounds];
    [self.scrollView setContentSize:CGSizeMake(3*width, height)];//内容视图的尺寸
    [self addImageViews];//wiframellMoveToSuperview里调用addImageViews而不在工厂方法里调用，是因为工厂方法还没有设置frame
    [self initTimer];//在.m里直接写的函数，没在.h里声明过，不是属性，所以用[self 方法名]的方式
}
-(void)addImageViews{
    CGFloat width=CGRectGetWidth(self.frame);
    CGFloat height=CGRectGetHeight(self.frame);
    
    for(NSInteger i=0;i<3;i++){
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*width, 0, width, height)];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)i]]];
        [self.scrollView addSubview:imageView];//添加到scrollView上
    }
}
//创建timer的方法
-(void)initTimer{
    [self setTimer:[NSTimer timerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES]];
    //timer添加到runloop中，以保证可以正常的工作
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
-(void)changeImage{//之前可以实现手动翻页，在timer的函数里实现自动翻页
    self.currentPage++;
    if(self.currentPage>=3){
        self.currentPage=0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.currentPage*CGRectGetWidth(self.frame), 0) animated:YES];
}
//在手动滑动的时候要把定时器停掉，防止误差的实现，要用到scrollView的代理方法
#pragma mark - Scroll view delegate -
//开始拖拽的时候禁用timer
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.timer){
        [self.timer invalidate];
        [self setTimer:nil];
    }
}
//结束拖拽的时候，重新启用timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self initTimer];
}
@end


