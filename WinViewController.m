//
//  WinViewController.m
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 04.04.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "WinViewController.h"

@interface WinViewController ()

@end

@implementation WinViewController
@synthesize winView;
@synthesize winLabel;
@synthesize labeltext,winnerImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"formback.png"]]];
        [self setTitle:NSLocalizedString(@"Wir haben einen Gewinner!", @"WinTitel")];
        
        //winsound laden
        NSString *winsoundPath = [[NSBundle mainBundle] pathForResource:@"kids" ofType:@"mp3"];
        winplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: winsoundPath] error:nil];
        winplayer.volume = 1;
        [winplayer prepareToPlay];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    }

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [winplayer play];
    
    [winView setImage:winnerImage];
    [winLabel setText:labeltext];

    // Create a key frame animation
    CAKeyframeAnimation *bounce =
    [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    // Create the values it will pass through
    CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1);
    CATransform3D back = CATransform3DMakeScale(0.7, 0.7, 1);
    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);
    [bounce setValues:[NSArray arrayWithObjects:
                       [NSValue valueWithCATransform3D:CATransform3DIdentity],
                       [NSValue valueWithCATransform3D:forward],
                       [NSValue valueWithCATransform3D:back],
                       [NSValue valueWithCATransform3D:forward2],
                       [NSValue valueWithCATransform3D:back2],
                       [NSValue valueWithCATransform3D:CATransform3DIdentity],
                       nil]];
    // Set the duration
    [bounce setDuration:10];
    
    // Animate the layer
    [[winView layer] addAnimation:bounce
                             forKey:@"bounceAnimation"];
    
    
}

- (void)viewDidUnload
{
    [self setWinView:nil];
    [self setWinLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return  UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)againButton:(id)sender {
     NSNotification *note = [NSNotification notificationWithName:@"again" object:self];
     [[NSNotificationCenter defaultCenter] postNotification:note];
     [self dismissModalViewControllerAnimated:YES];
}
@end
