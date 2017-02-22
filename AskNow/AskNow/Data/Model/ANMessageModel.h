//
//  ANMessageModel.h
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANMessageModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableAttributedString *attributedText;
@property (nonatomic, assign) BOOL isFromMuMu;

@property (nonatomic, assign) CGFloat cellHeight;


- (instancetype)initWithString:(NSString *)string;

@end
