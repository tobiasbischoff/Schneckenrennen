//
//  TBSchnecke.m
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 27.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "TBSchnecke.h"

@implementation TBSchnecke
@synthesize xmax,position,realposition;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //set image
        if (frame.origin.y == 35) {
            image1name = [NSString stringWithFormat:@"schn_blu_1.png"];
            image2name = [NSString stringWithFormat:@"schn_blu_2.png"];
            sID = @"blu";
        }
        
        if (frame.origin.y == 176) {
            image1name = [NSString stringWithFormat:@"schn_ora_1.png"];
            image2name = [NSString stringWithFormat:@"schn_ora_2.png"];
            sID = @"ora";
        }
        
        if (frame.origin.y == 311) {
            image1name = [NSString stringWithFormat:@"schn_ros_1.png"];
            image2name = [NSString stringWithFormat:@"schn_ros_2.png"];
            sID = @"ros";
        }
        
        if (frame.origin.y == 440) {
            image1name = [NSString stringWithFormat:@"schn_gre_1.png"];
            image2name = [NSString stringWithFormat:@"schn_gre_2.png"];
            sID = @"gre";
        }
        
        [self setImage:[UIImage imageNamed:image1name]];
        
        //setup animantion array
        schn_anim = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:image1name],
                         [UIImage imageNamed:image2name],
                         nil];
        
        schn_anim_flip = [[NSArray alloc] initWithObjects:
                              [UIImage imageWithCGImage:[[UIImage imageNamed:image1name]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                          [UIImage imageWithCGImage:[[UIImage imageNamed:image2name]CGImage] scale:1 orientation:UIImageOrientationUpMirrored],
                              nil];
        
        [self setAnimationImages:schn_anim];
        [self setAnimationDuration:0.3];
        [self setAnimationRepeatCount:3];
        [self setUserInteractionEnabled:NO];
        position = 0;
        
        //load qeek
        NSString *qeeksoundPath = [[NSBundle mainBundle] pathForResource:@"qeek" ofType:@"mp3"];
        qeekplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: qeeksoundPath] error:nil];
        qeekplayer.volume = 1;
        [qeekplayer prepareToPlay];
        
         }
    return self;
}



- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
   
    [self stopJiggling];
    [self startAnimating];
    [[self superview] bringSubviewToFront:self];
    [self setUserInteractionEnabled:NO];
    [UIView beginAnimations:nil context:NULL];  
    [qeekplayer play];
    
    if (position == 0) position = 1;
   // if (position > 6) position--;    
   
    [UIView commitAnimations];
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{ 
                         [self setFrame:CGRectMake(30+position*120, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
                          }
                     completion: ^(BOOL finished){
                         realposition = position;
                         if (realposition > 5) {
                         NSNotification *note = [NSNotification notificationWithName:sID object:self];
                         [[NSNotificationCenter defaultCenter] postNotification:note];
                         }
                     }];
    
    
   
}



- (void)startJiggling:(NSInteger)count {
     
    
    #define degreesToRadians(x) (M_PI * (x) / 180.0)
    #define kAnimationRotateDeg 1.0
    
    NSInteger randomInt = arc4random()%500;
    float r = (randomInt/500.0)+0.5;
    
    CGAffineTransform leftWobble = CGAffineTransformMakeRotation(degreesToRadians( (kAnimationRotateDeg * -1.0) - r ));
    CGAffineTransform rightWobble = CGAffineTransformMakeRotation(degreesToRadians( kAnimationRotateDeg + r ));
    
    self.transform = leftWobble;  // starting point
    
    [[self layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{ 
                         [UIView setAnimationRepeatCount:NSNotFound];
                         self.transform = rightWobble; }
                     completion:nil];
    
     
}

- (void)stopJiggling {
    [self.layer removeAllAnimations];
    self.transform = CGAffineTransformIdentity;  // Set it straight 
}

- (void)goback {
    [self stopJiggling];
    [self setUserInteractionEnabled:NO];
    [self setAnimationImages:schn_anim_flip];
    [self setImage:[schn_anim_flip objectAtIndex:0]];
    [self startAnimating];
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{                                                                                            
                        [self setFrame:CGRectMake(30, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];     
                        }
                     completion:^(BOOL finished){                                        
                         [self setImage:[schn_anim objectAtIndex:0]];
                         [self setAnimationImages:schn_anim];
                         
                     }
     ];
    [self setPosition:0];
    [self setRealposition:0];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
