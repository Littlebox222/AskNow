//
//  ANChatInputView.h
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ANChatInputViewDelegate <NSObject>

- (void)sendTextMessage:(NSString *)text;

@end

@interface ANChatInputView : UIView

@property (nonatomic, weak) id<ANChatInputViewDelegate> delegate;

@end
