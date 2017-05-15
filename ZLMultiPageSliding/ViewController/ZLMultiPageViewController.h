//
//  ZLMultiPageViewController.h
//  ZLMultiPageSliding
//
//  Created by 周礼 on 17/5/12.
//  Copyright © 2017年 com.sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMultiPageViewController : UIViewController
- (id) initWithTitleArray:(NSArray *) titleArray pages:(NSArray *) pageArray;
@property (copy, nonatomic) void (^pageChangedBlock)(NSInteger currentIndex);
@end
