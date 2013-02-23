//
//  Reason.h
//  HelioRoom
//
//  Created by admin on 2/6/13.
//  Copyright (c) 2013 Learning Technologies Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reason : NSManagedObject

@property (nonatomic, retain) NSString * backColor;
@property (nonatomic, retain) NSString * frontColor;
@property (nonatomic, retain) NSString * reasonText;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * lastTimestamp;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) NSString * anchor;
@property (nonatomic, retain) NSString * flag;
@property (nonatomic, retain) NSNumber * isReadOnly;

@end
