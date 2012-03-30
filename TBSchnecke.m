//
//  TBSchnecke.m
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 27.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "TBSchnecke.h"

@implementation TBSchnecke
@synthesize xmax,position;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //set image
        if (frame.origin.y == 15) {
            image1name = [NSString stringWithFormat:@"schn_blu_1.png"];
            image2name = [NSString stringWithFormat:@"schn_blu_2.png"];
        }
        
        if (frame.origin.y == 156) {
            image1name = [NSString stringWithFormat:@"schn_ora_1.png"];
            image2name = [NSString stringWithFormat:@"schn_ora_2.png"];
        }
        
        if (frame.origin.y == 291) {
            image1name = [NSString stringWithFormat:@"schn_ros_1.png"];
            image2name = [NSString stringWithFormat:@"schn_ros_2.png"];
        }
        
        if (frame.origin.y == 420) {
            image1name = [NSString stringWithFormat:@"schn_gre_1.png"];
            image2name = [NSString stringWithFormat:@"schn_gre_2.png"];
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
        
         }
    return self;
}



- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
   
    [self stopJiggling];
    [self startAnimating];
    [[self superview] bringSubviewToFront:self];
    
    [UIView beginAnimations:nil context:NULL];  
    [UIView setAnimationDuration: 1];  
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];  
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    
    if (position == 0) position = 1;
    if (position > 6) position--;    
    //self.transform = CGAffineTransformMakeTranslation(position*120, 0);
    
    [self setFrame:CGRectMake(30+position*120, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
   
    
    [UIView commitAnimations];
    
    [self setUserInteractionEnabled:NO];
    
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
    [self setAnimationImages:schn_anim_flip];
    [self setImage:[schn_anim_flip objectAtIndex:0]];
    [self startAnimating];
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{                                                                                            
                         self.transform = CGAffineTransformMakeTranslation(0, 0);       
                        }
                     completion:^(BOOL finished){                                        
                         [self setImage:[schn_anim objectAtIndex:0]];
                         [self setAnimationImages:schn_anim];
                         
                     }
     ];
    [self setPosition:0];
    
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
