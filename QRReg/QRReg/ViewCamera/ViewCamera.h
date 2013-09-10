//
//  ViewCamera.h
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRRViewController;

@interface ViewCamera : UIViewController

@property (nonatomic, assign) QRRViewController *mParent;

- (IBAction)clickType:(id)sender;
- (IBAction)clickLogo:(id)sender;

@end
