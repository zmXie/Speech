//
//  ViewController.m
//  Speech
//
//  Created by CHT-Technology on 2017/12/11.
//  Copyright © 2017年 CHT-Technology. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
    
    [self speakString:@"床前明月光，\n疑似地上霜，\n举头望明月，\n低头思故乡。"];
}

- (BOOL)isSpeaking
{
    return self.speechSynthesizer.isSpeaking;
}

- (void)stopSpeak
{
    if (self.speechSynthesizer)
    {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

- (void)speakString:(NSString *)string
{
    if (self.speechSynthesizer)
    {
        //设置播放语音的内容
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        //设置播放的语言
        [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        
        //iOS语音合成在iOS8及以下版本系统上语速异常
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
        {
            aUtterance.rate = 0.25;//iOS7设置为0.25
        }
        else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
        {
            aUtterance.rate = 0.15;//iOS8设置为0.15
        }
        
        if ([self.speechSynthesizer isSpeaking])
        {
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        
        //开始播放语音
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}


@end
