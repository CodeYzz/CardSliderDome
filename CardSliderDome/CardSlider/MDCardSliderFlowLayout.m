//
//  MDCardSliderFlowLayout.m
//  MeltMedia
//
//  Created by yanzz on 2021/2/22.
//  Copyright © 2021 com.pdmi.MeltMedia. All rights reserved.
//

#import "MDCardSliderFlowLayout.h"

static const int visibleItemsCount = 3;
static const float minScale = 0.9;
static const float spacing = 10;

@interface MDCardSliderFlowLayout()

@property (nonatomic, assign) CGSize topItemSize;
@property (nonatomic, assign) NSInteger itemsCount;
@property (nonatomic, assign) CGSize collectionBounds;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL didInitialSetup;
@property (nonatomic, assign) CGSize collectionViewContentSize;

@end

@implementation MDCardSliderFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat width = self.collectionBounds.width;
    CGFloat height = self.collectionBounds.height - (visibleItemsCount - 1) * spacing;
    self.topItemSize = CGSizeMake(width, height);
    
    if (self.didInitialSetup) {
        return;
    }
    self.didInitialSetup = YES;

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    if (itemsCount <= 0) {
        return nil;
    }
    
    NSInteger minVisibleIndex = MAX(self.currentPage, 0);
    NSInteger contentOffsetY = (int)self.contentOffset.y;
    NSInteger collectionHeight = (int)self.collectionBounds.height;
    CGFloat offset = contentOffsetY % collectionHeight;
    CGFloat offsetProgress = offset / self.collectionBounds.height * 1.0f;
    NSInteger maxVisibleIndex = MAX(MIN(itemsCount - 1, self.currentPage + visibleItemsCount), minVisibleIndex);
        
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i = minVisibleIndex; i <= maxVisibleIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForIndexPath:indexPath currentPage:self.currentPage offset:offset offsetProgress:offsetProgress];
        [mArr addObject:attributes];
    }
    return mArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForIndexPath:(NSIndexPath *)indexPath currentPage:(NSInteger)currentPage offset:(CGFloat)offset offsetProgress:(CGFloat)offsetProgress {
    UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:indexPath] copy];
    NSInteger visibleIndex = MAX(indexPath.item - currentPage + 1, 0);
    attributes.size = self.topItemSize;
    CGFloat topCardMidY = self.contentOffset.y + self.topItemSize.height / 2;
    attributes.center = CGPointMake(self.collectionBounds.width/2, topCardMidY + spacing * (visibleIndex - 1));
    attributes.zIndex = 1000 - visibleIndex;
    CGFloat scale = [self parallaxProgressForVisibleIndex:visibleIndex offsetProgress:offsetProgress minScale:minScale];

    if (scale >= 1.0f) {
        scale = 1.0f;
    }
    if (self.currentPage == indexPath.item) {
        if (offset < 0) {
            attributes.transform = CGAffineTransformMakeScale(scale, scale);
        }
        
        CGFloat alpha = 1.0f - offsetProgress;
        if (offset <= 0) {
            alpha = 1.0f;
        }
        attributes.alpha = alpha;

    } else {
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    switch (visibleIndex) {
        case 1:
        {
            if (self.contentOffset.y >= 0) {
                attributes.center = CGPointMake(attributes.center.x, attributes.center.y - offset);
            }else{
                attributes.center = CGPointMake(attributes.center.x, attributes.center.y + attributes.size.height * (1 - scale)/2 - spacing * offsetProgress);
            }
        }
        break;
        case visibleItemsCount + 1:
        {
            attributes.center = CGPointMake(attributes.center.x, attributes.center.y + attributes.size.height * (1 - scale)/2 - spacing);
        }
        break;
        default:
        {
            attributes.center = CGPointMake(attributes.center.x, attributes.center.y + attributes.size.height * (1 - scale)/2 - spacing * offsetProgress);
        }
        break;
    }
    return attributes;
}

- (CGFloat)parallaxProgressForVisibleIndex:(NSInteger)visibleIndex offsetProgress:(CGFloat)offsetProgress minScale:(CGFloat)minScale {
    
    // 每个item之间缩放大小
    CGFloat step = (1.0 - minScale) / (visibleItemsCount - 1) * 1.0;
    return (1.0 - (visibleIndex - 1) * step + step * offsetProgress);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - Getters
- (NSInteger)itemsCount {
    return [self.collectionView numberOfItemsInSection:0];
}

- (CGSize)collectionBounds {
    return self.collectionView.bounds.size;
}

- (CGPoint)contentOffset {
    return self.collectionView.contentOffset;
}

- (NSInteger)currentPage {
    return MAX(floor(self.contentOffset.y / self.collectionBounds.height), 0);
}


- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionBounds.width, self.collectionBounds.height * self.itemsCount);
}

@end
