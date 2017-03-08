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
#import "ANChatInputView.h"

@interface ANChatViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, ANChatInputViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ANMessageModel *> *messageList;
@property (nonatomic, strong) ANChatInputView *inputView;

@property (nonatomic, strong) NSArray<NSString *> *answerList;

@end

@implementation ANChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"散木问问";
    
    [self.navigationController.navigationBar setBarTintColor: COLOR_NV_BACKGROUND];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SIZE_NV_TITLE_FONT],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self initMessageData];
    
    CGRect tableViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - SIZE_INPUTVIEW_HEIGHT);
    self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_VC_BACKGROUND;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_tableView];
    
    self.inputView = [[ANChatInputView alloc] initWithFrame:CGRectMake(0, tableViewFrame.size.height, self.view.frame.size.width, SIZE_INPUTVIEW_HEIGHT)];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMessageData {
    
    self.messageList = [[NSMutableArray alloc] init];
    
    self.answerList = [[NSArray alloc] initWithObjects:
                       @"你好，我是木木，请问有什么问题需要解答吗？",
                       @"2009年1月20日，贝拉克·侯赛因·奥巴马正式宣誓就职总统。",
                       @"2008年11月4日，美国各大电视网公布的初步统计结果显示，美国民主党总统候选人、伊利诺伊州国会参议员奥巴马在举行的总统选举中击败共和党对手、亚利桑那州国会参议员麦凯恩，当选第44任（第56届）美国总统已成定局，并成为美国历史上首位非洲裔总统。",
                       @"诺贝尔委员会将诺贝尔和平奖授予贝拉克·侯赛因·奥巴马，以表彰他为加强“国际外交和人民之间合作”所作出的努力。",
                       @"11月15日至18日，奥巴马对中国进行国事访问，他是首位就任一年内访问中国的美国总统。",
                       nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
    [timer fire];
}

- (void)timerFired:(NSTimer *)timer {
    
    ANMessageModel *messageModel = [[ANMessageModel alloc] initWithString:self.answerList[0]];
    messageModel.isFromMuMu = YES;
    [self addModelToDataSourceAndScrollToBottom:messageModel animated:YES];
}

- (void)matchAnswerWithQuestion:(NSString *)question {
    
    if ([question isEqualToString:@"继续..."]) {
        ANMessageModel *messageModel = [[ANMessageModel alloc] initWithString:self.answerList[0]];
        messageModel.isFromMuMu = YES;
        [self addModelToDataSourceAndScrollToBottom:messageModel animated:YES];
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
    return self.messageList.count;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.messageList count] && self.messageList.count != 0) {
        [self matchAnswerWithQuestion:self.messageList.lastObject.text];
    }
}


#pragma mark - TableView 相关方法 -

- (void)addModelToDataSourceAndScrollToBottom:(ANMessageModel *)messageModel animated:(BOOL)animated {
    
    [self.messageList addObject:messageModel];
    
//    if (messageModel.timestamp - [self.dataSource lastObject].timestamp > CHAT_CELL_TIME_INTERVEL) {
//        LLMessageModel *dateModel = [[LLMessageModel alloc] initWithType:kLLMessageBodyTypeDateTime];
//        dateModel.timestamp = messageModel.timestamp;
//        [self.dataSource addObject:dateModel];
//    }
    
    [self.tableView reloadData];
    [self scrollToBottom:animated];
}

//- (void)addModelsInArrayToDataSourceAndScrollToBottom:(NSArray<LLMessageModel *> *)messageModels animated:(BOOL)animated {
//    [self.conversationModel.allMessageModels addObjectsFromArray:messageModels];
//    for (NSInteger i = 0, count = messageModels.count; i < count; i++) {
//        LLMessageModel *messageModel = messageModels[i];
//        
//        if (messageModel.timestamp - [self.dataSource lastObject].timestamp > CHAT_CELL_TIME_INTERVEL) {
//            LLMessageModel *dateModel = [[LLMessageModel alloc] initWithType:kLLMessageBodyTypeDateTime];
//            dateModel.timestamp = messageModel.timestamp;
//            [self.dataSource addObject:dateModel];
//        }
//        
//        [self.dataSource addObject:messageModel];
//    }
//    
//    [self.tableView reloadData];
//    [self scrollToBottom:animated];
//}

- (void)scrollToBottom:(BOOL)animated {
    if (self.messageList.count == 0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageList.count - 1 inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - CGRectGetHeight(self.tableView.frame);
        if (offsetY < -self.tableView.contentInset.top)
            offsetY = -self.tableView.contentInset.top;
        [self.tableView setContentOffset:CGPointMake(0, offsetY) animated:animated];
    }else {
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}


#pragma mark - ANChatInputViewDelegate

- (void)sendTextMessage:(NSString *)text {
    
    ANMessageModel *messageModel = [[ANMessageModel alloc] initWithString:text];
    messageModel.isFromMuMu = (self.messageList.count % 2 == 0);
    [self addModelToDataSourceAndScrollToBottom:messageModel animated:YES];
}

@end
