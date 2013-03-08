//
//  TouchTextField.m
//  HelioRoom
//
//  Created by LTG on 3/7/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import "TouchTextField.h"

@implementation TouchTextField

@synthesize clearView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        clearView = [[UIView alloc] initWithFrame:frame];
        [clearView setTag:(self.tag+1)];
        [self addSubview:clearView];
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    //NSLog(@"touches=%@,event=%@",touches,event);
    
    /*
    UITouch *touch = [[event allTouches] anyObject];
    //UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:[self superview]];
    
    self.center = location;
     */
    
    [self setBackground:[UIImage imageNamed:@"tag_gray1.png"]];
    
    /*
        if ([self isFirstResponder] && [touch view] != self)
        {
            if ([touch view] == clearView && [touch tapCount] == 2)
            {
                [self becomeFirstResponder];
                NSLog(@"touchesBegan becomeFirstResponder");
            }
        }
     */
    
    /*
        if ([textfield isFirstResponder] && [touch view] != textfield)
        {
            if ([[touch view] tag] == (textfield.tag + 1) && [touch tapCount] == 2)
            {
                [textfield becomeFirstResponder];
            }
        }
     */
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    //NSLog(@"touches=%@,event=%@",touches,event);
    
    UITouch *touch = [[event allTouches] anyObject];
    //UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:[self superview]];
    
    self.center = location;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    [self setBackground:[UIImage imageNamed:@"tag_gray.png"]];
    //NSLog(@"touches=%@,event=%@",touches,event);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
