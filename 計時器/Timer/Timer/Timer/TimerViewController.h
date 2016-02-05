//
//  TimerViewController.h
//  Timer
//
//  Created by Mac on 2014/7/8.
//  Copyright (c) 2014年 Timer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

// MediaPlayer 媒體播放器.
@interface TimerViewController : UIViewController <MPMediaPickerControllerDelegate,UIApplicationDelegate>
// MPMediaPickerControllerDelegate 媒體選擇控制代表.

@property (weak, nonatomic) IBOutlet UIDatePicker *view1DataPickerSetReciprocalTime; // view1DataPickerSetReciprocalTime.
- (IBAction)ButtonBegin:(UIButton *)sender; // ButtonBegin.

- (IBAction)ButtonStop:(UIButton *)sender; // ButtonStop.
- (IBAction)ScreenOnOrOff:(UIButton *)sender; // ScreenOnOrOff.
- (IBAction)ButtonPlayMusic:(UIButton *)sender; // ButtonPlayMusic.
@property (weak, nonatomic) IBOutlet UILabel *view1LabelReciprocalSeconds; // view1LabelReciprocalSeconds.
@property (weak, nonatomic) IBOutlet UILabel *view1LabelShowTime; // view1LabelShowTime 圈圈.
@property (weak, nonatomic) IBOutlet UILabel *view1LabelTime; // view1LabelTime.
@property (weak, nonatomic) IBOutlet UIButton *ButtonBegin; // ButtonBegin.
@property (weak, nonatomic) IBOutlet UIButton *ButtonStop; // ButtonStop.
@property (weak, nonatomic) IBOutlet UIButton *ButtonPlayMusic; // ButtonPlayMusic.
-(void)countDownTimer; // 倒數計時.
-(void)changeUIViewExteriorFrontMode2:(UIView *)sender TitleColor:(UIColor*) titleColor BorderColor:(UIColor*) bordeColor BackColor:(UIColor*) backColor OnOrOff:(BOOL)YesNo; // 改變視圖外觀前置作業.
-(void)animationCircle; // 放大圈圈.

@end
