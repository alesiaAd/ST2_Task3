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
    
    for (NSString *url in contentArray) {
        DataModel *model = [DataModel new];
        model.urlString = url;
        model.status = notLoaded;
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
    
    return cell;
}

@end
