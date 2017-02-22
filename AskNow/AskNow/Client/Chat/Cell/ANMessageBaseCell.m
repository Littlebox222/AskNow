//
//  ANMessageBaseCell.m
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANMessageBaseCell.h"

#import "ANConfig.h"

@implementation ANMessageBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = COLOR_VC_BACKGROUND;
        
        self.bubbleImageView = [[UIImageView alloc] init];
        self.bubbleImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.bubbleImageView];
    }
    
    return self;
}

- (void)setMessageModel:(ANMessageModel *)messageModel {
    
    _messageModel = messageModel;
    
    if (!messageModel.isFromMuMu) {
        self.bubbleImageView.image = [[UIImage imageNamed:@"user_bubble_bg"] resizableImage];
    }else {
        self.bubbleImageView.image = [[UIImage imageNamed:@"user_bubble_bg"] resizableImage];
    }
    
    [self layoutMessageContentViews:messageModel.isFromMuMu];
}

- (void)layoutMessageContentViews:(BOOL)isFromMuMu {
}

@end
