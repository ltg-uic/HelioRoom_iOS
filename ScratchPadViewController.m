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

/*
enum BUTTONS
{
    RED_BTN,
    GREEN_BTN,
    ORANGE_BTN,
    BLUE_BTN,
    PURPLE_BTN,
    BROWN_BTN,
    YELLOW_BTN,
    PINK_BTN,
    MERCURY_BTN,
    VENUS_BTN,
    EARTH_BTN,
    MARS_BTN,
    JUPITER_BTN,
    SATURN_BTN,
    URANUS_BTN,
    NEPTUNE_BTN
};
*/

@end

@implementation ScratchPadViewController

@synthesize planetColorBtns = _planetColorBtns;
@synthesize planetNameBtns = _planetNameBtns;
/*
@synthesize redPlanetBtn = _redPlanetBtn;
@synthesize greenPlanetBtn = _greenPlanetBtn;
@synthesize orangePlanetBtn = _orangePlanetBtn;
@synthesize bluePlanetBtn = _bluePlanetBtn;
@synthesize purplePlanetBtn = _purplePlanetBtn;
@synthesize brownPlanetBtn = _brownPlanetBtn;
@synthesize yellowPlanetBtn = _yellowPlanetBtn;
@synthesize pinkPlanetBtn = _pinkPlanetBtn;
@synthesize mercuryBtn = _mercuryBtn;
@synthesize venusBtn = _venusBtn;
@synthesize earthBtn = _earthBtn;
@synthesize marsBtn = _marsBtn;
@synthesize jupiterBtn = _jupiterBtn;
@synthesize saturnBtn = _saturnBtn;
@synthesize uranusBtn = _uranusBtn;
@synthesize neptuneBtn = _neptuneBtn;
//@synthesize blankBtn = _blankBtn;
*/


- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    numBtns = 16;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self loadDefaultData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self saveDefaultData]; // restore default locations
    
    // synchronize to write defaults
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//EVENT HANDLERS
- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    sender.center=point;
    
    //[[self appDelegate] writeDebugMessage:@"drag inside event"];
    
    // I think we need this here in case user hits the home button or force quits from the multitasking bar
    [self saveDefaultDataForButton:sender];
}

-(void)saveDefaultDataForButton:(UIButton *)sender
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    // saving the position
    NSString *tag = [NSString stringWithFormat:@"%d", [sender tag]];
    NSString *pointString = NSStringFromCGPoint(sender.center);
    [defaults setObject:pointString forKey:tag];
    
    //NSLog(@"ScratchPadViewController saveDefaultDataForButton: %@(%.f,%.f)", tag, sender.center.x, sender.center.y);
}

-(void)loadDefaultDataForButton:(UIButton *)sender
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];

    NSString *tag = [NSString stringWithFormat:@"%d", [sender tag]];
    NSString *pointString = [defaults stringForKey:tag];
    CGPoint savedCenter = CGPointFromString(pointString);
    
    [sender setCenter:savedCenter];
    
    //NSLog(@"ScratchPadViewController loadDefaultDataForButton: getCenter (%.f, %.f)", sender.center.x, sender.center.y);
}

/*
-(void)loadDefaultData
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    for (int i=0; i<numBtns; i++)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", i];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        switch (i)
        {
            case RED_BTN:
                [_redPlanetBtn setCenter:savedCenter];
                break;
            case GREEN_BTN:
                [_greenPlanetBtn setCenter:savedCenter];
                break;
            case ORANGE_BTN:
                [_orangePlanetBtn setCenter:savedCenter];
                break;
            case BLUE_BTN:
                [_bluePlanetBtn setCenter:savedCenter];
                break;
            case PURPLE_BTN:
                [_purplePlanetBtn setCenter:savedCenter];
                break;
            case BROWN_BTN:
                [_brownPlanetBtn setCenter:savedCenter];
                break;
            case YELLOW_BTN:
                [_yellowPlanetBtn setCenter:savedCenter];
                break;
            case PINK_BTN:
                [_pinkPlanetBtn setCenter:savedCenter];
                break;
            case MERCURY_BTN:
                [_mercuryBtn setCenter:savedCenter];
                break;
            case VENUS_BTN:
                [_venusBtn setCenter:savedCenter];
                break;
            case EARTH_BTN:
                [_earthBtn setCenter:savedCenter];
                break;
            case MARS_BTN:
                [_marsBtn setCenter:savedCenter];
                break;
            case JUPITER_BTN:
                [_jupiterBtn setCenter:savedCenter];
                break;
            case SATURN_BTN:
                [_saturnBtn setCenter:savedCenter];
                break;
            case URANUS_BTN:
                [_uranusBtn setCenter:savedCenter];
                break;
            case NEPTUNE_BTN:
                [_neptuneBtn setCenter:savedCenter];
                break;
            default:
                ;//[_redPlanetBtn setCenter:savedCenter];
                break;
        }
        
        NSLog(@"ScratchPadViewController loadDefaultData: getCenter (%.f, %.f)", savedCenter.x, savedCenter.y);
    }
}

-(void)saveDefaultData
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    for (int i=0; i<numBtns; i++)
    {
        // saving the position
        NSString *tag = [NSString stringWithFormat:@"%d", i];
        NSString *pointString;
        
        switch (i)
        {
            case RED_BTN:
                pointString = NSStringFromCGPoint(_redPlanetBtn.center);
                break;
            case GREEN_BTN:
                pointString = NSStringFromCGPoint(_greenPlanetBtn.center);
                break;
            case ORANGE_BTN:
                pointString = NSStringFromCGPoint(_orangePlanetBtn.center);
                break;
            case BLUE_BTN:
                pointString = NSStringFromCGPoint(_bluePlanetBtn.center);
                break;
            case PURPLE_BTN:
                pointString = NSStringFromCGPoint(_purplePlanetBtn.center);
                break;
            case BROWN_BTN:
                pointString = NSStringFromCGPoint(_brownPlanetBtn.center);
                break;
            case YELLOW_BTN:
                pointString = NSStringFromCGPoint(_yellowPlanetBtn.center);
                break;
            case PINK_BTN:
                pointString = NSStringFromCGPoint(_pinkPlanetBtn.center);
                break;
            case MERCURY_BTN:
                pointString = NSStringFromCGPoint(_mercuryBtn.center);
                break;
            case VENUS_BTN:
                pointString = NSStringFromCGPoint(_venusBtn.center);
                break;
            case EARTH_BTN:
                pointString = NSStringFromCGPoint(_earthBtn.center);
                break;
            case MARS_BTN:
                pointString = NSStringFromCGPoint(_marsBtn.center);
                break;
            case JUPITER_BTN:
                pointString = NSStringFromCGPoint(_jupiterBtn.center);
                break;
            case SATURN_BTN:
                pointString = NSStringFromCGPoint(_saturnBtn.center);
                break;
            case URANUS_BTN:
                pointString = NSStringFromCGPoint(_uranusBtn.center);
                break;
            case NEPTUNE_BTN:
                pointString = NSStringFromCGPoint(_neptuneBtn.center);
                break;
            default:
                ;//NSString *pointString = NSStringFromCGPoint(_redPlanetBtn.center);
                break;
        }
        
        NSLog(@"ScratchPadViewController saveDefaultData: getCenter %d(%@)", i, pointString);
        [defaults setObject:pointString forKey:tag];
    }
}
*/

 -(void)saveDefaultData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (UIButton *btn in _planetColorBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = NSStringFromCGPoint(btn.center);
        [defaults setObject:pointString forKey:tag];
        
        //NSLog(@"ScratchPadViewController saveDefaultData: btn %@ (%.f,%.f)", tag, btn.center.x, btn.center.y);
    }
    
    for (UIButton *btn in _planetNameBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = NSStringFromCGPoint(btn.center);
        [defaults setObject:pointString forKey:tag];
        
        //NSLog(@"ScratchPadViewController saveDefaultData: btn %@ (%.f,%.f)", tag, btn.center.x, btn.center.y);
    }
}

-(BOOL)loadDefaultData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (UIButton *btn in _planetColorBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        [btn setCenter:savedCenter];
        //NSLog(@"ScratchPadViewController loadDefaultData: btn %d center(%.f, %.f)", btn.tag, btn.center.x, btn.center.y);
    }
    
    for (UIButton *btn in _planetNameBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        [btn setCenter:savedCenter];
        //NSLog(@"ScratchPadViewController loadDefaultData: btn %d center(%.f, %.f)", btn.tag, btn.center.x, btn.center.y);
    }
    
    return YES;
}


#if 0
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeCGPoint:_redPlanetBtn.center forKey:@"redBtnCtr"];
    NSLog(@"encode: (%.f, %.f)", _redPlanetBtn.center.x, _redPlanetBtn.center.y);
    
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
    _redPlanetBtn.center = [coder decodeCGPointForKey:@"redBtnCtr"];
    NSLog(@"decode: (%.f, %.f)", _redPlanetBtn.center.x, _redPlanetBtn.center.y);
}
#endif
@end
