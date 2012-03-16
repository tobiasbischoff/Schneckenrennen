//
//  ManualViewController.m
//  Schneckenrennen
//
//  Created by Bischoff Tobias on 15.03.12.
//  Copyright (c) 2012 Tobias Bischoff. All rights reserved.
//

#import "ManualViewController.h"

@interface ManualViewController ()

@end

@implementation ManualViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"formback.png"]]];
    [self setTitle:NSLocalizedString(@"Willkommen beim Schneckenrennen!", @"Titel")];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)losbutton:(id)sender {
    
     [self dismissModalViewControllerAnimated:YES];
}
@end
