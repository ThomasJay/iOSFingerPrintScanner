//
//  ViewController.m
//  FingerPrintScanner
//
//  Created by Tom Jay on 9/7/15.
//  Copyright (c) 2015 Tom Jay. All rights reserved.
//

#import "ViewController.h"
@import LocalAuthentication;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)fingerPrintScanRequestButtonPressed:(id)sender {
    
    LAContext *laContext = [[LAContext alloc] init];

    // Test if fingerprint authentication is available on the device and a fingerprint has been enrolled.
    if ([laContext canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        
        NSLog(@"Fingerprint authentication available.");
        
        laContext.localizedFallbackTitle = @"Enter Password";

        // Perform actual finger print prompt
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Authenticate for use" reply:^(BOOL success, NSError *authenticationError){
            if (success) {
                NSLog(@"Fingerprint validated.");
            }
            else {
                NSLog(@"Fingerprint validation failed: %@.", authenticationError.localizedDescription);
            }
        }];

        
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your device cannot authenticate using TouchID."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    
}

@end
