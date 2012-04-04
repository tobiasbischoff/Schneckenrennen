//
//  WinViewController.h
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 04.04.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface WinViewController : UIViewController {
    
    AVAudioPlayer * winplayer;
    
    
}

@property (strong,nonatomic) UIImage * winnerImage;
@property (strong,nonatomic) NSString * labeltext;

@property (weak, nonatomic) IBOutlet UIImageView *winView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
- (IBAction)againButton:(id)sender;

@end
