//
//  NewOrdering.h
//  
//
//  Created by Rachel Harsley on 4/30/13.
//  Copyright (c) 2012 Learning Technologies Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderReasonViewController.h"

@interface NewOrdering : UIViewController<OrderReasonDelegate>{
    __weak IBOutlet UITextField *toField;
    __weak IBOutlet UITextView *msgField;
    
    __weak IBOutlet UIImageView *frontPlanetArea;
    __weak IBOutlet UIImageView *backPlanetArea;
    
    UIPopoverController * _reasonPopover;
    
    __weak IBOutlet UIImageView *isInFrontView;
    

    
    NSString * planetInDropArea1;
    NSString * planetInDropArea2;
    
    UIImage * blank;
    
    UIImage *image;
    UIImage *image2;
}

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSMutableArray *dropAreas;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIImageView *submitButtonAnimation;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (retain, nonatomic) UIPopoverController * reasonPopover;


//PLANETS
@property (weak, nonatomic) IBOutlet UIButton *redPlanet;
//@property (weak, nonatomic) IBOutlet UIButton *redPlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *bluePlanet;
//@property (weak, nonatomic) IBOutlet UIButton *bluePlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *yellowPlanet;
//@property (weak, nonatomic) IBOutlet UIButton *yellowPlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *orangePlanet;
//@property (weak, nonatomic) IBOutlet UIButton *orangePlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *brownPlanet;
//@property (weak, nonatomic) IBOutlet UIButton *brownPlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *pinkPlanet;
//@property (weak, nonatomic) IBOutlet UIButton *pinkPlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *greenPlanet;
//@property (weak, nonatomic) IBOutlet UIButton *greenPlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *purplePlanet;
//@property (weak, nonatomic) IBOutlet UIButton *purplePlanetLg;
@property (weak, nonatomic) IBOutlet UIButton *grayPlanet;
//@property (weak, nonatomic) IBOutlet UIButton *grayPlanetLg;



//EVENT HANDLING
- (IBAction)sendPressed:(id)sender;
- (IBAction)sendGroupPressed:(id)sender;
- (IBAction)planetTouchDown:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)planetDragInside:(UIButton *)sender withEvent:(UIEvent *) event;
- (IBAction)planetTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)submitButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;


//LOGICAL METHODS
- (void) updateIsInFront;
-(void) updateSubmitButton;
- (void) planetInDropArea:(int)dropArea planet:(UIButton *)planet;
- (CGPoint) getOriginalPlanetLocation:(NSString *)planet;
-(UIButton *)getPlanetButton:(NSString*)planet;
-(NSString *)tagToPlanet:(NSInteger)tag;
-(void) clearDropAreas;
-(void) unlockPlanets;
-(void) lockPlanets;
-(void) createdColorPopover:(UIButton *)created:(NSString *)destination;

//OthersOrderDelegate METHODS
- (void)addOthersOrder:(NSString *) color:(NSString *) anchor:(NSString *)reason;

@end
