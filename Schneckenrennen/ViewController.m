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
@synthesize schn_blu_view;

int  schn_blu_count;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]]];
    
    NSArray * schn_blu_anim = [[NSArray alloc] initWithObjects:
                           [UIImage imageNamed:@"schn_blu_1.png"],
                           [UIImage imageNamed:@"schn_blu_2.png"],
                           nil];
    
    [schn_blu_view setAnimationDuration:0.3];
    [schn_blu_view setAnimationRepeatCount:3];
    [schn_blu_view setAnimationImages:schn_blu_anim];
    
    
   

}

- (void)viewDidUnload
{
    [self setSchn_blu_view:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)diceButton:(id)sender {
    
    if (schn_blu_count == 0) {
        
        [schn_blu_view  startAnimating];
        [UIView beginAnimations:nil context:NULL];  
        [UIView setAnimationDuration: 1];  
        [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];  
        [UIView setAnimationBeginsFromCurrentState:YES];  
        schn_blu_view.transform = CGAffineTransformMakeTranslation(+80, 0);  
        
        [UIView commitAnimations]; 
        schn_blu_count++;
        return;
    }
     
    if (schn_blu_count == 1) {
        
        [schn_blu_view  startAnimating];
        [UIView beginAnimations:nil context:NULL];  
        [UIView setAnimationDuration: 1];  
        [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];  
        [UIView setAnimationBeginsFromCurrentState:YES];  
        schn_blu_view.transform = CGAffineTransformMakeTranslation(+160, 0);  
        
        [UIView commitAnimations]; 
        schn_blu_count++;
        return;
    }
    
    
    
}
@end
