//
//  ViewController.m
//  APITemplateProject_OC
//
//  Created by casa on 2019/3/18.
//  Copyright © 2019 casa. All rights reserved.
//

#import "ViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <CTNetworking/CTNetworking.h>
#import "__ServiceName__.h"

NSString * kViewControllerCellIdentifier = @"kViewControllerCellIdentifier";
NSString * kViewControllerDataSourceKeyTitle = @"kViewControllerDataSourceKeyTitle";
NSString * kViewControllerDataSourceKeyClass = @"kViewControllerDataSourceKeyClass";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UISegmentedControl *environmentSegment;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.environmentSegment];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView fill];
    
    [self.environmentSegment sizeToFit];
    [self.environmentSegment centerEqualToView:self.navigationController.navigationBar];
    [self.environmentSegment rightInContainer:8 shouldResize:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class viewControllerClass = self.dataSource[indexPath.row][kViewControllerDataSourceKeyClass];
    UIViewController *viewController = [[viewControllerClass alloc] init];
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kViewControllerCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row][kViewControllerDataSourceKeyTitle];
    return cell;
}

#pragma mark - event response
- (void)didChangedEnvironmentSegment:(UISegmentedControl *)segmentControl
{
    id<CTServiceProtocol> service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:kServiceIdentifier__ServiceName__];
    service.apiEnvironment = segmentControl.selectedSegmentIndex;
}

#pragma mark - getters and setters
- (UISegmentedControl *)enviromentSegment
{
    if (_environmentSegment == nil) {
        _environmentSegment = [[UISegmentedControl alloc] initWithItems:@[@"Develop", @"Pre-release", @"Release"]];
        id <CTServiceProtocol> service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:kServiceIdentifier__ServiceName__];
        if (service.apiEnvironment == CTServiceAPIEnvironmentDevelop) {
            [_environmentSegment setSelectedSegmentIndex:0];
        }
        if (service.apiEnvironment == CTServiceAPIEnvironmentReleaseCandidate) {
            [_environmentSegment setSelectedSegmentIndex:1];
        }
        if (service.apiEnvironment == CTServiceAPIEnvironmentRelease) {
            [_environmentSegment setSelectedSegmentIndex:2];
        }
        [_environmentSegment addTarget:self action:@selector(didChangedEnvironmentSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _environmentSegment;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kViewControllerCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
//                            kViewControllerDataSourceKeyTitle:@"CharacterAPI",
//                            kViewControllerDataSourceKeyClass:[CharacterAPIViewController class]
                            },
                        ];
    }
    return _dataSource;
}


@end
