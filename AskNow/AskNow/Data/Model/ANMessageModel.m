//
//  ANMessageModel.m
//  AskNow
//
//  Created by Little Box on 23/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANMessageModel.h"

#import "ANMessageTextCell.h"

@implementation ANMessageModel

- (instancetype)initWithString:(NSString *)string {
    
    self = [super init];
    
    if (self) {
        
        self.text = string;
        
        NSDictionary *ats = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                              };
        
        self.attributedText = [[NSMutableAttributedString alloc] initWithString:string attributes:ats];
        
        [self processModelForCell];
    }
    
    return self;
}

- (void)processModelForCell {
    
    self.cellHeight = [ANMessageTextCell heightForModel:self];
}

@end
