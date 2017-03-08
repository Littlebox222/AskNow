//
//  ANConfig.h
//  AskNow
//
//  Created by Little Box on 21/02/2017.
//  Copyright © 2017 PandaLearn. All rights reserved.
//

#ifndef ANConfig_h
#define ANConfig_h

#define COLOR_VC_BACKGROUND UIColorRGBA(245,245,245,1)
#define COLOR_NV_BACKGROUND UIColorHexRGB(@"#0099FF")
#define COLOR_INPUTVIEW_BACKGROUND UIColorHexRGB(@"#0000FF")

#define SIZE_DEMO_CHAT_FONT 16.0f
#define SIZE_NV_TITLE_FONT 18.0f

#define SIZE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SIZE_INPUTVIEW_HEIGHT 60

#define DEMO_DATA_COUNT 100

#define kIFlyAppId @"58aa983a"



#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])



#endif /* ANConfig_h */


#import "UIColor+ANExt.h"
#import "UIImage+ANExt.h"

#import "ISRDataHelper.h"
#import "SCSiriWaveformView.h"

#import "iflyMSC/IFlyMSC.h"
