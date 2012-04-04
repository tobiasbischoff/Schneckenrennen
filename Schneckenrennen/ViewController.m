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
@synthesize moneyWoo;
@synthesize gameName;
@synthesize becher;
@synthesize w1View;
@synthesize w2View;
@synthesize diceButton,doneSetting;

int wurf1;
int wurf2;
BOOL shownmanual = FALSE;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //backgroundmusik abspielen
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Reggae" ofType:@"mp3"];
    audioplayer =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: soundPath] error:nil];
    audioplayer.volume = 0.8;
    audioplayer.numberOfLoops = -1;
    [audioplayer play];

    //sounds laden
    NSString *wuerfelsoundPath = [[NSBundle mainBundle] pathForResource:@"wuerfel" ofType:@"mp3"];
    wuerfelAudioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: wuerfelsoundPath] error:nil];
    wuerfelAudioplayer.volume = 1;
    [wuerfelAudioplayer prepareToPlay];
    
    NSString *monkeysoundPath = [[NSBundle mainBundle] pathForResource:@"monkey" ofType:@"mp3"];
    monkeyPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: monkeysoundPath] error:nil];
    monkeyPlayer.volume = 1;
    [monkeyPlayer prepareToPlay];
    [monkeyPlayer setDelegate:self];
    
    NSString *stonesoundPath = [[NSBundle mainBundle] pathForResource:@"stonesound" ofType:@"mp3"];
    stonePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: stonesoundPath] error:nil];
    stonePlayer.volume = 1;
    [stonePlayer prepareToPlay];
    
    //notification center registrieren für schnecke gewonnen
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(schneckeGewonnen:) name:@"blu" object:nil];
    [nc addObserver:self selector:@selector(schneckeGewonnen:) name:@"ora" object:nil];
	[nc addObserver:self selector:@selector(schneckeGewonnen:) name:@"ros" object:nil];
    [nc addObserver:self selector:@selector(schneckeGewonnen:) name:@"gre" object:nil];
    [nc addObserver:self selector:@selector(newgame:) name:@"again" object:nil];
    
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
    
    //becher animation erstellen
    NSArray * becher_anim = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"becher_l.png"],
                             [UIImage imageNamed:@"becher_g.png"],
                             [UIImage imageNamed:@"becher_r.png"],
                             nil];
    
    [becher setAnimationImages:becher_anim];
    [becher setAnimationDuration:0.3];
    [becher setAnimationRepeatCount:5];
    
    //schild beschriften
    [gameName setText:NSLocalizedString(@"Schneckenrennen", @"Holzschildtitel")];
   
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //muss das manual gezeigt werden?
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
    [self setMoneyWoo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)newgame:(NSNotification *)note {

    [w2View setImage:[UIImage imageWithCGImage:[[UIImage imageNamed:@"w_neutral_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored]];
    [w1View setImage:[UIImage imageNamed:@"w_neutral_1.png"]];
    
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
                         [wuerfelAudioplayer play];
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



- (void)schneckeGewonnen:(NSNotification *)note {
    
    WinViewController * wvc = [[WinViewController alloc] init];
    if (note.name == @"blu") {
        [wvc setWinnerImage:[UIImage imageNamed:@"schn_blu_1.png"]];
        [wvc setLabeltext:NSLocalizedString(@"Die grossartige blaue Schnecke hat gewonnen!!", @"blu-win-text")];
        
    }
    
    if (note.name == @"ora") {
        [wvc setWinnerImage:[UIImage imageNamed:@"schn_ora_1.png"]];
        [wvc setLabeltext:NSLocalizedString(@"Die grossartige orange Schnecke hat gewonnen!!", @"ora-win-text")];
        
    }
    
    if (note.name == @"ros") {
        [wvc setWinnerImage:[UIImage imageNamed:@"schn_ros_1.png"]];
        [wvc setLabeltext:NSLocalizedString(@"Die grossartige rosa Schnecke hat gewonnen!!", @"ros-win-text")];
        
    }
    
    if (note.name == @"gre") {
        [wvc setWinnerImage:[UIImage imageNamed:@"schn_gre_1.png"]];
        [wvc setLabeltext:NSLocalizedString(@"Die grossartige grüne Schnecke hat gewonnen!!", @"gre-win-text")];
        
    }
    
    UINavigationController *winnavController = [[UINavigationController alloc] initWithRootViewController:wvc];
    [winnavController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentModalViewController:winnavController animated:YES];
    
}



- (IBAction)monkeyButton:(id)sender {
    
    [monkeyPlayer play];
    [moneyWoo setHidden:NO];
    
    
}

- (IBAction)stoneButton:(id)sender {
    
    [stonePlayer play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [moneyWoo setHidden:TRUE];
}
@end
