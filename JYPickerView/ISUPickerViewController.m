//
//  ISUPickerViewController.m
//  JYPickerView
//
//  Created by Justin Yang on 14-7-20.
//  Copyright (c) 2014年 Nanjing University. All rights reserved.
//

#import "ISUPickerViewController.h"
#import "ISUPickerView.h"

#import "UIView+ISUPickerView.h"

@interface ISUPickerViewController ()

@property (nonatomic, strong) ISUPickerView *pickerView;

@end

@implementation ISUPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.pickerView = [[ISUPickerView alloc] init];
    self.pickerView.startItemIndex = 9;
    self.pickerView.titleLabel.text = @"送餐时间";
    self.pickerView.itemNameLabel.text = @"分钟";
    
    NSArray *items = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17"];
    self.pickerView.items = items;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pickerView showOnView:self.view animated:YES];
}

@end
