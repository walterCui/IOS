//
//  EPetPageView.m
//  EPet
//
//  Created by walter on 14-9-17.
//  Copyright (c) 2014年 com.Example. All rights reserved.
//

#import "EPetPageView.h"

@interface EPetPageView()
@property NSMutableArray *_views;
@property UIPageControl *_pageControl;
@end

@implementation EPetPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setPageControl:self.frame];
    
    [self setPageView:rect];
    
    self.delegate = self;
}

-(void)setPageControl:(CGRect)rect
{
    self._pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake( rect.origin.x + rect.size.width/2-50, rect.origin.y + rect.size.height, 100,10)];
    
    self._pageControl.alpha = 1;
    self._pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self._pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self._pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
    [self.superview addSubview:self._pageControl];

}

-(void)setPageView:(CGRect)rect
{
    CGRect cg = rect;
    
    for (int i =0; i < 3; i++) {
        cg.origin.x = i * cg.size.width;
        UIImageView * im = [[UIImageView alloc] initWithFrame: cg];
        
        [im setImage: [UIImage imageNamed:@"Icon_ShouYe_ShangCheng.jpg"]];
        [self._views addObject:im];
        [self addSubview:im];
        //[im release];
    }
    self.contentSize = CGSizeMake(3 * cg.size.width, cg.size.height);
    self.showsHorizontalScrollIndicator=NO;
    self.pagingEnabled = YES;
    self.clipsToBounds = YES;
    
    self._pageControl.numberOfPages= 3;
    self._pageControl.currentPage=0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGSize bounds = scrollView.frame.size;
    
    [self._pageControl setCurrentPage:offset.x/bounds.width];
}


-(IBAction)pageTurn:(UIPageControl*)sender
{
    CGSize viewSize = self.frame.size;
    CGRect cg = CGRectMake(sender.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    
    [self scrollRectToVisible:cg animated:YES];
    
}
@end
