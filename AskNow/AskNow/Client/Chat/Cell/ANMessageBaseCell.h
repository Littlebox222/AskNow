//
//  ANMessageBaseCell.h
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANMessageModel.h"

//Bubble上下左右的空白量
#define BUBBLE_LEFT_BLANK 7
#define BUBBLE_RIGHT_BLANK 7
#define BUBBLE_TOP_BLANK 2
#define BUBBLE_BOTTOM_BLANK 11

//Bubble的约束
#define CONTENT_LEFT_MARGIN 3
#define CONTENT_SUPER_BOTTOM 20
#define CONTENT_SUPER_TOP 10

@interface ANMessageBaseCell : UITableViewCell

@property (nonatomic, strong) ANMessageModel *messageModel;

@property (nonatomic, strong) UIImageView *bubbleImageView;

- (void)layoutMessageContentViews:(BOOL)isFromMuMu;

@end
