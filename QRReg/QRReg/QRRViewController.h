//
//  QRRViewController.h
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"

@interface QRRViewController : UIViewController <ZBarReaderDelegate>

@property (nonatomic, weak) IBOutlet UILabel *mLabelTest;

- (IBAction)clickCamera:(id)sender;

@end
