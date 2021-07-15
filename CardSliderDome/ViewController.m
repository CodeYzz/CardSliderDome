//
//  ViewController.m
//  CardSliderDome
//
//  Created by  张礼栋 on 2019/12/10.
//  Copyright © 2019 mobile. All rights reserved.
//

#import "ViewController.h"
#import "MDCardSliderView.h"
#import "MDCardSliderCell.h"

@interface ViewController ()<MDCardSliderViewDelegate>

@property (nonatomic, strong) MDCardSliderView *card;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataSource = @[
    [UIImage imageNamed:@"01"],
    [UIImage imageNamed:@"02"],
    [UIImage imageNamed:@"03"],
    [UIImage imageNamed:@"04"],
    [UIImage imageNamed:@"05"]];

    CGFloat left = 0;
    CGFloat top = 100;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - top - 200;
    self.card = [[MDCardSliderView alloc] initWithFrame:CGRectMake(left, top, width, height)];
    self.card.delegate = self;
    [self.card registerClass:[MDCardSliderCell class] forCellWithReuseIdentifier:NSStringFromClass([MDCardSliderCell class])];

    [self.view addSubview:self.card];
    [self.dataArr addObjectsFromArray:dataSource];
    [self.card refresh];

    
    
}

#pragma mark - Getters
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - MDCardSliderViewDelegate
- (NSInteger)numberOfItemsInCardSliderView:(MDCardSliderView *)cardSliderView {
    return self.dataArr.count + 1;
}

- (UICollectionViewCell *)cardSliderView:(MDCardSliderView *)cardSliderView cellForItemAtIndex:(NSInteger)index {
    
    MDCardSliderCell *cell = [cardSliderView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MDCardSliderCell class]) forIndex:index];
    if (index < self.dataArr.count) {
        cell.data = self.dataArr[index];
    } else {
        cell.data = nil;
    }
    return cell;
    
}

- (void)cardSliderView:(MDCardSliderView *)cardSliderView didSelectItemAtIndex:(NSInteger)index  {
    
}

- (void)cardSliderViewDidEndScroll:(MDCardSliderView *)cardSliderView currentIndex:(NSInteger)currentIndex {
    
    
    
}



@end
