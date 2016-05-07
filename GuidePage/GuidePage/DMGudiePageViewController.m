//
//  DMGudiePageViewController.m
//  GuidePage
//
//  Created by gdm on 16/5/7.
//  Copyright © 2016年 辜东明. All rights reserved.
//

#import "DMGudiePageViewController.h"
#import "UIImageView+WebCache.h"

@interface DMGudiePageViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    ImageType _imageType;
    NSArray *_imageArr;
    UIColor *_cuColor;
    UIColor *_otColor;
    DidSelectedEnter _didSelectedEnter;
}
@end

@implementation DMGudiePageViewController

-(instancetype)initWithImageType:(ImageType)imageType andImageArr:(NSArray*)imageArr andCurrentPageColor:(UIColor *)cuColor andOtherPageColor:(UIColor *)otColor andDidSelectedEnter:(DidSelectedEnter)didSelectedEnter;
{
    if(self = [super init])
    {
        _imageType = imageType;
        _imageArr = imageArr;
        _cuColor = cuColor;
        _otColor = otColor;
        _didSelectedEnter = didSelectedEnter;
        return self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [UIScreen mainScreen].bounds;
    _scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [_scrollView setPagingEnabled:YES];
    _scrollView.delegate = self;
    
    CGSize size = _scrollView.frame.size;
    size.width *= _imageArr.count;
    _scrollView.contentSize = size;
    
    [self.view addSubview:_scrollView];
    
    for (NSInteger i = 0; i < _imageArr.count; ++i) {
        float x = i * _scrollView.frame.size.width;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        if (_imageType == ImageName) {
            imageView.image = [UIImage imageNamed:_imageArr[i]];
        }else
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArr[i]]];
        }
        [_scrollView addSubview:imageView];
        
        //1.单击手势
        //1.1创建轻拍手势识别器
        if(i == _imageArr.count - 1){
            UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into)];
            
            //1.2根据需求设置手势的属性
            tapOnce.numberOfTapsRequired = 1; //设定要求的点击次数
            tapOnce.numberOfTouchesRequired = 1; //设定要求的触摸手指个数
            //1.3 把手势识别器添加到需要响应的view上
            //设置用户交换为yes
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tapOnce];
        }
        
    }
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 40 , 100, 20)];
    _pageControl.defersCurrentPageDisplay = YES;
    
    //设置居中
    CGPoint pageControlCenter = _pageControl.center;
    pageControlCenter.x = _scrollView.center.x;
    _pageControl.center = pageControlCenter;
    
    //设置页面(点)的数量和颜色
    _pageControl.numberOfPages = _imageArr.count;
    _pageControl.pageIndicatorTintColor = _otColor;
    _pageControl.currentPageIndicatorTintColor = _cuColor;
    //给pageControl添加actiong
    [_pageControl addTarget:self action:@selector(pageControlPageNumberChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
}

#pragma mark - pageControl的action
-(void)pageControlPageNumberChanged:(UIPageControl*)pageControl
{
    NSInteger pageNumber = pageControl.currentPage;
    
    //计算scrollView的对应页面偏移量,实现联动
    CGPoint offset = CGPointMake(_scrollView.frame.size.width*pageNumber, 0);
    [_scrollView setContentOffset:offset animated:YES];
    _pageControl.currentPage = offset.x/_scrollView.frame.size.width;
}

#pragma mark -scrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (NSInteger)scrollView.contentOffset.x/_scrollView.frame.size.width;
    if (_pageControl.currentPage == _imageArr.count - 1) {
        [self performSelector:@selector(into) withObject:nil afterDelay:2];
    }
    
}

-(void)into
{
    _didSelectedEnter();
}




@end
