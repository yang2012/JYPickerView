//
//  ISUPickerLabel.m
//  JYPickerView
//
//  Created by Justin Yang on 14-7-20.
//  Copyright (c) 2014年 Nanjing University. All rights reserved.
//

#import "ISUPickerLabel.h"

@implementation ISUPickerLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.normal          = YES;

        self.backgroundColor = [UIColor clearColor];
        self.font            = [UIFont systemFontOfSize:30.0f];
        self.textAlignment   = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void)setNormal:(BOOL)normal
{
    _normal = normal;
    
    if (normal) {
        self.textColor = [UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f /255.0f alpha:1.0f];
    } else {
        self.textColor = [UIColor colorWithRed:255.0f / 255.0f green:102.f / 255.0f blue:51.0f / 255.0f alpha:1.0f];
    }
}

- (void)setProgress:(CGFloat)progress
{
    self.alpha = progress;
    
    if (fabs(1.0f - progress) < 0.1) {
        self.normal = NO;
    } else {
        self.normal = YES;
    }
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, progress, progress, 1);
    self.layer.transform = transform;
}

@end
