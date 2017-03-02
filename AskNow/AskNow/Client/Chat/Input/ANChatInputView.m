//
//  ANChatInputView.m
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#import "ANChatInputView.h"

#import "ANConfig.h"
#import "iflyMSC/IFlyMSC.h"

#define WEAK_SELF __weak typeof(self) weakSelf = self

@interface ANChatInputView () <IFlySpeechRecognizerDelegate>

@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) NSString *voiceString;
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) SCSiriWaveformView *waveformView;

@end

@implementation ANChatInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = COLOR_VC_BACKGROUND;

        
        self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, SIZE_INPUTVIEW_HEIGHT, SIZE_INPUTVIEW_HEIGHT)];
        [self.voiceButton addTarget:self action:@selector(voiceButtonTouchDown) forControlEvents:UIControlEventTouchDown];
        [self.voiceButton addTarget:self action:@selector(voiceButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self.voiceButton addTarget:self action:@selector(voiceButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [self.voiceButton setImage:[UIImage imageNamed:@"icon_voice_button_normal"] forState:UIControlStateNormal];
        [self.voiceButton setImage:[UIImage imageNamed:@"icon_voice_button_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:_voiceButton];
        
        self.waveformView = [[SCSiriWaveformView alloc] initWithFrame:CGRectMake(_voiceButton.frame.origin.x+_voiceButton.frame.size.width+5, 0,
                                                                                 SIZE_SCREEN_WIDTH - (_voiceButton.frame.origin.x+_voiceButton.frame.size.width+5) - 5,
                                                                                 SIZE_INPUTVIEW_HEIGHT)];
        [self.waveformView setWaveColor:COLOR_NV_BACKGROUND];
        [self.waveformView setPrimaryWaveLineWidth:2.0f];
        [self.waveformView setSecondaryWaveLineWidth:0.6];
        [self.waveformView setBackgroundColor:COLOR_VC_BACKGROUND];
        [self.waveformView updateWithLevel:0];
        [self addSubview:self.waveformView];
//        [self.waveformView setHidden:YES];
        self.waveformView.alpha = 0.0f;
        
        
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance]; //设置识别参数
        [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        _iFlySpeechRecognizer.delegate = self;
        
        self.voiceString = @"";
    }
    
    return self;
}

- (void)voiceButtonTouchDown {
    NSLog(@"voiceButtonTouchDown");
    
    [_iFlySpeechRecognizer cancel];
    self.voiceString = @"";
    
//    [_iFlySpeechRecognizer startListening];
    
//    [self.waveformView setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    self.waveformView.alpha = 1.0f;
    [UIView commitAnimations];
}

- (void)voiceButtonTouchUpInside {
    NSLog(@"voiceButtonTouchUpInside");
    
    [_iFlySpeechRecognizer stopListening];
    
    [self.waveformView updateWithLevel:0];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    self.waveformView.alpha = 0.0f;
    [UIView commitAnimations];
//    [self.waveformView setHidden:YES];
}

- (void)voiceButtonTouchUpOutside {
    NSLog(@"voiceButtonTouchUpOutside");
    [_iFlySpeechRecognizer cancel];
    [self.waveformView updateWithLevel:0];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    self.waveformView.alpha = 0.0f;
    [UIView commitAnimations];
//    [self.waveformView setHidden:YES];
}


#pragma mark - IFlySpeechRecognizerDelegate

- (void)onResults:(NSArray *) results isLast:(BOOL)isLast {
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString *resultFromJson = [ISRDataHelper stringFromJson:resultString];
    
    self.voiceString = [NSString stringWithFormat:@"%@%@", self.voiceString, resultFromJson];
    
    if (isLast) {
        
        NSLog(@"\n\n\n\n\n");
        NSLog(@"听写结果：%@", self.voiceString);
        NSLog(@"\n\n\n\n\n");
        
        if (self.voiceString.length>0) {
            
        }else{
            NSLog(@"未检测到");
        }
        
    }
}

- (void)onError: (IFlySpeechError *)error {
    NSLog(@"%@", error);
}

- (void)onEndOfSpeech {
    NSLog(@"onEndOfSpeech");
}

- (void)onBeginOfSpeech {
    NSLog(@"onBeginOfSpeech");
}

- (void)onVolumeChanged:(int)volume {
    [self.waveformView updateWithLevel:[self normalizedPowerLevelFromDecibels:volume/30.0]];
}

- (CGFloat)normalizedPowerLevelFromDecibels:(CGFloat)decibels {
    
    if (decibels < -60.0f || decibels == 0.0f) {
        return 0.0f;
    }
    
    return powf((powf(10.0f, 0.05f * decibels) - powf(10.0f, 0.05f * -60.0f)) * (1.0f / (1.0f - powf(10.0f, 0.05f * -60.0f))), 1.0f / 2.0f);
}


- (void)onCancel{
}

@end
