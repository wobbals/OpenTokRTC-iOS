//
//  ViewController.m
//  webrtcDemoiOS
//
//  Created by Song Zheng on 8/14/13.
//  Copyright (c) 2013 Song Zheng. All rights reserved.
//

#define OPENTOK_INFO @"OpenTokInfo"
#define OPENTOK_USER_NAME @"OpenTokUserName"
#define OPENTOK_ROOM_NAME @"OpenTokRoomName"
#import "ViewController.h"

@interface ViewController (){
    UIFont* avantGarde;
}

@end

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"font family names: %@", [UIFont fontNamesForFamilyName:@"AvantGarde Bk BT"]);
    
    // Change fonts of all text on the screen
    [_roomName setFont: [UIFont fontWithName:@"AvantGardeITCbyBT-Book" size:22.0 ]];
    [_appTitle setFont: [UIFont fontWithName:@"AvantGardeITCbyBT-Book" size:35.0 ]];
    [_hintLabel setFont:[UIFont fontWithName:@"AvantGardeITCbyBT-Book" size:13.0 ]];
    [_buttonName.titleLabel setFont: avantGarde];
    
    // listen to taps around the screen, and hide keyboard when necessary
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tgr.delegate = self;
    [self.view addGestureRecognizer:tgr];
    [tgr release];
    
    // set up the look of the page
    [self.navigationController setNavigationBarHidden:YES];
    if (!SYSTEM_VERSION_LESS_THAN(@"7.0")) {
      [self setNeedsStatusBarAppearanceUpdate];
    }
    
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults]
                              valueForKey:OPENTOK_INFO];
    if(!userInfo)
    {
        self.userName.text = [[UIDevice currentDevice] name];
    }
    else
    {
        self.roomName.text = [userInfo valueForKey:OPENTOK_ROOM_NAME];
        self.userName.text = [userInfo valueForKey:OPENTOK_USER_NAME];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIControl class]]) {
        // user tapped on buttons or input fields
    }else{
        [self.roomName resignFirstResponder];
        [self.userName resignFirstResponder];
    }
    return YES;
}

- (void)viewTapped:(UITapGestureRecognizer *)tgr
{
    // user tapped on the view
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - User Interaction
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSString* inputRoomName = [[_roomName text] stringByReplacingOccurrencesOfString:@" " withString:@""];;
    return (inputRoomName.length >= 1) ? YES : NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // user clicks button, prepares to join room
    if ([[segue identifier] isEqualToString:@"startChat"])
    {
        [_roomName resignFirstResponder];
        NSDictionary *tempUserInfo = [[NSUserDefaults standardUserDefaults]
                                  valueForKey:OPENTOK_INFO];
        NSMutableDictionary *userInfo = [NSMutableDictionary
                                         dictionaryWithDictionary:tempUserInfo];
        [userInfo setValue:self.roomName.text forKey:OPENTOK_ROOM_NAME];
        [userInfo setValue:self.userName.text forKey:OPENTOK_USER_NAME];

        [[NSUserDefaults standardUserDefaults] setValue:userInfo
                                                 forKey:OPENTOK_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"going to chat room...");
        RoomViewController *vc = [segue destinationViewController];
        vc.rid = [[_roomName text] stringByReplacingOccurrencesOfString:@" " withString:@""];
        vc.publisherName = [[self.userName text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
}

#pragma mark - Chat textfield
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // called after the text field resigns its first responder status
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"enter is clicked");
    [textField resignFirstResponder];
    return NO;
}

- (void)dealloc
{
    [super dealloc];
    [_appTitle release];
    [_roomName release];
    [_hintLabel release];
    [_buttonName release];
    [_userName release];
}
@end
