//
//  ChooseInFrontViewController.m
//  ios-xmppBase
//
//  Created by Rachel Harsley on 9/26/12.
//  Copyright (c) 2012 Learning Technologies Group. All rights reserved.
//

#import "NewOrdering.h"
#import "AppDelegate.h"
#import "PlanetObservationModel.h"

@interface NewOrdering ()
@property (nonatomic,strong) PlanetObservationModel *planetModel;
@end

@implementation NewOrdering
@synthesize loginButton =_loginButton;
@synthesize planetModel= _planetModel;
@synthesize dropAreas = _dropAreas;

//TODO one planet in drop Area!!!
//Add X to remove planet

//Bring Large Planet back to original location


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.jpeg"]];
    self.view.backgroundColor = background;
    
//    backPlanetChoseView.userInteractionEnabled=NO;
//    [self.view sendSubviewToBack:backPlanetChoseView];
//    
//    frontPlanetChoseView.userInteractionEnabled=NO;
//    [self.view sendSubviewToBack:frontPlanetChoseView];
    
    for (UIImageView *dropArea in self.dropAreas){
        dropArea.userInteractionEnabled=NO;
//        [self.view sendSubviewToBack:dropArea];
    }
    
    [self.loginButton setTitle:[self.appDelegate getLoggedInUser]forState:UIControlStateNormal];
    NSArray *animationArray=[NSArray arrayWithObjects:
                             [UIImage imageNamed:@"spaceshipSubmitButton1.png"],
                             [UIImage imageNamed:@"spaceshipSubmitButton2.png"],
                             [UIImage imageNamed:@"spaceshipSubmitButton3.png"],
                             [UIImage imageNamed:@"spaceshipSubmitButton4.png"],
                             [UIImage imageNamed:@"spaceshipSubmitButton5.png"],
                             nil];
    //UIImageView *animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,348, 450)];
    self.submitButtonAnimation.animationImages=animationArray;
    self.submitButtonAnimation.animationDuration=1.7;
    self.submitButtonAnimation.animationRepeatCount=1;
    //[self.submitButtonAnimation startAnimating];
    //[self.view addSubview:animationView];
    
    
}

- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (NSMutableArray *) dropAreas{
    if(!_dropAreas) _dropAreas=[[NSMutableArray alloc] initWithObjects:frontPlanetArea,backPlanetArea, nil];
    return _dropAreas;
}
-(PlanetObservationModel *)planetModel{
    if(!_planetModel) _planetModel=[[PlanetObservationModel alloc] init];
    return _planetModel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Event Handlers
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)sendPressed:(id)sender {
    [[self planetModel] sendMessage:msgField.text :toField.text];
}
- (IBAction)sendGroupPressed:(id)sender {
    //[[self planetModel] sendGroupMessage:msgField.text];
    [[self planetModel] isInFrontOf:@"blue" :@"red":@"I'm tired"];
}

- (IBAction)planetTouchDown:(UIButton *)sender forEvent:(UIEvent *)event {
    [[self appDelegate] writeDebugMessage:@"touchdown event"];
    UIControl *control = sender;
    NSString * planetName = [self tagToPlanet:sender.tag];
    
//    [[self getLargePlanetButton:planetName] setAlpha:1];
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
//    [[self getLargePlanetButton:planetName] setAlpha:1];
//    [self getLargePlanetButton:planetName].center=point;
    control.center=point;
}

- (IBAction)planetDragInside:(UIButton *)sender withEvent:(UIEvent *) event {
    UIControl *control = sender;
    NSString * planetName = [self tagToPlanet:sender.tag];
    
//    [[self getLargePlanetButton:planetName] setAlpha:1];
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    control.center = point;
//    [self getLargePlanetButton:planetName].center=point;
    [[self appDelegate] writeDebugMessage:@"drag inside event"];
}

- (IBAction)planetTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event {
    [[self appDelegate] writeDebugMessage:@"touch up inside event"];
    NSString * planetName = [self tagToPlanet:sender.tag];
    UIControl *control = sender;
    BOOL droppedViewInKnownArea = NO;
    int i=1;
    for (UIImageView *dropArea in self.dropAreas){
        CGPoint pointInDropView = [[[event allTouches] anyObject] locationInView:dropArea];
        if ([dropArea pointInside:pointInDropView withEvent:nil]) {
            droppedViewInKnownArea =YES;
            if((i==1 && planetInDropArea1!=nil)
               ||(i==2 && planetInDropArea2!=nil)){
                droppedViewInKnownArea=NO;
            }else{
                control.center = dropArea.center;
                CGRect frame = control.frame;
                [sender setFrame:frame];
                [self planetInDropArea:i planet:sender ];
                [[self appDelegate] writeDebugMessage:@"was in drop area!"];
                control.center = CGPointMake(dropArea.center.x, dropArea.center.y-30);
//                [self getLargePlanetButton:planetName].center=CGPointMake(dropArea.center.x, dropArea.center.y-30);
                control.center=CGPointMake(dropArea.center.x, dropArea.center.y);
            }
        }
        i++;
    }
    if (!droppedViewInKnownArea) {
        if([planetInDropArea1 isEqualToString:planetName] ){
            planetInDropArea1=nil;
            
        }else if([planetInDropArea2 isEqualToString:planetName]){
            planetInDropArea2=nil;
        }
        CGRect frame = sender.frame;
        frame.origin=[self getOriginalPlanetLocation:planetName];
        control.frame =frame;
        [[self appDelegate] writeDebugMessage:@"was not in drop area"];
    }
    [self updateSubmitButton];
    //[self updateIsInFront];
    NSLog(@"PlanetinDropArea1:%@ PlanetInDropArea2:%@ currentTitle:%@",planetInDropArea1,planetInDropArea2,
          planetName);
}

- (IBAction)submitButtonPressed:(id)sender {
    [self createdColorPopover:planetInDropArea1 :planetInDropArea2];
    self.submitButton.userInteractionEnabled=NO;

//    [[self planetModel] isInFrontOf:planetInDropArea1 :planetInDropArea2 :@"because I said so"];
//    self.submitButtonAnimation.alpha=1;
//    [self.submitButtonAnimation startAnimating];
//    [self clearDropAreas];
//    [self unlockPlanets];
//    [self.submitButton setAlpha:0]; 
//    [self.cancelButton setAlpha:0];
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self clearDropAreas];
    [self unlockPlanets];
    [self.submitButton setAlpha:0]; //TODO??
    [self.cancelButton setAlpha:0]; //TODO??
    [self.reasonPopover dismissPopoverAnimated:YES];
}

- (IBAction)loginButtonPressed:(id)sender {
    [[self appDelegate] disconnect];
    [self clearDropAreas];
    [self dismissViewControllerAnimated:YES completion:^(void){
        [[self appDelegate] showLoginView:self];
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Logical Methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) updateIsInFront{
    if(planetInDropArea1!=nil && planetInDropArea2!=nil){
        isInFrontView.alpha=1;
    }else{
        isInFrontView.alpha=0;
    }
    
}
-(void) updateSubmitButton{
    if(planetInDropArea1 !=nil && planetInDropArea2!=nil){
        self.submitButton.alpha=1;
        self.cancelButton.alpha=1;
        [self lockPlanets];

        self.submitButton.userInteractionEnabled=YES;
        self.cancelButton.userInteractionEnabled=YES;

    }else{
        self.submitButton.alpha=0;
        self.cancelButton.alpha=0;
//        self.submitButtonAnimation.alpha=0;
        self.submitButton.userInteractionEnabled=NO;
        self.cancelButton.userInteractionEnabled=NO;
    }
}

- (void) planetInDropArea:(int)dropArea planet:(UIButton *)planet {
    NSString * planetName = [self tagToPlanet:planet.tag];
    
    if(dropArea == 1){//in front dropArea
        planetInDropArea1 =planetName;
        if([planetInDropArea1 isEqualToString:planetInDropArea2]){
//            [backPlanetChoseView setAlpha:0];
            planetInDropArea2=nil;
        }
        
    }else if(dropArea ==2){ //in back drop area
        planetInDropArea2=planetName;
        if([planetInDropArea2 isEqualToString:planetInDropArea1]){
//            [frontPlanetChoseView setAlpha:0];
            planetInDropArea1=nil;
        }
    }
//    [self updateDropView];
}

- (CGPoint) getOriginalPlanetLocation:(NSString *)planet{
    //Have to hard code :(?
    //TODO
    if([planet isEqualToString:@"red"]){
        return CGPointMake(944, 127);
    }
    else if([planet isEqualToString:@"blue"]){
        return CGPointMake(875, 187);
    }else if([planet isEqualToString:@"yellow"]){
        return CGPointMake(867, 439);
    }else if([planet isEqualToString:@"orange"]){
        return CGPointMake(830, 355);
    }else if([planet isEqualToString:@"brown"]){
        return CGPointMake(934, 502);
    }else if([planet isEqualToString:@"pink"]){
        return CGPointMake(830, 267);
    }else if([planet isEqualToString:@"green"]){
        return CGPointMake(924, 372);
    }else if([planet isEqualToString:@"purple"]){
        return CGPointMake(924, 266);
    }else if([planet isEqualToString:@"gray"]){
        return CGPointMake(840, 25);
    }
    else{
        return CGPointMake(0, 0);
    }
}
-(UIButton *)getPlanetButton:(NSString*)planet{
    if([planet isEqualToString:@"red"]){
        return self.redPlanet;
    }else if([planet isEqualToString:@"blue"]){
        return self.bluePlanet;
    }else if([planet isEqualToString:@"yellow"]){
        return self.yellowPlanet;
    }else if([planet isEqualToString:@"orange"]){
        return self.orangePlanet;
    }else if([planet isEqualToString:@"brown"]){
        return self.brownPlanet;
    }else if([planet isEqualToString:@"pink"]){
        return self.pinkPlanet;
    }else if([planet isEqualToString:@"green"]){
        return self.greenPlanet;
    }else if([planet isEqualToString:@"purple"]){
        return self.purplePlanet;
    }else if([planet isEqualToString:@"gray"]){
        return self.grayPlanet;
    }
    else{
        return NULL;
    }
}
//-(UIButton *)getLargePlanetButton:(NSString*)planet{
//    if([planet isEqualToString:@"red"]){
//        return self.redPlanetLg;
//    }else if([planet isEqualToString:@"blue"]){
//        return self.bluePlanetLg;
//    }else if([planet isEqualToString:@"yellow"]){
//        return self.yellowPlanetLg;
//    }else if([planet isEqualToString:@"orange"]){
//        return self.orangePlanetLg;
//    }else if([planet isEqualToString:@"brown"]){
//        return self.brownPlanetLg;
//    }else if([planet isEqualToString:@"pink"]){
//        return self.pinkPlanetLg;
//    }else if([planet isEqualToString:@"green"]){
//        return self.greenPlanetLg;
//    }else if([planet isEqualToString:@"purple"]){
//        return self.purplePlanetLg;
//    }else if([planet isEqualToString:@"gray"]){
//        return self.grayPlanetLg;
//    }
//    else{
//        return NULL;
//    }
//}
-(NSString *)tagToPlanet:(NSInteger)tag{
    if(tag == 11 || tag ==21){
        return @"red";
    }else if (tag ==12 || tag ==22){
        return @"blue";
    }else if (tag ==13 || tag ==23){
        return @"yellow";
    }else if (tag ==14 || tag ==24){
        return @"orange";
    }else if (tag ==15 || tag ==25){
        return @"brown";
    }else if (tag ==16 || tag ==26){
        return @"pink";
    }else if (tag ==17 || tag ==27){
        return @"green";
    }else if (tag ==18 || tag ==28){
        return @"gray";
    }else if (tag ==19 || tag ==29){
        return @"gray";
    }else{
        return @"An error occured in tagToPlanet";
    }
}
-(void) clearDropAreas{
    CGRect frame;
    if(planetInDropArea1!=nil){
//        [self getPlanetButton:planetInDropArea1].center =[self getOriginalPlanetLocation:planetInDropArea1];
        frame.origin=[self getOriginalPlanetLocation:planetInDropArea1];
        [self getPlanetButton:planetInDropArea1].frame =frame;

        [frontPlanetArea setAlpha:1];
    }
    if(planetInDropArea2!=nil){
//        [self getPlanetButton:planetInDropArea2].center =[self getOriginalPlanetLocation:planetInDropArea2];
        
        frame.origin=[self getOriginalPlanetLocation:planetInDropArea2];
        [self getPlanetButton:planetInDropArea2].frame =frame;

        [backPlanetArea setAlpha:1];
    }
    
    planetInDropArea1=nil;
    planetInDropArea2=nil;
    //isInFrontView.alpha=0;
    [self updateSubmitButton];
    
}

-(void) lockPlanets{
    self.redPlanet.userInteractionEnabled=NO;
    self.bluePlanet.userInteractionEnabled=NO;
    self.yellowPlanet.userInteractionEnabled=NO;
    self.orangePlanet.userInteractionEnabled=NO;
    self.pinkPlanet.userInteractionEnabled=NO;
    self.greenPlanet.userInteractionEnabled=NO;
    self.brownPlanet.userInteractionEnabled=NO;
    self.purplePlanet.userInteractionEnabled=NO;
}
-(void) unlockPlanets{
    self.redPlanet.userInteractionEnabled=YES;
    self.bluePlanet.userInteractionEnabled=YES;
    self.yellowPlanet.userInteractionEnabled=YES;
    self.orangePlanet.userInteractionEnabled=YES;
    self.pinkPlanet.userInteractionEnabled=YES;
    self.greenPlanet.userInteractionEnabled=YES;
    self.brownPlanet.userInteractionEnabled=YES;
    self.purplePlanet.userInteractionEnabled=YES;
}

-(void) createdColorPopover:(NSString *)front:(NSString *)back{
    //popover with reasons and delete option.
    //OrderReasonViewController *reasonViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"OrderReason"];
    
    OrderReasonViewController *reasonViewController=[[OrderReasonViewController alloc] initWithStyle:UITableViewStylePlain];
    [reasonViewController setReasons:front :back];
    [reasonViewController.view setNeedsDisplay];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:reasonViewController];
    reasonViewController.delegate=self;
    self.reasonPopover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.reasonPopover.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];
    [self.reasonPopover presentPopoverFromRect:self.submitButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark - OrderReason Popover delegate methods
//Delegate Functions
-(void) cancel{
//    [self.reasonPopover dismissPopoverAnimated:YES];
    [self clearDropAreas];
    [self unlockPlanets];
    [self.submitButton setAlpha:0]; //TODO??
    [self.cancelButton setAlpha:0]; //TODO??
    [self.reasonPopover dismissPopoverAnimated:YES];
}

- (void)reasonSelected:(NSString *)reason:(NSString *) created:(NSString *)destination {
    //TODO Submit reason
    NSLog(@"reason %@ front: %@ back:%@",reason,created,destination);
    [[self planetModel] isInFrontOf:created :destination :reason];
    //[[self planetModel] orderReasonGroupMessage:reason];
    [self.reasonPopover dismissPopoverAnimated:YES];
    
    self.submitButtonAnimation.alpha=1;
    [self.submitButtonAnimation startAnimating];
    [self clearDropAreas];
    [self unlockPlanets];
    [self.submitButton setAlpha:0];
    [self.cancelButton setAlpha:0];
}
@end
