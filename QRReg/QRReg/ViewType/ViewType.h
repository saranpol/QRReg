//
//  ViewType.h
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRRViewController;

@interface ViewType : UIViewController

@property (nonatomic, assign) QRRViewController *mParent;
@property (nonatomic, weak) IBOutlet UITextField *mTextField;

- (IBAction)clickQR:(id)sender;

@end
