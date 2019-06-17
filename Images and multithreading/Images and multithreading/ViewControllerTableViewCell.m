//
//  ViewControllerTableViewCell.m
//  Images and multithreading
//
//  Created by Alesia Adereyko on 17/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ViewControllerTableViewCell.h"

static const CGFloat cImageHeight = 100;
static const CGFloat cImageWidth = 200;
static const CGFloat cItemsSpacing = 20;

@implementation ViewControllerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageFromUrlView = [UIImageView new];
        [self addSubview:self.imageFromUrlView];
        self.imageFromUrlView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.imageFromUrlView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:cItemsSpacing],
                                                  [self.imageFromUrlView.heightAnchor constraintEqualToConstant:cImageHeight],
                                                  [self.imageFromUrlView.widthAnchor constraintEqualToConstant:cImageWidth],
                                                  [self.imageFromUrlView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                                  ]
         ];
        
        self.urlLabel = [UILabel new];
        self.urlLabel.numberOfLines = 0;
        [self addSubview:self.urlLabel];
        self.urlLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.urlLabel.leadingAnchor constraintEqualToAnchor:self.imageFromUrlView.trailingAnchor constant:cItemsSpacing],
                                                  [self.urlLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-cItemsSpacing],
                                                  [self.urlLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:cItemsSpacing],
                                                  [self.urlLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-cItemsSpacing]
                                                  ]
         ];
    }
    return self;
}

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    CGFloat minCellHeight = cImageHeight + 2 * cItemsSpacing;
    if (size.height < minCellHeight) {
        size = CGSizeMake(size.width, minCellHeight);
    }
    return size;
}

@end
