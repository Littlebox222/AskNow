//
//  ANMainViewController.m
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANMainViewController.h"

#import "ANChatViewController.h"

@interface ANMainViewController ()

@property (nonatomic, strong) ANChatViewController *chatViewController;

@end

@implementation ANMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatViewController = [[ANChatViewController alloc] init];
    [self setViewControllers:@[_chatViewController]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
