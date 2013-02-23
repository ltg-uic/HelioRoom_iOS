//
//  ScratchPadViewController.h
//  HelioRoom
//
//  Created by admin on 1/31/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScratchPadViewController : UIViewController
- (IBAction)objectDragInside:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)objectTouchUpInside:(UIButton *)sender forEvent:(UIEvent *)event;

//HELPER METHODS

-(NSString *)getColor:(NSInteger)tag;
-(NSString *)getColorImage:(NSInteger)tag;

@end
