//
//  ZLMultiPageViewController.m
//  ZLMultiPageSliding
//
//  Created by 周礼 on 17/5/12.
//  Copyright © 2017年 com.sky. All rights reserved.
//

#import "ZLMultiPageViewController.h"

@interface ZLMultiPageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *mainCollectionView;
    
    NSArray *titles, *pages;
    UIStackView *stackView;
    UIView *lineView;
    NSInteger lastSelectedIndex;
}
@end

@implementation ZLMultiPageViewController

- (id) initWithTitleArray:(NSArray *) titleArray pages:(NSArray *) pageArray{
    self = [self init];
    if(self){
        titles = titleArray;
        pages = pageArray;
        self.view.backgroundColor = [UIColor whiteColor];
        lastSelectedIndex = 2;
        [self setupPageItemView];
        [self setupPageViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.pagingEnabled = YES;
    mainCollectionView.bounces = NO;
    mainCollectionView.showsVerticalScrollIndicator = NO;
    mainCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:mainCollectionView];
    
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
}

- (void) setupPageItemView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZL_PAGEVIEW_ITEM_WIDTH*titles.count, 44)];
    stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, ZL_PAGEVIEW_ITEM_WIDTH * titles.count, 44)];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFillEqually;
    for(int i=0;i<titles.count;i++){
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn1 setTitleColor:I_HexStr(@"545454") forState:UIControlStateNormal];
        [btn1 setTitleColor:I_HexStr(@"989898") forState:UIControlStateSelected];
        btn1.tag = i;
        [btn1 addTarget:self action:@selector(itemViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [stackView addArrangedSubview:btn1];
        if(i==lastSelectedIndex){
            btn1.selected = YES;
        }
    }
    [titleView addSubview:stackView];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, 30, .5)];
    CGPoint center = lineView.center;
    center.x = (lastSelectedIndex+.5) * ZL_PAGEVIEW_ITEM_WIDTH;
    lineView.center = center;
    lineView.backgroundColor = [UIColor blackColor];
    [titleView addSubview:lineView];
    self.navigationItem.titleView = titleView;
}

- (void) setupPageViewController{
    [mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:lastSelectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void) setBottomLineViewLocation{
    CGPoint point = lineView.center;
    UIView *currentView = [[stackView arrangedSubviews] objectAtIndex:lastSelectedIndex];
    point.x = currentView.center.x;
    [UIView animateWithDuration:.15 animations:^{
        lineView.center = point;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return pages.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIViewController *vc = [pages objectAtIndex:indexPath.row];
    vc.view.frame = self.view.bounds;
    [cell addSubview:vc.view];
    return cell;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger total = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSInteger model = (int)scrollView.contentOffset.x % (int)SCREEN_WIDTH;
    NSArray *subViews = stackView.arrangedSubviews;
    NSInteger index = total + (model>0?1:0);
    [self itemViewAction:[subViews objectAtIndex:index]];
}

- (void) itemViewAction:(UIButton *) btn{
    if(lastSelectedIndex != btn.tag){
        NSArray *subViews = stackView.arrangedSubviews;
        for(UIView *subView in subViews){
            if([subView isKindOfClass:[UIButton class]]){
                if(subView == btn){
                    ((UIButton *) subView).selected = YES;
                    lastSelectedIndex = btn.tag;
                }else{
                    ((UIButton *) subView).selected = NO;
                }
            }
        }
        [self setBottomLineViewLocation];
        [mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:lastSelectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
