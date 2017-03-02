//
//  ANMessageTextCell.m
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANMessageTextCell.h"
#import "ANConfig.h"

//Label的约束
#define LABEL_BUBBLE_LEFT 12
#define LABEL_BUBBLE_RIGHT 12
#define LABEL_BUBBLE_TOP 18
#define LABEL_BUBBLE_BOTTOM 8

#define CONTENT_MIN_WIDTH  53
#define CONTENT_MIN_HEIGHT 41

#define PREFERRED_MAX_TEXT_WIDTH SIZE_SCREEN_WIDTH * 0.8

@implementation ANMessageTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentLabel = [[UITextView alloc] init];
        self.contentLabel.scrollEnabled = NO;
        self.contentLabel.scrollsToTop = NO;
        self.contentLabel.editable = NO;
        self.contentLabel.selectable = NO;
        self.contentLabel.textContainerInset = UIEdgeInsetsZero;
        self.contentLabel.textContainer.lineFragmentPadding = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:SIZE_DEMO_CHAT_FONT];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}

+ (CGFloat)heightForModel:(ANMessageModel *)messageModel {
    
    CGSize size = [self sizeForLabel:messageModel.attributedText];
    
    CGFloat bubbleHeight = size.height + LABEL_BUBBLE_TOP + LABEL_BUBBLE_BOTTOM;
    if (bubbleHeight < CONTENT_MIN_HEIGHT) {
        bubbleHeight = CONTENT_MIN_HEIGHT;
    }else {
        bubbleHeight = ceil(bubbleHeight);
    }
    
    return bubbleHeight + CONTENT_SUPER_BOTTOM;
}

+ (CGSize)sizeForLabel:(NSAttributedString *)text {
    CGRect frame = [text boundingRectWithSize:CGSizeMake(PREFERRED_MAX_TEXT_WIDTH, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil];
    return frame.size;
}

- (void)layoutMessageContentViews:(BOOL)isFromMuMu {
    
    self.contentLabel.text = self.messageModel.text;
    
    CGSize textSize = [self.class sizeForLabel:self.messageModel.attributedText];
    CGSize size = textSize;
    size.width += LABEL_BUBBLE_LEFT + LABEL_BUBBLE_RIGHT;
    size.height += LABEL_BUBBLE_TOP + LABEL_BUBBLE_BOTTOM;
    if (size.width < CONTENT_MIN_WIDTH) {
        size.width = CONTENT_MIN_WIDTH;
    }else {
        size.width = ceil(size.width);
    }
    
    if (size.height < CONTENT_MIN_HEIGHT) {
        size.height = CONTENT_MIN_HEIGHT;
    }else {
        size.height = ceil(size.height);
    }
    
    if (!isFromMuMu) {
        
        CGRect frame = CGRectMake(SIZE_SCREEN_WIDTH - (size.width + BUBBLE_LEFT_BLANK + BUBBLE_RIGHT_BLANK) - 3,
                                  CONTENT_SUPER_TOP - BUBBLE_TOP_BLANK,
                                  size.width + BUBBLE_LEFT_BLANK + BUBBLE_RIGHT_BLANK,
                                  size.height + BUBBLE_TOP_BLANK + BUBBLE_BOTTOM_BLANK);
        
        self.bubbleImageView.frame = frame;
        
        
        self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.bubbleImageView.frame) + LABEL_BUBBLE_RIGHT + BUBBLE_LEFT_BLANK,
                                             CGRectGetMinY(self.bubbleImageView.frame) + LABEL_BUBBLE_TOP + BUBBLE_TOP_BLANK,
                                             textSize.width,
                                             textSize.height);
        self.contentLabel.textColor = UIColorRGB(159, 159, 159);
        
    }else {
        self.bubbleImageView.frame = CGRectMake(CONTENT_LEFT_MARGIN,
                                                CONTENT_SUPER_TOP - BUBBLE_TOP_BLANK,
                                                size.width + BUBBLE_LEFT_BLANK + BUBBLE_RIGHT_BLANK,
                                                size.height + BUBBLE_TOP_BLANK + BUBBLE_BOTTOM_BLANK);
        
        self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.bubbleImageView.frame) + LABEL_BUBBLE_LEFT + BUBBLE_LEFT_BLANK,
                                             CGRectGetMinY(self.bubbleImageView.frame) + LABEL_BUBBLE_TOP + BUBBLE_TOP_BLANK,
                                             textSize.width,
                                             textSize.height);
        self.contentLabel.textColor = UIColorRGB(45, 45, 45);
    }
    
}

@end
