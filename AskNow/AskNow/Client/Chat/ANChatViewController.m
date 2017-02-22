//
//  ANChatViewController.m
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANChatViewController.h"

#import "ANConfig.h"
#import "ANMessageTextCell.h"

#define DEMO_DATA_COUNT 100

@interface ANChatViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ANMessageModel *> *messageList;

@end

@implementation ANChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"散木问问";
    
    [self.navigationController.navigationBar setBarTintColor: UIColorHexRGB(@"#0099FF")];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self initDemoData];
    
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

- (void)initDemoData {
    
    self.messageList = [[NSMutableArray alloc] init];
    
    NSString *text = @"";
    
    for (int i=0; i<DEMO_DATA_COUNT; i++) {
        
        if (i == 2) {
            text = @"2008年11月4日，美国各大电视网公布的初步统计结果显示，美国民主党总统候选人、伊利诺伊州国会参议员奥巴马在举行的总统选举中击败共和党对手、亚利桑那州国会参议员麦凯恩，当选第44任（第56届）美国总统已成定局，并成为美国历史上首位非洲裔总统。";
        }else if (i == 4){
            text = @"2009年1月20日，贝拉克·侯赛因·奥巴马正式宣誓就职总统，诺贝尔委员会将诺贝尔和平奖授予贝拉克·侯赛因·奥巴马，以表彰他为加强“国际外交和人民之间合作”所作出的努力；11月15日至18日，奥巴马对中国进行国事访问，他是首位就任一年内访问中国的美国总统。";
        }else {
            text = [NSString stringWithFormat:@"%d", i];
        }
        
        ANMessageModel *messageModel = [[ANMessageModel alloc] initWithString:text];
        messageModel.isFromMuMu = (i % 2 == 0);
        [self.messageList addObject:messageModel];
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ANMessageTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[ANMessageTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ANMessageModel *messageModel = [self.messageList objectAtIndex:indexPath.row];
    [cell setMessageModel:messageModel];
    
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ANMessageModel *messageModel = [self.messageList objectAtIndex:indexPath.row];
    return messageModel.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DEMO_DATA_COUNT;
}

@end
