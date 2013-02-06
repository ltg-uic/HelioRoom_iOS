//
//  PlanetObservationModel.m
//  ios-xmppBase
//
//  Created by Rachel Harsley on 9/27/12.
//  Copyright (c) 2012 Learning Technologies Group. All rights reserved.
//

 //TODO check for conflicting results?

#import "PlanetObservationModel.h"
#import "AppDelegate.h"
//#include "mongo.h"

@implementation PlanetObservationModel

const char * mogodbServer = "169.254.225.196"; //set to ip of your mongodbServer
//const char * mogodbServer = "131.193.79.212"; //set to ip of your mongodbServer

-(int)isInFrontOf:(NSString *)planet1:(NSString *)planet2 :(NSString *) reason{
    [self inFrontGroupMessage:planet1 :planet2 :reason];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Submit Successful"
                                                        message:@"Your observation was submitted."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    return 1;
   
    //TODO check for conflicting results or if already submitted?
    
}

-(void)identify:(NSString *)planetColor :(NSString *)planetName:(NSString *) reason{
    
    [self identityGroupMessage:planetColor :planetName:reason];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Submit Successful"
                                                        message:@"Your observation was submitted."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    return;
//    
//    int inDB = [self checkMongoPlanetIdentify:planetColor :planetName];
//    if(inDB == -1){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error checking database."
//                                                            message:@"See console for error details."
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//        return;
//    }else if(inDB == 1){
//        [[self appDelegate] writeDebugMessage:@"Duplicate submission. Will skip."];
//        return;
//    }else{
//        //Save in Database
//        //Send group message
//        
//        int result =[self updateMongoPlanetIdentify:planetColor :planetName];
//        if(result == -1){
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error updating database."
//                                                                message:@"See console for error details."
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//            return;
//        }
//        [self identityGroupMessage:planetColor :planetName];
//        return;
//    }
    
    //TODO check for conflicting results?
}
- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)sendMessage:(NSString *)msg:(NSString *)to{
    [[self appDelegate] sendMessage:msg :to];
}
-(void)sendGroupMessage:(NSString *)msg{
    [[self appDelegate] sendGroupMessage:msg];
}
-(int)inFrontGroupMessage:(NSString *)planet1:(NSString *)planet2:(NSString *) reason{
    return [[self appDelegate] inFrontGroupMessage:planet1:planet2:reason];
}
-(int)identityGroupMessage:(NSString *)planetColor:(NSString *)planetName:(NSString *) reason{
    return [[self appDelegate] identifyGroupMessage:planetColor:planetName:(NSString *) reason];
}
//-(int)orderReasonGroupMessage:(NSString *)reason{
//    return [[self appDelegate] orderReasonGroupMessage:reason];
//}
-(int)theoryReasonGroupMessage:(NSString *)reason{
    return [[self appDelegate] theoryReasonGroupMessage:reason];
}

@end
