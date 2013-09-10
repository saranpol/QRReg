//
//  ViewSetting.m
//  QRReg
//
//  Created by saranpol on 9/11/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "ViewSetting.h"
#import "API.h"
#import "QRRViewController.h"
#import "APIClientHttp.h"

@interface ViewSetting ()

@end

@implementation ViewSetting

@synthesize mTextField;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    API *a = [API getAPI];
    NSString *host = [a getObject:@"HOST"];
    if(host)
        [mTextField setText:host];
    else
        [mTextField setText:API_HTTP];
}

- (IBAction)clickOK:(id)sender {
    API *a = [API getAPI];
    
    if(mTextField.text){
        [[APIClientHttp sharedClient] setBaseURL:[NSURL URLWithString:mTextField.text]];
        [a saveObject:mTextField.text forKey:@"HOST"];
    }
    
    [self dismissViewControllerAnimated:NO completion:^{
        [mParent clickCamera:nil];
    }];
}

- (IBAction)clickDefault:(id)sender{
    [mTextField setText:API_HTTP];
}

@end
