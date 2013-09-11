//
//  QRRViewController.m
//  QRReg
//
//  Created by saranpol on 9/10/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import "QRRViewController.h"
#import "ViewCamera.h"
#import "ViewType.h"
#import "ViewSetting.h"
#import "API.h"
#import <AudioToolbox/AudioToolbox.h>

@interface QRRViewController ()

@end

@implementation QRRViewController

@synthesize mViewCamera;
@synthesize mViewType;
@synthesize mViewSetting;
@synthesize mReader;
@synthesize mLabelName;
@synthesize mLabelPosition;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.hidden = YES;
    
    [mLabelName setFont:[UIFont fontWithName:@"PSLxKittithada-Bold" size:mLabelName.font.pointSize]];
    [mLabelPosition setFont:[UIFont fontWithName:@"PSLxKittithada-Bold" size:mLabelPosition.font.pointSize]];    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.view.hidden == YES)
        [self clickCamera:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickCamera:(id)sender {
    if(!mViewCamera){
        self.mViewCamera = [[ViewCamera alloc] initWithNibName:@"ViewCamera" bundle:nil];
        self.mViewCamera.mParent = self;
    }

    if(!mReader){
        self.mReader = [ZBarReaderViewController new];
        mReader.readerDelegate = self;
        mReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
        ZBarImageScanner *scanner = mReader.scanner;
        // TODO: (optional) additional reader configuration here
    
        // EXAMPLE: disable rarely used I2/5 to improve performance
        [scanner setSymbology: ZBAR_I25
                       config: ZBAR_CFG_ENABLE
                           to: 0];
        mReader.showsCameraControls = NO;  // for UIImagePickerController
        mReader.showsZBarControls = NO;
        mReader.cameraOverlayView = mViewCamera.view;
        mReader.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }

    
    
    // present and release the controller
    [self presentViewController:mReader animated:NO completion:^{
        self.view.hidden = NO;
    }];
}

- (IBAction)clickType:(id)sender {
    if(!mViewType){
        self.mViewType = [[ViewType alloc] initWithNibName:@"ViewType" bundle:nil];
        self.mViewType.mParent = self;
    }
    
    mViewType.mTextField.text = nil;
    [self presentViewController:mViewType animated:NO completion:^{
    }];
    
}

- (IBAction)clickSetting:(id)sender {
    if(!mViewSetting){
        self.mViewSetting = [[ViewSetting alloc] initWithNibName:@"ViewSetting" bundle:nil];
        self.mViewSetting.mParent = self;
    }
    
    [self presentViewController:mViewSetting animated:NO completion:^{
    }];
    
}


- (void)showError {
    [mLabelName setText:@"มีข้อผิดพลาด"];
    [mLabelPosition setText:@"กรุณาลองใหม่อีกครั้ง"];
    AudioServicesPlaySystemSound(1022);
}

- (void)sendCode:(NSString*)code {
    API *a = [API getAPI];
    [mLabelName setText:@"LOADING"];
    [mLabelPosition setText:@"Please wait"];

    [a api_send:code success:^(id JSON){
        NSDictionary *json = (NSDictionary*)JSON;
        
        if(json){
            //NSLog(@"xxx %@",json);
            NSString *show_name;
            NSString *th_name = [json objectForKey:@"TH_NAME"];
            if(th_name && [th_name length] > 0) {
                show_name = [NSString stringWithFormat:@"#%@", th_name];
                show_name = [show_name stringByReplacingOccurrencesOfString:@"#นาย " withString:@"คุณ "];
                show_name = [show_name stringByReplacingOccurrencesOfString:@"#นาง " withString:@"คุณ "];
                show_name = [show_name stringByReplacingOccurrencesOfString:@"#น.ส. " withString:@"คุณ "];
            }else{
                NSString *a = [json objectForKey:@"TITLE"];
                NSString *b = [json objectForKey:@"FIRSTNAME"];
                NSString *c = [json objectForKey:@"LASTNAME"];
                if(!a) a = @"";
                if(!b) b = @"";
                if(!c) c = @"";
                show_name = [NSString stringWithFormat:@"%@%@ %@", a, b, c];
            }
            
            NSString *pos_text = [json objectForKey:@"POS_TEXT"];
            if(!pos_text)
                pos_text = @"-";
            
            [mLabelName setText:show_name];
            [mLabelPosition setText:pos_text];
            AudioServicesPlaySystemSound(1000);
        }else{
            [self showError];
        }
        [self performSelector:@selector(clickCamera:) withObject:nil afterDelay:3.0];
    }failure:^(NSError* failure) {
        [self showError];
        [self performSelector:@selector(clickCamera:) withObject:nil afterDelay:3.0];
    }];
    
}


- (void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info {
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    //mLabelTest.text = symbol.data;
    
    // EXAMPLE: do something useful with the barcode image
//    resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [self sendCode:symbol.data];
    [reader dismissViewControllerAnimated:YES completion:^{
    }];
    
    
}

@end
