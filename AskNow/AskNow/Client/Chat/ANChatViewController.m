//
//  ANChatViewController.m
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANChatViewController.h"

#import "ANConfig.h"

@interface ANChatViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, assign) BOOL hideStatusBar;

@end

@implementation ANChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"散木问问";
    
    [self.navigationController.navigationBar setBarTintColor: UIColorHexRGB(@"#0099FF")];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_VC_BACKGROUND;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate

//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    [self.navigationController setNavigationBarHidden:velocity.y>0 animated:YES];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
//    
//    CGFloat velocity = [pan velocityInView:scrollView].y;
//    
//    if (velocity < -5) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        self.hideStatusBar = YES;
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }else if (velocity > 5) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        self.hideStatusBar = NO;
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }else if(velocity == 0){
//        
//    }
//}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

@end
