//
//  ISUPickerView.m
//  JYPickerView
//
//  Created by Justin Yang on 14-7-20.
//  Copyright (c) 2014年 Nanjing University. All rights reserved.
//

#import "ISUPickerView.h"
#import "ISUPickerLabel.h"

#import "UIView+ISUPickerView.h"

@interface ISUPickerView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *labels;

@end

@implementation ISUPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.0f;
        
        self.labels = [NSMutableArray array];
        self.step = 5;
        self.itemFont = [UIFont systemFontOfSize:30.0f];
        self.startItemIndex = 0;
        
        self.titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:22.0f];
        _titleLabel.textColor = [UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f /255.0f alpha:1.0f];
        [self addSubview:_titleLabel];
        
        self.seperatorLineView = [UIView new];
        _seperatorLineView.backgroundColor = [UIColor colorWithRed:204.0f / 255.0f green:204.0f / 255.0f blue:204.0f /255.0f alpha:0.6f];
        _seperatorLineView.width = 290.0f;
        _seperatorLineView.height = 1.0;
        [self addSubview:_seperatorLineView];
        
        self.scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.frame = CGRectMake(0.0f, 0.0f, self.width, 0.0f);
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _scrollView.delegate = self;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        self.circleView = [UIView new];
        _circleView.backgroundColor = [UIColor clearColor];
        _circleView.layer.borderColor = [UIColor colorWithRed:255.0f / 255.0f green:102.f / 255.0f blue:51.0f / 255.0f alpha:1.0f].CGColor;
        _circleView.layer.borderWidth = 1.5;
        [self addSubview:_circleView];
        
        self.itemNameLabel = [UILabel new];
        _itemNameLabel.backgroundColor = [UIColor clearColor];
        _itemNameLabel.font = [UIFont systemFontOfSize:16.0f];
        _itemNameLabel.textColor = [UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f /255.0f alpha:1.0f];
        [self addSubview:_itemNameLabel];
        
        self.cancelButton = [UIButton new];
        _cancelButton.frame = CGRectMake(0.0f, 0.0f, 60.0f, 44.0f);
        UIImage *normal = [UIImage imageNamed:@"NormalButton_U.png"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [_cancelButton setBackgroundImage:normal forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    [_itemNameLabel sizeToFit];

    CGFloat gap = 15.0f;

    _titleLabel.x = (self.width - _titleLabel.width) / 2;
    _titleLabel.y = gap;
    
    _seperatorLineView.x = gap;
    _seperatorLineView.y = _titleLabel.y + _titleLabel.height + gap;
    
    _scrollView.y = _seperatorLineView.y + gap;
    _scrollView.height = _itemSize.height;
    
    CGFloat size = _scrollView.height;
    _circleView.frame = CGRectMake((_scrollView.width - size)/2, _scrollView.y, size, size);
    _circleView.layer.cornerRadius = size / 2;
    
    _itemNameLabel.x = (self.width - _itemNameLabel.width) / 2;
    _itemNameLabel.y = _circleView.y + _circleView.height + 8.0f;
    
    _cancelButton.y = _itemNameLabel.y + _itemNameLabel.height + gap;
    _cancelButton.x = gap;
}

#pragma mark - Properties

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [self refresh];
}

#pragma mark - Public Methods

- (void)refresh
{
    [self p_prepareData];
}

- (void)showOnView:(UIView *)view animated:(BOOL)animated
{
    [self removeFromSuperview];
    
    [view addSubview:self];
    self.y = view.height;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.35 animations:^{
        self.y = view.height - self.height;
        self.alpha = 1.0f;
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat centerOriginX = scrollView.contentOffset.x + scrollView.contentInset.left;
    for (NSUInteger index = 0; index < _labels.count; index++) {
        ISUPickerLabel *label = _labels[index];
        label.normal = YES;
        CGFloat progress = [self p_progressOfTitleWithOriginX:label.x centerOriginX:centerOriginX];
        label.progress = progress;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self p_scrollDidEnd];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self p_scrollDidEnd];
}

#pragma mark - Private Methods

- (void)p_scrollDidEnd
{
    NSInteger currentIndex = [self p_indexOfMiddleTitle];
    CGFloat offsetX = -_scrollView.contentInset.left + _itemSize.width * currentIndex;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (CGFloat)p_progressOfTitleWithOriginX:(CGFloat)originX
                        centerOriginX:(CGFloat)centerOriginX
{
    CGFloat maxDistance = _itemSize.width * _step;
    CGFloat distance = fabs(centerOriginX - originX);
    distance = MIN(maxDistance, distance);
    CGFloat progress = 1.0 - distance / maxDistance;
    return progress;
}

- (NSInteger)p_indexOfMiddleTitle
{
    return MIN(_items.count - 1, abs((_scrollView.contentOffset.x + _scrollView.contentInset.left + _itemSize.width / 2)  / _itemSize.width));
}

- (void)p_prepareData
{
    [_scrollView isu_removeAllSubviews];
    [_labels removeAllObjects];
    
    CGFloat originX = 0;
    ISUPickerLabel *label;
    for (NSString *item in _items) {
        label = [ISUPickerLabel new];
        label.font = _itemFont;
        label.frame = CGRectMake(originX, 0.0f, _itemSize.width, _itemSize.height);
        label.text = item;
        [_scrollView addSubview:label];
        [_labels addObject:label];
        
        originX += _itemSize.width;
    }
    
    _scrollView.contentSize = CGSizeMake(_items.count * _itemSize.width, _itemSize.height);

    CGFloat margin = (self.width - _itemSize.width ) / 2;
    _scrollView.contentInset = UIEdgeInsetsMake(0.0f, margin, 0.0f, margin);
    
    CGFloat startOriginX = _itemSize.width * _startItemIndex - _scrollView.contentInset.left;
    [_scrollView setContentOffset:CGPointMake(startOriginX, 0) animated:NO];
}

@end
