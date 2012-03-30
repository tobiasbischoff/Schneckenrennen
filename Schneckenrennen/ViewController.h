//
//  ViewController.h
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 09.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TBSchnecke.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer * audioplayer;
    AVAudioPlayer * finplayer;
    TBSchnecke * schn_blu_view;
    TBSchnecke * schn_ora_view;
    TBSchnecke * schn_ros_view;
    TBSchnecke * schn_gre_view;
    
}
- (IBAction)diceButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *gameName;


@property (weak, nonatomic) IBOutlet UIImageView *becher;
@property (weak, nonatomic) IBOutlet UIImageView *w1View;
@property (weak, nonatomic) IBOutlet UIImageView *w2View;
@property (weak, nonatomic) IBOutlet UIButton *diceButton;

@property (nonatomic) BOOL doneSetting;


- (void)setW1withID:(int)id;
- (void)setW2withID:(int)id;

- (void)newgame;


- (void)processMoves:(int)wurf;

@end
