//
//  QRRViewController.h
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"
@class ViewCamera;
@class ViewType;
@interface QRRViewController : UIViewController <ZBarReaderDelegate>

@property (nonatomic, strong) ViewCamera *mViewCamera;
@property (nonatomic, strong) ViewType *mViewType;
@property (nonatomic, strong) ZBarReaderViewController *mReader;
@property (nonatomic, weak) IBOutlet UILabel *mLabelName;
@property (nonatomic, weak) IBOutlet UILabel *mLabelPosition;

- (void)sendCode:(NSString*)code;
- (IBAction)clickCamera:(id)sender;
- (IBAction)clickType:(id)sender;

@end
