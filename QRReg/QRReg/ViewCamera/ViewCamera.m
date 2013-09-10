//
//  ViewCamera.m
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "ViewCamera.h"
#import "QRRViewController.h"

@interface ViewCamera ()

@end

@implementation ViewCamera

@synthesize mParent;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickType:(id)sender {
    [mParent.mReader dismissViewControllerAnimated:NO completion:^{
        [mParent clickType:nil];
    }];
}

@end
