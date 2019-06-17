//
//  ViewControllerTableViewCell.m
//  Images and multithreading
//
//  Created by Alesia Adereyko on 17/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ViewControllerTableViewCell.h"

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
            [self.imageFromUrlView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
            [self.imageFromUrlView.heightAnchor constraintEqualToConstant:100],
            [self.imageFromUrlView.widthAnchor constraintEqualToConstant:200],
            [self.imageFromUrlView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
//            [self.imageFromUrlView.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
//            [self.imageFromUrlView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20]
            ]
         ];
        
        self.urlLabel = [UILabel new];
        self.urlLabel.numberOfLines = 0;
        [self addSubview:self.urlLabel];
        self.urlLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
            [self.urlLabel.leadingAnchor constraintEqualToAnchor:self.imageFromUrlView.trailingAnchor constant:20],
            [self.urlLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
            //[self.urlLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [self.urlLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:20],
            [self.urlLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20]
            ]
        ];
    }
    return self;
}

@end
