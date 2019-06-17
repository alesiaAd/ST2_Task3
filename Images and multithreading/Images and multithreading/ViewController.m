//
//  ViewController.m
//  Images and multithreading
//
//  Created by Alesia Adereyko on 14/06/2019.
//  Copyright © 2019 Alesia Adereyko. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerTableViewCell.h"
#import "DataModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *models;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
                                              ]
     ];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ViewControllerTableViewCell class] forCellReuseIdentifier:@"ViewControllerTableViewCell"];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Url List" ofType:@"plist"];
    NSArray *contentArray = [NSArray arrayWithContentsOfFile:filePath];
    
    self.models = [NSMutableArray new];
    
    UIImage *imageDefault = [UIImage imageNamed:@"noPicture"];
    
    for (NSString *url in contentArray) {
        DataModel *model = [DataModel new];
        model.urlString = url;
        model.status = notLoaded;
        model.image = imageDefault;
        [self.models addObject:model];
    }
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ViewControllerTableViewCell";
    
    ViewControllerTableViewCell *cell = (ViewControllerTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    DataModel *model = (DataModel *) self.models[indexPath.row];
    cell.urlLabel.text = model.urlString;
    cell.imageFromUrlView.image = model.image;
    
    switch (model.status) {
        case notLoaded: {
            model.status = loading;
            [self reloadCell:indexPath];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                NSURL *url = [NSURL URLWithString:model.urlString];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    model.image = image;
                    model.status = loaded;
                }
                else {
                    model.status = error;
                }
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [self reloadCell:indexPath];
                });
            });
            break;
        }
        case loading:
            model.image = [UIImage imageNamed:@"loading"];
            break;
        case loaded:
            break;
        case error:
            model.image = [UIImage imageNamed:@"error"];
            model.status = notLoaded;
            [self reloadCell:indexPath];
            break;
    }
    cell.imageFromUrlView.image = model.image;
    return cell;
}

- (void)reloadCell:(NSIndexPath *)indexPath {
    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
}

@end
