//
//  MDCardSliderView.m
//  MeltMedia
//
//  Created by yanzz on 2021/2/22.
//  Copyright © 2021 com.pdmi.MeltMedia. All rights reserved.
//

#import "MDCardSliderView.h"
#import "MDCardSliderFlowLayout.h"

@interface MDCardSliderView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation MDCardSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.collectionView];
}

- (void)refresh {
    [self.collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

#pragma mark - Getters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat left = 40;
        CGFloat top = 10;
        CGFloat width = self.frame.size.width -  left * 2;
        CGFloat height = self.frame.size.height - top - 40;
        MDCardSliderFlowLayout *flowLayout = [[MDCardSliderFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(left, top, width, height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;        
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfItemsInCardSliderView:)]) {
        return [self.delegate numberOfItemsInCardSliderView:self];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardSliderView:cellForItemAtIndex:)]) {
        return [self.delegate cardSliderView:self cellForItemAtIndex:indexPath.row];
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardSliderView:didSelectItemAtIndex:)]) {
        return [self.delegate cardSliderView:self didSelectItemAtIndex:indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.selectedIndex = (scrollView.contentOffset.y + 20)/self.collectionView.bounds.size.height;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardSliderViewDidEndScroll:currentIndex:)]) {
        
        [self.delegate cardSliderViewDidEndScroll:self currentIndex:self.selectedIndex];
        
    }

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.selectedIndex = (scrollView.contentOffset.y + 20)/self.collectionView.bounds.size.height;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cardSliderViewDidEndScroll:currentIndex:)]) {
        
        [self.delegate cardSliderViewDidEndScroll:self currentIndex:self.selectedIndex];
        
    }
    
}


@end
