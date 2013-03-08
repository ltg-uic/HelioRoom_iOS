//
//  ScratchPadViewController.h
//  HelioRoom
//
//  Created by admin on 1/31/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchTextField.h"

@interface ScratchPadViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *planetColorBtns;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *planetNameBtns;
@property (strong, nonatomic) NSMutableArray *userTextFields;
@property (strong, nonatomic) NSMutableArray *clearViews;
@property (weak, nonatomic) IBOutlet UIButton *createNewTextFieldBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *trashBtn;

- (IBAction)buttonDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)newTextFieldTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)resetTouchUpInside:(UIButton *)sender;
- (void)textFieldDragInside:(UITextField*)sender forEvent:(UIEvent *)event;
- (void)textFieldTouchDown:(UITextField*)sender;// forEvent:(UIEvent *)event;
- (void)textFieldTouchUpInside:(UITextField*)sender;// forEvent:(UIEvent *)event;

@end

/*
 #import <UIKit/UIKit.h>

@interface ScratchPadViewController : UIViewController
- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)objectTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event;

//HELPER METHODS

-(NSString *)getColor:(NSInteger)tag;
-(NSString *)getColorImage:(NSInteger)tag;

@end
*/