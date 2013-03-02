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
 NEPTUNE_BTN,
 BLANK_BTN
 };
*/

@end

@implementation ScratchPadViewController

@synthesize planetColorBtns = _planetColorBtns;
@synthesize planetNameBtns = _planetNameBtns;
@synthesize userTextFields = _userTextFields;


/*
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Overriding setters
//

-(void)setUserTextFields:(NSMutableArray*)userTextFields
{
    // make sure we are getting mutable copy so we can add to planetNameBtns
    _userTextFields= [_userTextFields mutableCopy];
}
 */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//
//

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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self initializeDefaultData];
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

- (void)initializeDefaultData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    numPlanetNamesStr = @"numPlanetNameBtns";
    numPlanetColorBtns = 8;
    
    
    // check if first launch
    NSString *hasLaunchedBefore= @"hasLaunchedBefore";
    if ([defaults boolForKey:hasLaunchedBefore] == YES)
    {
        // load default data here after views are created and added (after viewDidLoad)
        // but before they are shown (before viewDidAppear etc))
        [self loadDefaultData];
        
        //NSLog(@"ScratchPadViewController viewDidLayoutSubviews: not the first launch!");
    }
    else
    {
        [defaults setBool:YES forKey:hasLaunchedBefore];
        
        // if it is then save initial center info for all the buttons
        [self saveDefaultData];
        
        // set initial number of planet name buttons
        numPlanetNameBtns = 9;
        [defaults setInteger:numPlanetNameBtns forKey:numPlanetNamesStr];
        
        // write it down
        [defaults synchronize];
        
        //NSLog(@"ScratchPadViewController viewDidLayoutSubviews: First launch!");
    }
    
    // initialize userTextFields array
    //_userTextFields = _userTextFields?_userTextFields:[NSMutableArray array];
    _userTextFields = _userTextFields?_userTextFields:[[NSMutableArray alloc] init];
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Default data handling
// : to ensure that subview (i.e. buttons etc.) information is retained
//   after the Scratch Pad tab is no longer active, app is put in
//   background, or quit
//

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
    
    /*
    for (UITextField *textfield in _userTextFields)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [textfield tag]];
        NSString *pointString = NSStringFromCGPoint(textfield.center);
        [defaults setObject:pointString forKey:tag];
        
        NSLog(@"ScratchPadViewController saveDefaultData: textfield %@ (%.f,%.f)", tag, textfield.center.x, textfield.center.y);
    }*/
}

-(void)loadDefaultData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // get number of buttons
    numPlanetNameBtns = [defaults integerForKey:numPlanetNamesStr];
    
    // load positions for planet color buttons
    for (UIButton *btn in _planetColorBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        [btn setCenter:savedCenter];
        //NSLog(@"ScratchPadViewController loadDefaultData: btn %d center(%.f, %.f)", btn.tag, btn.center.x, btn.center.y);
    }
    
    // load positions for planet name buttons
    for (UIButton *btn in _planetNameBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        [btn setCenter:savedCenter];
        //NSLog(@"ScratchPadViewController loadDefaultData: btn %d center(%.f, %.f)", btn.tag, btn.center.x, btn.center.y);
    }
    
    /*
    // load positions for user-defined textfields
    for (UITextField *textfield in _userTextFields)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [textfield tag]];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        [textfield setCenter:savedCenter];
        NSLog(@"ScratchPadViewController loadDefaultData: textfield %@ (%.f,%.f)", tag, textfield.center.x, textfield.center.y);
    }*/
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Subview creation
//

/*
-(void)addNewBtn:(UIButton*)button
{
    // create a new blank button that user can write a label in
    UIButton *newButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [newButton addTarget:self action:@selector(objectDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [newButton setTitle:@"blah!" forState:UIControlStateNormal];
    newButton.frame = [button frame];
    newButton.tag = numPlanetColorBtns + numPlanetNameBtns;
    [newButton setBackgroundImage:[UIImage imageNamed:@"tag_gray.png"] forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor yellowColor]];
    [_planetNameBtns addObject:newButton];
    
    [self.view addSubview:newButton];
    
    // update user defaults
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setInteger:++numPlanetNameBtns forKey:numPlanetNamesStr];
}
 */

/* create a new blank textfield that user can write a label in
 */
-(void)addNewTextField:(UIButton*)button
{
    NSLog(@"ScratchPadViewController addNewTextField: 1   button frame (%f,%f)", button.center.x, button.center.y);
    UITextField* textfield = [[UITextField alloc] initWithFrame:[button frame]];
    
    [textfield addTarget:self action:@selector(textFieldDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [textfield addTarget:self action:@selector(textFieldTouchDown:forEvent:) forControlEvents:UIControlEventTouchDown];
    [textfield addTarget:self action:@selector(textFieldTouchUpInside:forEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    [textfield setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]];
    [textfield setText:@"blah"];
    [textfield setTag:(numPlanetColorBtns + numPlanetNameBtns)];
    [textfield setBackground:[UIImage imageNamed:@"tag_gray.png"]];
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.textAlignment = NSTextAlignmentCenter;
    
    // add to view
    [self.view addSubview:textfield];
    
    // add to array
    [_userTextFields addObject:textfield];
    NSLog(@"%d userTextFields", [_userTextFields count]);
    
    textfield.userInteractionEnabled = TRUE;    //make text field editable
    [textfield becomeFirstResponder];           //pop up keyboard
    
    NSLog(@"bounds (%.f,%.f) (%.f,%.f)", textfield.bounds.origin.x, textfield.bounds.origin.y, textfield.bounds.size.width, textfield.bounds.size.height);
    
    // update user defaults
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setInteger:++numPlanetNameBtns forKey:numPlanetNamesStr];
}

/* load previously created user-defined textfield
 */
/*
-(void)loadTextField
{
    UITextField* textfield= [[UITextField alloc] initWithFrame:[button frame]];
    
    [textfield addTarget:self action:@selector(objectDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [textfield setText:@"blah"];
    [textfield setTag:(numPlanetColorBtns + numPlanetNameBtns)];
    [textfield setBackground:[UIImage imageNamed:@"tag_gray.png"]];
    [_userTextFields addObject:textfield];
    
    [self.view addSubview:textfield];
    
    //make text field editable
    textfield.userInteractionEnabled = TRUE;
    
    //pop up keyboard
    [textfield becomeFirstResponder];
    
    // update user defaults
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setInteger:++numPlanetNameBtns forKey:numPlanetNamesStr];
}
 */


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Event Handlers
//

- (IBAction)buttonDragInside:(UIButton *)sender forEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    sender.center=point;
    
    [sender setBackgroundColor:[UIColor greenColor]];
    
    //[[self appDelegate] writeDebugMessage:@"drag inside event"];
    NSLog(@"drag inside event for center(%f,%f)", point.x, point.y);
    
    // In case user hits the home button or force quits from the multitasking bar
    [self saveDefaultDataForButton:sender];
}

- (void)textFieldDragInside:(UITextField*)sender forEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    sender.center = point;
    
    [sender setBackgroundColor:[UIColor greenColor]];
    [sender setBackground:[UIImage imageNamed:@"tag_gray1.png"]];
    
    NSLog(@"drag inside event for center(%f,%f)", point.x, point.y);
    
    // In case user hits the home button or force quits from the multitasking bar
    //[self saveDefaultDataForButton:sender];
}

- (IBAction)newTextFieldTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event
{
    [self addNewTextField:sender];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    NSLog(@"%d userTextFields", [_userTextFields count]);
    for (UITextField *textfield in _userTextFields)
    {
        // dismiss keyboard if touch outside of textfield
        if ([textfield isFirstResponder] && [touch view] != textfield)
        {
            [textfield resignFirstResponder];
        }
    }
}

- (void)textFieldTouchDown:(UITextField *)sender forEvent:(UIEvent *)event
{
    NSLog(@"ScratchPadViewController textFieldTouchDown");
    [sender setBackgroundColor:[UIColor greenColor]];
    [sender setBackground:[UIImage imageNamed:@"tag_gray1.png"]];
}

- (void)textFieldTouchUpInside:(UITextField *)sender forEvent:(UIEvent *)event
{
    NSLog(@"ScratchPadViewController textFieldTouchUp");
    [sender setBackgroundColor:[UIColor clearColor]];
    [sender setBackground:[UIImage imageNamed:@"tag_gray.png"]];
    
}


@end




/*//
//  ScratchPadViewController.m
//  HelioRoom
//
//  Created by admin on 1/31/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import "ScratchPadViewController.h"
#import "AppDelegate.h"


@interface ScratchPadViewController ()

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
    NEPTUNE_BTN,
    BLANK_BTN
};

@end

@implementation ScratchPadViewController

@synthesize planetColorBtns = _planetColorBtns;
@synthesize planetNameBtns = _planetNameBtns;


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Overriding setters
//

-(void)setPlanetNameBtns:(NSMutableArray*)planetNameBtns
{
    // make sure we are getting mutable copy so we can add to planetNameBtns
    _planetNameBtns= [_planetNameBtns mutableCopy];
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//
//

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
    
    [self initializeAll];
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

- (void)initializeAll
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    numPlanetNamesStr = @"numPlanetNameBtns";
    numPlanetColorBtns = 8;
    
    // check if first launch
    NSString *hasLaunchedBefore= @"hasLaunchedBefore";
    if ([defaults boolForKey:hasLaunchedBefore] == YES)
    {
        // load default data here after views are created and added (after viewDidLoad)
        // but before they are shown (before viewDidAppear etc))
        [self loadDefaultData];
        
        //NSLog(@"ScratchPadViewController viewDidLayoutSubviews: not the first launch!");
    }
    else
    {
        [defaults setBool:YES forKey:hasLaunchedBefore];
        
        // if it is then save initial center info for all the buttons
        [self saveDefaultData];
        
        // set initial number of planet name buttons
        numPlanetNameBtns = 9;
        [defaults setInteger:numPlanetNameBtns forKey:numPlanetNamesStr];
        
        // write it down
        [defaults synchronize];
        
        //NSLog(@"ScratchPadViewController viewDidLayoutSubviews: First launch!");
    }
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Default data handling
// : to ensure that subview (i.e. buttons etc.) information is retained
//   after the Scratch Pad tab is no longer active, app is put in
//   background, or quit
//

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
    
    // get number of buttons
    numPlanetNameBtns = [defaults integerForKey:numPlanetNamesStr];
    
    // load positions for planet color buttons
    for (UIButton *btn in _planetColorBtns)
    {
        NSString *tag = [NSString stringWithFormat:@"%d", [btn tag]];
        NSString *pointString = [defaults stringForKey:tag];
        CGPoint savedCenter = CGPointFromString(pointString);
        
        [btn setCenter:savedCenter];
        //NSLog(@"ScratchPadViewController loadDefaultData: btn %d center(%.f, %.f)", btn.tag, btn.center.x, btn.center.y);
    }
    
    // load positions for planet name buttons
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

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Subview creation
//

-(void)addNewBtn:(UIButton*)button
{
    // create a new blank button that user can write a label in
    UIButton *newButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [newButton addTarget:self action:@selector(objectDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [newButton setTitle:@"blah!" forState:UIControlStateNormal];
    newButton.frame = [button frame];
    newButton.tag = numPlanetColorBtns + numPlanetNameBtns;
    [newButton setBackgroundImage:[UIImage imageNamed:@"tag_gray.png"] forState:UIControlStateNormal];
    [newButton setBackgroundColor:[UIColor yellowColor]];
    [_planetNameBtns addObject:newButton];
    
    [self.view addSubview:newButton];
    
    // update user defaults
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setInteger:++numPlanetNameBtns forKey:numPlanetNamesStr];
}

-(void)addNewTextField:(UIButton*)button
{
    // create a new blank button that user can write a label in
    UITextField* textfield= [[UITextField alloc] initWithFrame:[button frame]];
    
    [textfield addTarget:self action:@selector(objectDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [textfield setText:@"blah"];
    [textfield setTag:(numPlanetColorBtns + numPlanetNameBtns)];
    [textfield setBackground:[UIImage imageNamed:@"tag_gray.png"]];
    [_planetNameBtns addObject:textfield];
    
    [self.view addSubview:textfield];
    
    //make text field editable
    textfield.userInteractionEnabled = TRUE;
    
    //pop up keyboard
    [textfield becomeFirstResponder];
    
    // update user defaults
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setInteger:++numPlanetNameBtns forKey:numPlanetNamesStr];
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
// Event Handlers
//

- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    sender.center=point;
    
    [sender setBackgroundColor:[UIColor greenColor]];
    
    //[[self appDelegate] writeDebugMessage:@"drag inside event"];
    
    // I think we need this here in case user hits the home button or force quits from the multitasking bar
    [self saveDefaultDataForButton:sender];
}

- (IBAction)touchUpInsideNewBtn:(UIButton *)sender forEvent:(UIEvent *)event
{
    //[self addNewBtn:sender];
    [self addNewTextField:sender];
}



@end
 */
