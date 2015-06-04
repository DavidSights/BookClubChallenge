//
//  Friend.h
//  
//
//  Created by David Seitz Jr on 6/3/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSNumber * friend;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Book *book;

@end
