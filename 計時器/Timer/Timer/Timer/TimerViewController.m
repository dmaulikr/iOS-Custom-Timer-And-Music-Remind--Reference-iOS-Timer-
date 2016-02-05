//
//  TimerViewController.m
//  Timer
//
//  Created by Mac on 2014/7/8.
//  Copyright (c) 2014年 Timer. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
{
    NSTimer *datePickerTimer;  // 計時.
    NSTimeInterval timesecond; // 儲存總時間.
    int frequency; // 圈圈放大次數.
    float circleside; // 圈圈放大的尺寸.
    CGRect circlefram; // 記住大小.
    BOOL screenOnOff; // 螢幕開啟或關閉.
    BOOL playMusic; // 播放音樂.
    MPMediaPickerController *mediaPicker; //多媒體選擇控制.
    MPMusicPlayerController *musicPlayer; // 音樂選擇控制.
    UILabel *labeltime;
}
@end
@implementation TimerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self changeUIViewExteriorFrontMode2:self.ButtonBegin TitleColor:[UIColor greenColor] BorderColor:[UIColor greenColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
    [self changeUIViewExteriorFrontMode2:self.ButtonStop TitleColor:nil BorderColor:[UIColor grayColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
    [self changeUIViewExteriorFrontMode2:self.view1LabelShowTime TitleColor:[UIColor blueColor] BorderColor:[UIColor blackColor] BackColor:[UIColor groupTableViewBackgroundColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
    [self changeUIViewExteriorFrontMode2:self.ButtonPlayMusic TitleColor:[UIColor yellowColor] BorderColor:[UIColor yellowColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
    self.ButtonStop.enabled=NO; // 按鈕狀態設置.
    self.view1LabelShowTime.text=@"";
    self.view1LabelTime.text=@"";
    self.view1DataPickerSetReciprocalTime.hidden=NO; // 顯示時間選擇器.
    self.view1LabelShowTime.hidden=NO; // 顯示秒數標籤.
    self.view1DataPickerSetReciprocalTime.backgroundColor=[UIColor groupTableViewBackgroundColor]; // 時間選擇器背景顏色.
    self.view1LabelShowTime.backgroundColor=[UIColor groupTableViewBackgroundColor]; // 顯示計數秒數的標籤背景顏色.
    self.ButtonBegin.titleLabel.numberOfLines = 2;
    self.ButtonBegin.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.ButtonStop.titleLabel.numberOfLines = 2;
    self.ButtonStop.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.ButtonPlayMusic.titleLabel.numberOfLines = 2;
    self.ButtonPlayMusic.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.ButtonBegin setTitle:[NSString stringWithFormat:@"開始\nStart"] forState:UIControlStateNormal];
    [self.ButtonStop setTitle:[NSString stringWithFormat:@"暫停\nStop"] forState:UIControlStateNormal];
    [self.ButtonPlayMusic setTitle:[NSString stringWithFormat:@"提醒\nRemind"] forState:UIControlStateNormal];
    
    circlefram=self.view1LabelShowTime.frame; // 記住大小.
    self.view1LabelTime.layer.cornerRadius=circlefram.size.height/2; //學整顯示時間弧度標籤.
    circlefram=self.view1LabelShowTime.frame;
    mediaPicker=[[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeAnyAudio]; //多媒體選擇控制,初始化並分配記憶體.
    mediaPicker.delegate=self; // 代理人設為自己,注意自己是否有匯入多媒體控制代理.
    mediaPicker.allowsPickingMultipleItems=NO; // 設定只能單選一首.
    circleside=15; // 放大圈圈的大小尺寸.
    labeltime=[[UILabel alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(BOOL)prefersStatusBarHidden{  // 隱藏Status Bar.
    return YES;
}
-(void)countDownTimer
{ // 倒數計時.
    if (timesecond<0) {
        [datePickerTimer invalidate]; // 計時停止.
        if (playMusic) { // 播放提醒.
            [musicPlayer play]; // 播放音樂.
        }
        self.ButtonStop.enabled=NO; // 關閉暫停按鈕.
        [self changeUIViewExteriorFrontMode2:self.ButtonStop TitleColor:nil BorderColor:[UIColor grayColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
        self.view1LabelTime.text=[NSString stringWithFormat:@"Time Now!"];
    }
    else{
        int h,m,s;
        h=timesecond/3600;
        m=(timesecond-(h*3600))/60;
        s=(timesecond-(h*3600))-m*60;
        timesecond--; // 隨著時間倒數.
        self.view1DataPickerSetReciprocalTime.countDownDuration=timesecond; // 日期選擇器內容更新.
        if (h<1) { //判斷時間是否大於1小時.
            self.view1LabelTime.text=[NSString stringWithFormat:@"%02d:%02d",m,s];
        }
        else if (h<10) { //判斷時間是否大於10小時.{
            self.view1LabelTime.text=[NSString stringWithFormat:@"%d:%02d:%02d",h,m,s];
        }
        else{
            self.view1LabelTime.text=[NSString stringWithFormat:@"%2d:%02d:%02d",h,m,s];
        }
        
    }
    [UIView animateWithDuration:0.7 animations:^{
        //self.view1LabelShowTime.frame=labeltime.frame;
        self.view1LabelShowTime.transform = CGAffineTransformMakeScale(1.12, 1.12);   // 放大圈圈.
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            if(finished){
                self.view1LabelShowTime.transform = CGAffineTransformIdentity;  // 還原圈圈大小.
            }
        }];
    }];
}
- (IBAction)ButtonBegin:(UIButton *)sender { // ButtonBegin.
    if(sender.tag){ // 開始計數.
        self.view1LabelTime.text=@"Go~";
        [datePickerTimer invalidate]; // 廢除計時.
        datePickerTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES]; // 啟動計時功能.
        timesecond=self.view1DataPickerSetReciprocalTime.countDownDuration; // 取得總時間秒數.       
        [sender setTitle:[NSString stringWithFormat:@"完成\nComplete"] forState:UIControlStateNormal];
        self.view1DataPickerSetReciprocalTime.hidden=YES; // 隱藏時間選擇器.
        self.view1LabelShowTime.hidden=NO; // 顯示秒數標籤.
        sender.tag=0; // 設定標籤參數,目前已在計數.
        self.ButtonStop.enabled=YES; // 按鈕狀態設置,繼續鈕啟動.
         [self changeUIViewExteriorFrontMode2:self.ButtonBegin TitleColor:[UIColor redColor] BorderColor:[UIColor redColor] BackColor:[UIColor lightGrayColor] OnOrOff:NO]; // 改變視圖外觀前置作業.
        [self changeUIViewExteriorFrontMode2:self.ButtonStop TitleColor:nil BorderColor:nil BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
    }
    else{ // 完成計數.
        [datePickerTimer invalidate]; // 廢除計時.
        [musicPlayer stop]; // 停止音樂.
        [UIView animateWithDuration:0.7 animations:^{
            //self.view1LabelShowTime.frame=circlefram; // 還原大小.
            self.view1LabelShowTime.transform = CGAffineTransformIdentity;
        }];
        self.view1LabelShowTime.layer.cornerRadius=circlefram.size.height/2; // 調整弧度.
        [[self.view1LabelShowTime layer]setBorderColor:[UIColor blackColor].CGColor]; // 設定邊框顏色.
        frequency=0; // 放大次數重新開始.        
        [sender setTitle:[NSString stringWithFormat:@"開始\nStart"] forState:UIControlStateNormal];
        self.view1DataPickerSetReciprocalTime.hidden=NO; // 顯示時間選擇器.
        self.view1LabelTime
        .text=@""; // 秒數標籤的內容清除.
        sender.tag=1; // 設定標籤參數,目前準備開始.
        self.ButtonStop.enabled=NO; // 按鈕狀態設置,繼續鈕關閉.
        [self changeUIViewExteriorFrontMode2:self.ButtonBegin TitleColor:[UIColor greenColor] BorderColor:[UIColor greenColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
        [self changeUIViewExteriorFrontMode2:self.ButtonStop TitleColor:nil BorderColor:[UIColor grayColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
        self.ButtonStop.tag=1; // 設定標籤參數,目前準備暫停.
        [self.ButtonStop setTitle:[NSString stringWithFormat:@"暫停\nStop"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)ButtonStop:(UIButton *)sender { // ButtonStop.
    if(sender.tag){ // 按下暫停.
        [datePickerTimer invalidate]; // 廢除計時.
        [sender setTitle:[NSString stringWithFormat:@"繼續\nContinue"] forState:UIControlStateNormal];
        sender.tag=0; // 設定標籤參數,目前已在暫停.
        [self changeUIViewExteriorFrontMode2:self.ButtonStop TitleColor:[UIColor blueColor] BorderColor:[UIColor blueColor] BackColor:[UIColor whiteColor] OnOrOff:NO]; // 改變視圖外觀前置作業.
        
    }
    else{// 按下繼續.
        [datePickerTimer invalidate]; // 廢除計時.
        datePickerTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES]; // 啟動計時功能.
        [sender setTitle:[NSString stringWithFormat:@"暫停\nStop"] forState:UIControlStateNormal];
        sender.tag=1; // 設定標籤參數,目前已在繼續.
        [self changeUIViewExteriorFrontMode2:self.ButtonStop TitleColor:nil BorderColor:nil BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
    }
}
-(void)changeUIViewExteriorFrontMode2:(UIView *)sender TitleColor:(UIColor*) titleColor BorderColor:(UIColor*) bordeColor BackColor:(UIColor*) backColor OnOrOff:(BOOL)YesNo
{ // 改變視圖外觀前置作業.
    
    float side=100.0; // 先預設一個值.
    CGRect viewdelegate=sender.frame; // 取得此按鈕的位置.
    if (sender.frame.size.width>=sender.frame.size.height) { // 比較長和寬何者最大,便設定成此數值.
        side=sender.frame.size.width; // 取得此原件的大小.
    }
    else{
        side=sender.frame.size.height; // 取得此原件的大小.
    }
    viewdelegate.size=CGSizeMake(side, side); // 設定邊長必須相同,為了改成圓形.
    sender.frame=viewdelegate; // 改變此按鈕的大小尺寸.
    sender.layer.cornerRadius=sender.frame.size.width/2;// 設定按鈕角度 用邊長的一半.
    if (titleColor==nil) {
        titleColor=[UIColor blackColor]; // 先預設一個字型顏色.
    }
    if (bordeColor==nil) {
        bordeColor=[UIColor blackColor]; // 先預設一個邊框顏色.
    }
    if (backColor==nil) {
        backColor=[UIColor blackColor]; // 先預設一個背景顏色.
    }
    [UIView animateWithDuration:0.4 animations:^{
        [sender setTintColor:titleColor]; // 設定視圖字型顏色.
        sender.backgroundColor=backColor; // 設定視圖背景顏色.
        [[sender layer]setBorderColor:bordeColor.CGColor]; // 設定邊框顏色.
        if(YesNo){
            sender.layer.borderWidth=side/50;// 設定按鈕邊框粗細.
            sender.alpha=1; // 設定按鈕的顏色明亮度.
        }
        else{
            sender.layer.borderWidth=side/20;// 設定按鈕編框粗細.
            sender.alpha=0.7; // 設定按鈕的顏色明亮度.
        }
        sender.layer.masksToBounds=YES;// 超超邊框的部分做遮罩.
        }
        completion:^(BOOL finished){
        }];
}
-(void)animationCircle
{ // 放大圈圈.
    self.view1LabelShowTime.frame=circlefram; // 還原大小.
    self.view1LabelShowTime.layer.cornerRadius=self.view1LabelShowTime.frame.size.width/2;
    [[self.view1LabelShowTime layer]setBorderColor:[UIColor blackColor].CGColor];
    [labeltime setFrame:CGRectMake(self.view1LabelShowTime.frame.origin.x-circleside, self.view1LabelShowTime.frame.origin.y-circleside, self.view1LabelShowTime.frame.size.height+2*circleside, self.view1LabelShowTime.frame.size.width+2*circleside)];
    labeltime.layer.cornerRadius=self.view1LabelShowTime.frame.size.width/2;
    [UIView animateWithDuration:0.5 animations:^{
        self.view1LabelShowTime.frame=labeltime.frame;
        
    } completion:^(BOOL finished){
        circleside=-circleside;
        [labeltime setFrame:CGRectMake(self.view1LabelShowTime.frame.origin.x-circleside, self.view1LabelShowTime.frame.origin.y-circleside, self.view1LabelShowTime.frame.size.height+2*circleside, self.view1LabelShowTime.frame.size.width+2*circleside)];
        [UIView animateWithDuration:0.3 animations:^{
            if(finished){
                self.view1LabelShowTime.frame=labeltime.frame;
            }
        }];
        self.view1LabelShowTime.layer.cornerRadius=self.view1LabelShowTime.frame.size.width/2;
        circleside=-circleside;
    }];
}
- (IBAction)ScreenOnOrOff:(UIButton *)sender { // ScreenOnOrOff.
    if (!screenOnOff) {
        [UIApplication sharedApplication].idleTimerDisabled=YES; // 取消螢幕關閉功能.
        screenOnOff=YES;
        [sender setImage:[UIImage imageNamed:@"ScreenClose.png"] forState:UIControlStateNormal];
    }
    else if (screenOnOff){
        [UIApplication sharedApplication].idleTimerDisabled=NO; // 開啟螢幕關閉功能.
        screenOnOff=NO;
        [sender setImage:[UIImage imageNamed:@"ScreenOpen.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)ButtonPlayMusic:(UIButton *)sender { // ButtonPlayMusic.
    if (playMusic) { // 不提醒變為播放提醒.
        playMusic=NO; // 確認沒選擇歌曲後不播放.
        [musicPlayer stop]; // 停止音樂.
        [self changeUIViewExteriorFrontMode2:self.ButtonPlayMusic TitleColor:[UIColor yellowColor] BorderColor:[UIColor yellowColor] BackColor:[UIColor whiteColor] OnOrOff:YES]; // 改變視圖外觀前置作業.
        [self.ButtonPlayMusic setTitle:[NSString stringWithFormat:@"提醒\nRemind"] forState:UIControlStateNormal];
    }
    else{   // 不提醒.
       [self presentViewController:mediaPicker animated:YES completion:nil]; // 開啟音樂檔案列表視窗.
    }
}
-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{ // 使用者選擇了音樂後會呼叫此方法.
    musicPlayer=[MPMusicPlayerController applicationMusicPlayer]; // 到背景程式後,音樂會停止播放,iPodMusicPlayer則不會.
    [musicPlayer setQueueWithItemCollection:mediaItemCollection]; // 使用者選取的音樂傳進來,隊列的設置與項目集合,可以選擇多個,上段程式有開啟此功能.
    [self dismissViewControllerAnimated:YES completion:nil]; // 釋放掉這個畫面.
    playMusic=YES; // 確認有選擇歌曲後播放歌曲.
    [self changeUIViewExteriorFrontMode2:self.ButtonPlayMusic TitleColor:[UIColor blackColor] BorderColor:[UIColor blackColor] BackColor:[UIColor whiteColor] OnOrOff:NO]; // 改變視圖外觀前置作業.
    [self.ButtonPlayMusic setTitle:[NSString stringWithFormat:@"不提醒\nNot Remind"] forState:UIControlStateNormal];
    //[musicPlayer play]; // 播放音樂.
}
-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{ // 使用者在音樂列表上按取消後會呼叫此方法,用以關閉音樂料表示窗.
    playMusic=NO; // 確認沒選擇歌曲後不播放.
    [self dismissViewControllerAnimated:YES completion:nil]; // 釋放掉這個畫面.
}

@end
