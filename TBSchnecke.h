//
//  TBSchnecke.h
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 27.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>

@class ViewController;

@interface TBSchnecke : UIImageView {
 
    NSArray * schn_anim;
    NSArray * schn_anim_flip;
    NSString * image1name;
    NSString * image2name;
}

@property (nonatomic) int xmax;
@property (nonatomic) int position;
@property (nonatomic) int realposition;


- (void)stopJiggling;
- (void)startJiggling:(NSInteger)count;
- (void)goback;


@end
