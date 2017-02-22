//
//  ANViewController.m
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANViewController.h"

#import "ANConfig.h"

@interface ANViewController ()

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = COLOR_VC_BACKGROUND;
    
    if ([self performSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
