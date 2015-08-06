//
//  ViewController.swift
//  MiloPoC
//
//  Created by James on 8/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var session: LISDKSession!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        LISDKSessionManager.createSessionWithAuth(NSArray(object: LISDK_BASIC_PROFILE_PERMISSION) as [AnyObject], state: nil, showGoToAppStoreDialog: true,
            successBlock: { (returnState) in println("Success called")
                             self.session = LISDKSessionManager.sharedInstance().session
                            println(returnState)
                            self.returnData() },
            errorBlock: { (error) in println("Error called") })
        
        
        /**
        [LISDKSessionManager
            createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, nil]
            state:nil
            showGoToAppStoreDialog:YES
            successBlock:^(NSString *returnState) {
            NSLog(@"%s","success called!");
            LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
            }
            errorBlock:^(LISDKAuthError *error) {
            NSLog(@"%s","error called!");
            }
        ];
*/
    }
    
    func returnData()
    {
        var url = "https://api.linkedin.com/v1/people/~"
        
        if LISDKSessionManager.hasValidSession()
        {
            LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                println(response)
                
                var parseError :NSError? = nil
             
                var jsonData = NSJSONSerialization.JSONObjectWithData(response.data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, options: NSJSONReadingOptions.MutableContainers, error: &parseError)
                
                println(jsonData)
                
                /****
                if (!parseError) {
                    NSString *imageUrl = [jsonData valueForKey:@"pictureUrl"];
                    NSURL *url = [NSURL URLWithString:imageUrl];
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                    [NSURLConnection sendAsynchronousRequest:request
                    queue:[NSOperationQueue mainQueue]
                    completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (!error)
                    {
                    personImage = [[UIImage alloc] initWithData:data];
                    cell.personImage = personImage;
                    cell.imageView.image = cell.personImage;
                    }
                    else
                    {
                    NSLog(@"Error %@",[error description]);
                    }
                    }];
                } else {
                    NSLog(@"parse error %@", parseError);
                }
                ****/
                
                }
                , error: { (apiError) in println(apiError)
                    var errorCode = apiError.code
                    if errorCode == 401 {
                        LISDKSessionManager.clearSession()
                    }  } )
        }
        
        /***
        NSString *url = [NSString initWithString:@"https://api.linkedin.com/v1/people/~"];
        
        if ([LISDKSessionManager hasValidSession]) {
            [[LISDKAPIHelper sharedInstance] getRequest:url
                success:^(LISDKAPIResponse *response) {
                // do something with response
                }
                error:^(LISDKAPIError *apiError) {
                // do something with error
                }];
            ]}
        
        ******/
        
    }

   
}

