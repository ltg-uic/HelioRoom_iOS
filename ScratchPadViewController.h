//
//  ScratchPadViewController.h
//  HelioRoom
//
//  Created by admin on 1/31/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScratchPadViewController : UIViewController
/*
- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)objectTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event;

//HELPER METHODS

-(NSString *)getColor:(NSInteger)tag;
-(NSString *)getColorImage:(NSInteger)tag;
*/

{
    NSArray *planetColorBtns;
    NSArray *planetNameBtns;
    NSMutableArray *userTextFields;
    
    NSString *numPlanetNamesStr;

    int numPlanetNameBtns;
    int numPlanetColorBtns;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *planetColorBtns;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *planetNameBtns;
@property (strong, nonatomic) NSMutableArray *userTextFields;
@property (weak, nonatomic) IBOutlet UIButton *createNewTextFieldBtn;

- (IBAction)buttonDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (void)textFieldDragInside:(UITextField*)sender forEvent:(UIEvent *)event;
- (IBAction)newTextFieldTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (void)textFieldTouchDown:(UITextField*)sender forEvent:(UIEvent *)event;
- (void)textFieldTouchUpInside:(UITextField*)sender forEvent:(UIEvent *)event;

@end
