//
//  ViewController.m
//  EBTCirCleProgressViewDemo
//
//  Created by MJ on 15/7/9.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "ViewController.h"
#import "EBTCircleProgressView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet EBTCircleProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressView.progress = 0.75;
    _progressView.progressStokeColor = [UIColor redColor];
    _progressView.progressStorkeWidth = 2.f;
    _progressView.progressTrackStokeColor = [UIColor grayColor];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
