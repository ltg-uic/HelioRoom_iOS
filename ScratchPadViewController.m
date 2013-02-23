//
//  ScratchPadViewController.m
//  HelioRoom
//
//  Created by admin on 1/31/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import "ScratchPadViewController.h"
#import "AppDelegate.h"

@interface ScratchPadViewController ()

@end

@implementation ScratchPadViewController

- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//EVENT HANDLERS
- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event {
    
    //  NSString * planetName = [self tagToPlanet:sender.tag];
    
    //NSLog(@"drag inside event");
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    sender.center=point;
    
    
    [[self appDelegate] writeDebugMessage:@"drag inside event"];
}

- (IBAction)objectTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event  {
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    NSInteger tag= sender.tag;
    sender.center=point;
    
    
    //Create new button. Done in order to avoid state restoration issues
    UIButton * newPlanet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [newPlanet setTitle:[self getColor:sender.tag] forState:UIControlStateNormal];
    [newPlanet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    newPlanet.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:19];
    [newPlanet setBackgroundImage:[UIImage imageNamed:[self getColorImage:sender.tag]] forState:UIControlStateNormal];
    [newPlanet setFrame:sender.frame];//CGRectMake(0,0,70,70)
    [newPlanet addTarget:self action:@selector(objectDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [newPlanet addTarget:self action:@selector(objectTouchUpInside:forEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [newPlanet setClearsContextBeforeDrawing:YES];
    newPlanet.center=point;
    [self.view addSubview:newPlanet];
  
    //Remove old planet button
//    [[self.view viewWithTag:sender.tag] removeFromSuperview];
    [sender setAlpha:0];

    [newPlanet setTag:sender.tag];

     [[self appDelegate] writeDebugMessage:@"color touch up inside event"];
}

//HELPER METHODS

-(NSString *)getColor:(NSInteger)tag{
    int tagInt =tag;
    //printf("tag is %d\n",tagInt);
    switch (tagInt) {
//        case 1:return @"red";
//        case 2:return @"blue";
//        case 3:return @"yellow";
//        case 4:return @"orange";
//        case 5:return @"brown";
//        case 6:return @"pink";
//        case 7:return @"green";
//        case 8:return @"purple";
        
        case 51:return @"Mercury";
        case 52:return @"Venus";
        case 53:return @"Earth";
        case 54:return @"Mars";
        case 55:return @"Jupiter";
        case 56:return @"Saturn";
        case 57:return @"Uranus";
        case 58:return @"Neptune";
            
        default:
            return @"";
    }
    return @"An error occured in getPlanetImage";
}
-(NSString *)getColorImage:(NSInteger)tag{
    int tagInt =tag;
    //printf("tag is %d\n",tagInt);
    switch (tagInt) {
        case 1:return @"redLg.png";
        case 2:return @"blueLg.png";
        case 3:return @"yellowLg.png";
        case 4:return @"orangeLg.png";
        case 5:return @"brownLg.png";
        case 6:return @"pinkLg.png";
        case 7:return @"greenLg.png";
        case 8:return @"purpleLg.png";
            
        default:
            return @"tag_gray.png";
    }
    return @"An error occured in getPlanetImage";
}
@end
