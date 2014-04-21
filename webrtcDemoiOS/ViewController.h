//
//  ViewController.h
//  webrtcDemoiOS
//
//  Created by Song Zheng on 8/14/13.
//  Copyright (c) 2013 Song Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomViewController.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *appTitle;
@property (strong, nonatomic) IBOutlet UITextField *roomName;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UIButton *buttonName;
@property (retain, nonatomic) IBOutlet UITextField *userName;

@end
