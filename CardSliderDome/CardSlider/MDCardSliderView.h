//
//  MDCardSliderView.h
//  MeltMedia
//
//  Created by yanzz on 2021/2/22.
//  Copyright © 2021 com.pdmi.MeltMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDCardSliderView;

NS_ASSUME_NONNULL_BEGIN

@protocol MDCardSliderViewDelegate <NSObject>

@optional
- (void)cardSliderViewDidEndScroll:(MDCardSliderView *)cardSliderView currentIndex:(NSInteger)currentIndex;
- (void)cardSliderView:(MDCardSliderView *)cardSliderView didSelectItemAtIndex:(NSInteger)index;


@required
- (NSInteger)numberOfItemsInCardSliderView:(MDCardSliderView *)cardSliderView;
- (UICollectionViewCell *)cardSliderView:(MDCardSliderView *)cardSliderView cellForItemAtIndex:(NSInteger)index;

@end



@interface MDCardSliderView : UIView

@property (nonatomic, weak) id<MDCardSliderViewDelegate> delegate;

- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

- (void)refresh;

@end

NS_ASSUME_NONNULL_END
