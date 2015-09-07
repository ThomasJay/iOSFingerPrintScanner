//
//  ViewController.m
//  FingerPrintScanner
//
//  Created by Tom Jay on 9/7/15.
//  Copyright (c) 2015 Tom Jay. All rights reserved.
//

#import "ViewController.h"
@import LocalAuthentication;

@interface ViewController () {
    BOOL fingerPrintScannerBusy;
}

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
    
    
    // Filter for multiple clicks
    if (fingerPrintScannerBusy) {
        return;
    }
    
    fingerPrintScannerBusy = YES;
    
    LAContext *laContext = [[LAContext alloc] init];

    // Test if fingerprint authentication is available on the device and a fingerprint has been enrolled.
    if ([laContext canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        
        NSLog(@"Fingerprint authentication available.");
        
        laContext.localizedFallbackTitle = @"Enter Password";

        // Perform actual finger print prompt
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Authenticate for use" reply:^(BOOL success, NSError *authenticationError){
            
            fingerPrintScannerBusy = NO;
            
            if (success) {
                NSLog(@"Fingerprint validated.");
            }
            else {

                NSLog(@"Fingerprint validation failed: %@.", authenticationError.localizedDescription);
                
                switch (authenticationError.code) {
                        
                    case LAErrorUserFallback : {
                            NSLog(@"Failed LAErrorUserFallback");
                        
                        [self performSelectorOnMainThread:@selector(performLoginOnMain) withObject:nil waitUntilDone:NO];
                        }
                        break;
                        
                    case LAErrorUserCancel : {
                            NSLog(@"Failed LAErrorUserCancel");
                        }
                        break;
                        
                    case LAErrorSystemCancel : {
                            NSLog(@"Failed LAErrorSystemCancel");
                        }
                        break;
                        
                    case LAErrorPasscodeNotSet : {
                            NSLog(@"Failed LAErrorPasscodeNotSet");
                        }
                        break;
                
                    case LAErrorTouchIDNotAvailable : {
                            NSLog(@"Failed LAErrorTouchIDNotAvailable");
                        }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled : {
                            NSLog(@"Failed LAErrorTouchIDNotEnrolled");
                        }
                        break;
                        
                    default : {
                        NSLog(@"Failed Unknown Reason");
                        }
                        break;
           
                        
                }
            
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
        
        fingerPrintScannerBusy = NO;

    }
    
    
}

-(void) performLoginOnMain {
    
    [self performSelector:@selector(performLogin) withObject:nil afterDelay:0.3];

}

-(void) performLogin {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Manual Login"
                                                    message:@"Enter Password"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Login", nil];
    
    // General input text
    //    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    // Password secure input field
    // alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    // General text (Login) and secure password field
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alertView show];

}


#pragma UIAlert Delegate

// This is called when the user enters a PIN and clicks Login or Cancel
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // The user clikced Cancel
    if (buttonIndex == 0) {
        NSLog(@"User Canceled");
    }
    
    // The user clicked Login
    if (buttonIndex == 1) {
        // Get the input text
        NSString *userName = [[alertView textFieldAtIndex:0] text];
        NSString *password = [[alertView textFieldAtIndex:1] text];
        
         NSLog(@"User Logged. User Name: %@ Password: %@", userName, password);
        
    }
    
}

@end
