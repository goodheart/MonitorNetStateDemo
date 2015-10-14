//
//  ViewController.m
//  MonitorNetStateDemo
//
//  Created by majian on 15/10/14.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "ViewController.h"
#import "PMNetMonitor.h"
@interface ViewController ()
@property (nonatomic,strong) PMNetMonitor * netMonitor;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.netMonitor = [[PMNetMonitor alloc] init];
    [self.netMonitor startMonitor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netState:)
                                                 name:PMNetMonitorNetStateNotification
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                              forKeyPath:PMNetMonitorNetStateNotification];
}

- (void)netState:(NSNotification *)state {
    NSLog(@"%ld",[state.object integerValue]);
}

@end
