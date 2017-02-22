//
//  ANMessageTextCell.h
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANMessageBaseCell.h"

@interface ANMessageTextCell : ANMessageBaseCell

@property (nonatomic, strong) UITextView *contentLabel;

+ (CGFloat)heightForModel:(ANMessageModel *)messageModel;

@end
