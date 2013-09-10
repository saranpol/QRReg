//
//  ViewSetting.h
//  QRReg
//
//  Created by saranpol on 9/11/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRRViewController;

@interface ViewSetting : UIViewController

@property (nonatomic, assign) QRRViewController *mParent;
@property (nonatomic, weak) IBOutlet UITextField *mTextField;

- (IBAction)clickOK:(id)sender;
- (IBAction)clickDefault:(id)sender;

@end
