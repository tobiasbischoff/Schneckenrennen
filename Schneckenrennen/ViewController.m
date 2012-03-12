//
//  ViewController.m
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 09.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize becher;
@synthesize schn_blu_view, schn_blu_anim,schn_blu_anim_flip;
@synthesize schn_ora_view, schn_ora_anim, schn_ora_anim_flip;
@synthesize schn_ros_view, schn_ros_anim, schn_ros_anim_flip;
@synthesize schn_gre_view, schn_gre_anim, schn_gre_anim_flip;

int  schn_blu_pos;
int  schn_ora_pos;
int  schn_ros_pos;
int  schn_gre_pos;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]]];
    
    NSArray * becher_anim = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"becher_l.png"],
                             [UIImage imageNamed:@"becher_g.png"],
                             [UIImage imageNamed:@"becher_r.png"],
                             nil];
    
    [becher setAnimationImages:becher_anim];
    [becher setAnimationDuration:0.3];
    [becher setAnimationRepeatCount:5];
    
    schn_blu_anim = [[NSArray alloc] initWithObjects:
                           [UIImage imageNamed:@"schn_blu_1.png"],
                           [UIImage imageNamed:@"schn_blu_2.png"],
                           nil];
    
    schn_blu_anim_flip = [[NSArray alloc] initWithObjects:
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_blu_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_blu_2.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          nil];
    
    [schn_blu_view setAnimationDuration:0.3];
    [schn_blu_view setAnimationRepeatCount:3];
    [schn_blu_view setAnimationImages:schn_blu_anim];
    
    
    
    
    schn_ora_anim = [[NSArray alloc] initWithObjects:
                               [UIImage imageNamed:@"schn_ora_1.png"],
                               [UIImage imageNamed:@"schn_ora_2.png"],
                               nil];
    
    schn_ora_anim_flip = [[NSArray alloc] initWithObjects:
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_ora_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_ora_2.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          nil];
    
    [schn_ora_view setAnimationDuration:0.3];
    [schn_ora_view setAnimationRepeatCount:3];
    [schn_ora_view setAnimationImages:schn_ora_anim];
    
    schn_ros_anim = [[NSArray alloc] initWithObjects:
                               [UIImage imageNamed:@"schn_ros_1.png"],
                               [UIImage imageNamed:@"schn_ros_2.png"],
                               nil];
    
    schn_ros_anim_flip = [[NSArray alloc] initWithObjects:
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_ros_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_ros_2.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          nil];
    
    [schn_ros_view setAnimationDuration:0.3];
    [schn_ros_view setAnimationRepeatCount:3];
    [schn_ros_view setAnimationImages:schn_ros_anim];
    
    schn_gre_anim = [[NSArray alloc] initWithObjects:
                               [UIImage imageNamed:@"schn_gre_1.png"],
                               [UIImage imageNamed:@"schn_gre_2.png"],
                               nil];
    
    schn_gre_anim_flip = [[NSArray alloc] initWithObjects:
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_gre_1.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          [UIImage imageWithCGImage:[[UIImage imageNamed:@"schn_gre_2.png"]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          nil];
    
    [schn_gre_view setAnimationDuration:0.3];
    [schn_gre_view setAnimationRepeatCount:3];
    [schn_gre_view setAnimationImages:schn_gre_anim];
    

   

}

- (void)viewDidUnload
{
    [self setSchn_blu_view:nil];
    [self setSchn_ora_view:nil];
    [self setSchn_ros_view:nil];
    [self setSchn_gre_view:nil];
    [self setBecher:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)moveSchnWithID:(int)id
{
    
    [UIView beginAnimations:nil context:NULL];  
    [UIView setAnimationDuration: 1];  
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];  
    [UIView setAnimationBeginsFromCurrentState:YES];  
    
    if (id == 1)
    {   
        if (schn_blu_pos == 0) schn_blu_pos = 1;
        [schn_blu_view  startAnimating];
        schn_blu_view.transform = CGAffineTransformMakeTranslation(schn_blu_pos*120, 0);
        schn_blu_pos++;
    }
    
    if (id == 2)
    {   
        if (schn_ora_pos == 0) schn_ora_pos = 1;
        [schn_ora_view  startAnimating];
        schn_ora_view.transform = CGAffineTransformMakeTranslation(schn_ora_pos*120, 0);
        schn_ora_pos++;
    }
    if (id == 3)
    {   
        if (schn_ros_pos == 0) schn_ros_pos = 1;
        [schn_ros_view  startAnimating];
        schn_ros_view.transform = CGAffineTransformMakeTranslation(schn_ros_pos*120, 0);
        schn_ros_pos++;
    }
    if (id == 4)
    {   
        if (schn_gre_pos == 0) schn_gre_pos = 1;
        [schn_gre_view  startAnimating];
        schn_gre_view.transform = CGAffineTransformMakeTranslation(schn_gre_pos*120, 0);
        schn_gre_pos++;
    }
    
    [UIView commitAnimations]; 
    
}

- (void) newgame
{
    
    [schn_blu_view setAnimationImages:schn_blu_anim_flip];
    [schn_blu_view setImage:[schn_blu_anim_flip objectAtIndex:0]];
    [schn_blu_view  startAnimating];

    [schn_ora_view  startAnimating];
    [schn_ora_view setAnimationImages:schn_ora_anim_flip];
    [schn_ora_view setImage:[schn_ora_anim_flip objectAtIndex:0]];
 
    [schn_ros_view  startAnimating];
    [schn_ros_view setAnimationImages:schn_ros_anim_flip];
    [schn_ros_view setImage:[schn_ros_anim_flip objectAtIndex:0]];
 
    [schn_gre_view  startAnimating];
    [schn_gre_view setAnimationImages:schn_gre_anim_flip];
    [schn_gre_view setImage:[schn_gre_anim_flip objectAtIndex:0]];
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{                                                                                            
                          schn_blu_view.transform = CGAffineTransformMakeTranslation(0, 0);       
                          schn_ora_view.transform = CGAffineTransformMakeTranslation(0, 0);
                          schn_ros_view.transform = CGAffineTransformMakeTranslation(0, 0);
                          schn_gre_view.transform = CGAffineTransformMakeTranslation(0, 0);
                     }
                     completion:^(BOOL finished){                                        
                        [schn_blu_view setImage:[schn_blu_anim objectAtIndex:0]];
                        [schn_ora_view setImage:[schn_ora_anim objectAtIndex:0]];
                        [schn_ros_view setImage:[schn_ros_anim objectAtIndex:0]];
                        [schn_gre_view setImage:[schn_gre_anim objectAtIndex:0]];
                     }
     ];
    
  
    schn_blu_pos = 0;
    schn_ora_pos = 0;
    schn_ros_pos = 0;
    schn_gre_pos = 0;

}



- (IBAction)diceButton:(id)sender {
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{                                                                                            
                         becher.transform = CGAffineTransformMakeTranslation(0, -150); 
                     }
                     completion:^(BOOL finished){ 
                         
                         [becher startAnimating];
                     
                         [UIView animateWithDuration:1
                                               delay:1
                                             options:UIViewAnimationCurveEaseOut
                                          animations:^{                                                                                            
                                              becher.transform = CGAffineTransformMakeTranslation(0, 0); 
                                          }
                                          completion:^(BOOL finished){ 
                                              int wurf1 = (arc4random() % 4) + 1;
                                              int wurf2 = (arc4random() % 4) + 1;
                                              [self moveSchnWithID:wurf1];
                                              [self moveSchnWithID:wurf2];
                                              NSLog(@"wurf 1: %d wurf2 %d", wurf1, wurf2);
                                              if (schn_blu_pos > 6 ) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ziel!" message:@"Die blaue Schnecke hat gewonnen!"  delegate:self cancelButtonTitle:@"Nochmal!" otherButtonTitles: nil];
                                                  [alert show];
                                              }
                                              
                                              if (schn_ora_pos > 6 ) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ziel!" message:@"Die orange Schnecke hat gewonnen!"  delegate:self cancelButtonTitle:@"Nochmal!" otherButtonTitles: nil];
                                                  [alert show];
                                              }
                                              
                                              if (schn_ros_pos > 6 ) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ziel!" message:@"Die rosa Schnecke hat gewonnen!"  delegate:self cancelButtonTitle:@"Nochmal!" otherButtonTitles: nil];
                                                  [alert show];
                                              }
                                              
                                              if (schn_gre_pos > 6 ) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ziel!" message:@"Die grüne Schnecke hat gewonnen!"  delegate:self cancelButtonTitle:@"Nochmal!" otherButtonTitles: nil];
                                                  [alert show];
                                              }
                                          }
                          ];

                     }
     ];

    
    
    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
    [self newgame];
}
@end
