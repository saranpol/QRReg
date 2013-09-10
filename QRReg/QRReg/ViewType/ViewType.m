//
//  ViewType.m
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "ViewType.h"

#import "QRRViewController.h"

@interface ViewType ()

@end

@implementation ViewType

@synthesize mParent;
@synthesize mTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [mTextField becomeFirstResponder];
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

- (IBAction)clickQR:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [mParent clickCamera:nil];
    }];

}

- (IBAction)clickSubmit:(id)sender {
    [mParent sendCode:mTextField.text];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
