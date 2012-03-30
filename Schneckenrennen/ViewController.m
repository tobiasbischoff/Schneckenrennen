//
//  ViewController.m
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 09.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "ViewController.h"
#import "ManualViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize gameName;
@synthesize becher;
@synthesize w1View;
@synthesize w2View;
@synthesize diceButton,doneSetting;

int wurf1;
int wurf2;
BOOL alreadywon = FALSE;
BOOL shownmanual = FALSE;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Schnecke ist eigene Klasse test
    schn_blu_view = [[TBSchnecke alloc] initWithFrame:CGRectMake(30, 15, 137, 116)];
    schn_ora_view = [[TBSchnecke alloc] initWithFrame:CGRectMake(30, 156, 137, 116)];
    schn_ros_view = [[TBSchnecke alloc] initWithFrame:CGRectMake(30, 291, 137, 116)];
    schn_gre_view = [[TBSchnecke alloc] initWithFrame:CGRectMake(30, 420, 137, 116)];
    
    [[self view] addSubview:schn_blu_view];
    [[self view] addSubview:schn_ora_view];
    [[self view] addSubview:schn_ros_view];
    [[self view] addSubview:schn_gre_view];
        
    
    //zweiten würfel drehen
    [w2View setImage:[UIImage imageWithCGImage:[[UIImage imageNamed:@"w_neutral_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored]];
    
    NSArray * becher_anim = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"becher_l.png"],
                             [UIImage imageNamed:@"becher_g.png"],
                             [UIImage imageNamed:@"becher_r.png"],
                             nil];
    
    [becher setAnimationImages:becher_anim];
    [becher setAnimationDuration:0.3];
    [becher setAnimationRepeatCount:5];
    
    
    [gameName setText:NSLocalizedString(@"Schneckenrennen", @"Holzschildtitel")];
   

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (!shownmanual) {
        ManualViewController * mvc = [[ManualViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mvc];
        [navController setModalPresentationStyle:UIModalPresentationFormSheet];
        [self presentModalViewController:navController animated:YES];
        shownmanual = TRUE;
    }
    
}

- (void)viewDidUnload
{

    [self setBecher:nil];
    [self setGameName:nil];
    [self setW1View:nil];
    [self setW2View:nil];
    [self setDiceButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void) newgame
{
    alreadywon = FALSE;
    
    [schn_blu_view goback];
    [schn_ora_view goback];
    [schn_ros_view goback];
    [schn_gre_view goback];
    

}

- (void)setW1withID:(int)id
{
    if (id == 1)
    {   
        [w1View setImage:[UIImage imageNamed:@"w_blu_1.png"]];
    }
    
    if (id == 2)
    {   
        [w1View setImage:[UIImage imageNamed:@"w_ora_1.png"]];
    }
    if (id == 3)
    {   
      [w1View setImage:[UIImage imageNamed:@"w_ros_1.png"]];
    }
    if (id == 4)
    {   
      [w1View setImage:[UIImage imageNamed:@"w_gre_1.png"]];
    }

}

- (void)setW2withID:(int)id
{
    if (id == 1)
    {   
        [w2View setImage:[UIImage imageWithCGImage:[[UIImage imageNamed:@"w_blu_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored]];
    }
    
    if (id == 2)
    {   
         [w2View setImage:[UIImage imageWithCGImage:[[UIImage imageNamed:@"w_ora_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored]];
    }
    if (id == 3)
    {   
         [w2View setImage:[UIImage imageWithCGImage:[[UIImage imageNamed:@"w_ros_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored]];
    }
    if (id == 4)
    {   
         [w2View setImage:[UIImage imageWithCGImage:[[UIImage imageNamed:@"w_gre_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored]];
    }
    
}

- (IBAction)diceButton:(id)sender {
    
    if ([schn_blu_view position] == [schn_blu_view realposition] && [schn_ora_view position] == [schn_ora_view realposition] && [schn_ros_view position] == [schn_ros_view realposition] && [schn_gre_view position] == [schn_gre_view realposition]) [self setDoneSetting:TRUE];
    
    if (!doneSetting) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Hey!",@"UIAlertView Titel") message:NSLocalizedString(@"Du musst erst die Schnecken setzen.",@"erst setzten text")  delegate:self cancelButtonTitle:NSLocalizedString(@"Nagut", @"setzen box knopf") otherButtonTitles: nil];
        [alert show];
        return;

    }
    
    [diceButton setEnabled:FALSE];
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{                                                                                            
                         becher.transform = CGAffineTransformMakeTranslation(0, -150); 
                     }
                     completion:^(BOOL finished){ 
                         
                         NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"wuerfel" ofType:@"mp3"];
                         audioplayer =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: soundPath] error:nil];
                        
                         audioplayer.volume = 1;
                      
                         [audioplayer prepareToPlay];
                         [audioplayer play];
                         [becher startAnimating];
                         wurf1 = (arc4random() % 4) + 1;
                         wurf2 = (arc4random() % 4) + 1;
                         [self setW1withID:wurf1];
                         [self setW2withID:wurf2];
                     
                         [UIView animateWithDuration:1
                                               delay:1
                                             options:UIViewAnimationCurveEaseOut
                                          animations:^{                                                                                            
                                              becher.transform = CGAffineTransformMakeTranslation(0, 0); 
                                          }
                                          completion:^(BOOL finished){ 
                                              [self processMoves:wurf1];
                                              [self processMoves:wurf2];
                                              [self setDoneSetting:FALSE];
                                              NSLog(@"wurf 1: %d wurf2 %d", wurf1, wurf2);
                                              if ([schn_blu_view position] > 6 | [schn_ora_view position] > 6 | [schn_ros_view position] > 6 | [schn_gre_view position] > 6) {
                                                  NSString *finsoundPath = [[NSBundle mainBundle] pathForResource:@"kids" ofType:@"mp3"];
                                                  finplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: finsoundPath] error:nil];
                                                  finplayer.volume = 1;
                                                  [finplayer prepareToPlay];
                                                  [finplayer setDelegate:self];
                                                  [finplayer play];
                                              }
                                              
                                        }
                          ];

                     }
     ];

    
    
    [diceButton setEnabled:TRUE];
    

}

- (void)processMoves:(int)wurf {
    
    if (wurf == 1) {
        [schn_blu_view startJiggling:1];
        [schn_blu_view setUserInteractionEnabled:YES];
        [schn_blu_view setPosition:[schn_blu_view position]+1];
        
    }
    
    if (wurf == 2) {
        [schn_ora_view startJiggling:1];
        [schn_ora_view setUserInteractionEnabled:YES];
        [schn_ora_view setPosition:[schn_ora_view position]+1];
        
    }
    if (wurf == 3) {
        [schn_ros_view startJiggling:1];
        [schn_ros_view setUserInteractionEnabled:YES];
        [schn_ros_view setPosition:[schn_ros_view position]+1];
        
    }
    if (wurf == 4) {
        [schn_gre_view startJiggling:1];
        [schn_gre_view setUserInteractionEnabled:YES];
        [schn_gre_view setPosition:[schn_gre_view position]+1];
        
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
   
    if ([schn_blu_view position] > 6 ) {
        if (!alreadywon) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ziel!",@"UIAlertView Titel") message:NSLocalizedString(@"Die blaue Schnecke hat gewonnen!",@"Blaue Schnecke win-text")   delegate:self cancelButtonTitle:NSLocalizedString(@"Nochmal!", @"win-box knopf") otherButtonTitles: nil];
        [alert show];
        }
        alreadywon = TRUE;
    }
    
    if ([schn_ora_view position] > 6 ) {
         if (!alreadywon) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ziel!",@"UIAlertView Titel") message:NSLocalizedString(@"Die orange Schnecke hat gewonnen!",@"Orage Schnecke win-text")  delegate:self cancelButtonTitle:NSLocalizedString(@"Nochmal!", @"win-box knopf") otherButtonTitles: nil];
        [alert show];
         }
        alreadywon = TRUE;
    }
    
    if ([schn_ros_view position] > 6 ) {
         if (!alreadywon) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ziel!",@"UIAlertView Titel") message:NSLocalizedString(@"Die rosa Schnecke hat gewonnen!",@"rosa Schnecke win-text")  delegate:self cancelButtonTitle:NSLocalizedString(@"Nochmal!", @"win-box knopf") otherButtonTitles: nil];
        [alert show];
         }
        alreadywon = TRUE;
    }
    
    if ([schn_gre_view position] > 6 ) {
          if (!alreadywon) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ziel!",@"UIAlertView Titel") message:NSLocalizedString(@"Die grüne Schnecke hat gewonnen!",@"grüne Schnecke win-text")  delegate:self cancelButtonTitle:NSLocalizedString(@"Nochmal!", @"win-box knopf") otherButtonTitles: nil];
        [alert show];
          }
        alreadywon = TRUE;
    }

    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
    //[self newgame];
}
@end
