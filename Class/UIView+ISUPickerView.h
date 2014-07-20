//
//  UIView+ISUPickerView.h
//  JYPickerView
//
//  Created by Justin Yang on 14-7-20.
//  Copyright (c) 2014年 Nanjing University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ISUPickerView)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)isu_removeAllSubviews;

@end
