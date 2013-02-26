//
//  ViewController.m
//  xmppTemplate
//
//  Created by Anthony Perritano on 9/14/12.
//  Copyright (c) 2012 Learning Technologies Group. All rights reserved.
//

#import "RootViewController.h"
#import "SBJson.h"


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //RACHEL TODO. Check if connected. Auto login
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.jpeg"]];
    self.view.backgroundColor = background;
    
    self.appDelegate.xmppBaseNewMessageDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (IBAction)loginPressed:(id)sender {
    [[self appDelegate] showLoginView:self];
}


#pragma mark - XMPP delegate methods

- (void)newMessageReceived:(NSDictionary *)messageContent{
    NSLog(@"newMessageReceived");
    NSString *msg = [messageContent objectForKey:@"msg"];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSError *error = nil;
    NSDictionary *jsonObjects = [jsonParser objectWithString:msg error:&error];
    
    
//    if( jsonObjects != nil){
//        NSString *destination = [jsonObjects objectForKey:@"destination"];
//        
//        
//        NSString *event = [jsonObjects objectForKey:@"event"];
//        
//        if( [event isEqualToString:@"game_reset"] ) {
//            [self resetGame];
//        } else if( [event isEqualToString:@"game_stop"] ) {
//            isRUNNING = NO;
//            isGAME_STOPPED = YES;
//        }
//        
//        if( ! [destination isEqualToString:[self origin]] )
//            return;
//        
//        if( event != nil) {
//            if( [event isEqualToString:@"patch_init_data"]){
//                
//                [[DataStore sharedInstance] resetPlayerCount];
//                
//                NSDictionary *payload = [jsonObjects objectForKey:@"payload"];
//                
//                feedRatio = @([[payload objectForKey:@"feed-ratio"] integerValue]);
//                
//                NSArray *tags = [payload objectForKey:@"tags"];
//                
//                for (NSDictionary *tag in tags) {
//                    
//                    NSString *tagId = [tag objectForKey:@"tag"];
//                    NSString *cluster = [tag objectForKey:@"cluster"];
//                    NSString *color = [tag objectForKey:@"color"];
//                    
//                    [[DataStore sharedInstance] addPlayerWithRFID:tagId withCluster:cluster withColor:color];
//                }
//                
//                [[DataStore sharedInstance] printPlayers];
//                
//                [[DataStore sharedInstance] addPlayerSpacing];
//                
//                
//                
//                //init the graph
//                if( hasGraph) {
//                    [graph reloadData];
//                } else {
//                    hasGraph = YES;
//                    
//                    [self initPlot];
//                }
//                
//                
//            } else if( [event isEqualToString:@"rfid_update"] ){
//                NSDictionary *payload = [jsonObjects objectForKey:@"payload"];
//                
//                
//                NSArray *arrivals = [payload objectForKey:@"arrivals"];
//                NSArray *departures = [payload objectForKey:@"departures"];
//                
//                if( arrivals != nil && arrivals.count > 0 ) {
//                    for (NSString *rfid in arrivals) {
//                        [self addRFID:rfid];
//                    }
//                    
//                    if( (isRUNNING == NO && isGAME_STOPPED == NO)) {
//                        isRUNNING = YES;
//                        [self startTimer];
//                        
//                    }
//                }
//                
//                if( departures != nil && departures.count > 0 ) {
//                    for (NSString *rfid in departures) {
//                        [self sendOutScoreUpdateWith:rfid];
//                        [self resetScoreByRFID: rfid];
//                        [self removeRFID:rfid];
//                        
//                    }
//                }
//            }
//            
//            
//        }
//        
//    }
    
    NSLog(@"message %@", msg);
}


@end
