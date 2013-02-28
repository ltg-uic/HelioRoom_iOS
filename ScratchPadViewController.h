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
    NSMutableArray *planetNameBtns;
    
    NSString *numPlanetNamesStr;

    int numPlanetNameBtns;
    int numPlanetColorBtns;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *planetColorBtns;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *planetNameBtns;

- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)touchUpInsideNewBtn:(UIButton *)sender forEvent:(UIEvent *)event;

@end
