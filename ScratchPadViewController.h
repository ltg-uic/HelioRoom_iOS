//
//  ScratchPadViewController.h
//  HelioRoom
//
//  Created by admin on 1/31/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScratchPadViewController : UIViewController
{
    NSArray *planetColorBtns;
    NSArray *planetNameBtns;
    
    int numBtns;
}

//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *planetColorBtns;
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *planetNameBtns;

@property (weak, nonatomic) IBOutlet UIButton *redPlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *greenPlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *orangePlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *bluePlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *purplePlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *brownPlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *yellowPlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinkPlanetBtn;
@property (weak, nonatomic) IBOutlet UIButton *mercuryBtn;
@property (weak, nonatomic) IBOutlet UIButton *venusBtn;
@property (weak, nonatomic) IBOutlet UIButton *earthBtn;
@property (weak, nonatomic) IBOutlet UIButton *marsBtn;
@property (weak, nonatomic) IBOutlet UIButton *jupiterBtn;
@property (weak, nonatomic) IBOutlet UIButton *saturnBtn;
@property (weak, nonatomic) IBOutlet UIButton *uranusBtn;
@property (weak, nonatomic) IBOutlet UIButton *neptuneBtn;


- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
@end
