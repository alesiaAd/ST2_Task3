//
//  ImageViewController.m
//  Images and multithreading
//
//  Created by Alesia Adereyko on 17/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ImageViewController.h"

static const CGFloat cItemsSpacing = 20;

@interface ImageViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Details";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                         initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(changeImage:) name:@"ImageLoadedNotification" object:nil];
    
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    [self setUpImageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)changeImage:(NSNotification *) notification {
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self setUpImageView];
    });
}

- (void)setUpImageView {
    self.imageView.image = self.model.image;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:cItemsSpacing],
        [self.imageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:cItemsSpacing],
        [self.imageView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-cItemsSpacing],
        [self.imageView.bottomAnchor constraintLessThanOrEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-cItemsSpacing]
                                              ]
     ];
}

@end
