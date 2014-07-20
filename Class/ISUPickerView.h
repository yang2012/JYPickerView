//
//  ISUPickerView.h
//  JYPickerView
//
//  Created by Justin Yang on 14-7-20.
//  Copyright (c) 2014年 Nanjing University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISUPickerView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *seperatorLineView;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UILabel *itemNameLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *comfirmButton;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, assign) NSInteger step;
@property (nonatomic, assign) NSInteger startItemIndex;

- (void)refresh;

- (void)showOnView:(UIView *)view animated:(BOOL)animated;

@end
