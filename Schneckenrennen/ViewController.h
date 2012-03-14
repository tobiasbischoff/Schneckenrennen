//
//  ViewController.h
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 09.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)diceButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *schn_blu_view;
@property (weak, nonatomic) IBOutlet UIImageView *schn_ora_view;
@property (weak, nonatomic) IBOutlet UIImageView *schn_ros_view;
@property (weak, nonatomic) IBOutlet UIImageView *schn_gre_view;
@property (weak, nonatomic) IBOutlet UILabel *gameName;

@property (strong, nonatomic) NSArray * schn_blu_anim;
@property (strong, nonatomic) NSArray * schn_blu_anim_flip;

@property (strong, nonatomic) NSArray * schn_ora_anim;
@property (strong, nonatomic) NSArray * schn_ora_anim_flip;

@property (strong, nonatomic) NSArray * schn_ros_anim;
@property (strong, nonatomic) NSArray * schn_ros_anim_flip;

@property (strong, nonatomic) NSArray * schn_gre_anim;
@property (strong, nonatomic) NSArray * schn_gre_anim_flip;

@property (weak, nonatomic) IBOutlet UIImageView *becher;
@property (weak, nonatomic) IBOutlet UIImageView *w1View;
@property (weak, nonatomic) IBOutlet UIImageView *w2View;

- (void)moveSchnWithID:(int)id;
- (void)setW1withID:(int)id;
- (void)setW2withID:(int)id;

- (void)newgame;

@end
