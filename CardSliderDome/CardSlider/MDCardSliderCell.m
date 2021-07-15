//
//  MDCardSliderCell.m
//  MeltMedia
//
//  Created by yanzz on 2021/2/22.
//  Copyright © 2021 com.pdmi.MeltMedia. All rights reserved.
//

#import "MDCardSliderCell.h"
#import <Masonry/Masonry.h>

@interface MDCardSliderCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MDCardSliderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.layer.shadowOffset = CGSizeMake(0, 3);
//        self.contentView.layer.shadowRadius = 12;
//        self.contentView.layer.shadowOpacity = 0.2;
        [self initView];
    }
    return self;
}



- (void)initView {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2, 0, 0, 0));
    }];
}

#pragma mark - Getters
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.masksToBounds = YES;
        _imageView.backgroundColor = [UIColor blueColor];
    }
    return _imageView;
}

#pragma mark -  Setters
- (void)setData:(id)data {
    self.imageView.image = data;
}

@end
