//
//  PlanetObservationModel.m
//  ios-xmppBase
//
//  Created by Rachel Harsley on 9/27/12.
//  Copyright (c) 2012 Learning Technologies Group. All rights reserved.
//

 //TODO check for conflicting results?

#import "PlanetObservationModel.h"
#import "AppDelegate.h"
//#include "mongo.h"

@implementation PlanetObservationModel


@synthesize reasonDatabase = _reasonDatabase;

const char * mogodbServer = "169.254.225.196"; //set to ip of your mongodbServer
//const char * mogodbServer = "131.193.79.212"; //set to ip of your mongodbServer


- (UIManagedDocument *)reasonDatabase
{
    if(!_reasonDatabase){
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Reason Database"];
        // url is now "<Documents Directory>/Default Photo Database"
        _reasonDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
    }
    return _reasonDatabase;
}
- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Database Functions from Stanford Course
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 4. Stub this out (we didn't implement it at first)
// 13. Create an NSFetchRequest to get all Photographers and hook it up to our table via an NSFetchedResultsController
// (we inherited the code to integrate with NSFRC from CoreDataTableViewController)

//- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
//    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
//    // no predicate because we want ALL the Photographers
//    
//    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
//                                                                        managedObjectContext:self.photoDatabase.managedObjectContext
//                                                                          sectionNameKeyPath:nil
//                                                                                   cacheName:nil];
//}

// 5. Create a Q to fetch Flickr photo information to seed the database
// 6. Take a timeout from this and go create the database model (Photomania.xcdatamodeld)
// 7. Create custom subclasses for Photo and Photographer
// 8. Create a category on Photo (Photo+Flickr) to add a "factory" method to create a Photo
// (go to Photo+Flickr for next step)
// 12. Use the Photo+Flickr category method to add Photos to the database (table will auto update due to NSFRC)

- (void)fetchReasonDataIntoDocument:(UIManagedDocument *)document
{
//    dispatch_queue_t fetchQ = dispatch_queue_create("Reason fetcher", NULL);
//    dispatch_async(fetchQ, ^{
//        NSArray *reasons = [self executeReasonFetch];
//        [document.managedObjectContext performBlock:^{ // perform in the NSMOC's safe thread (main thread)
//            for (NSDictionary *reason in reasons) {
//                [Photo photoWithFlickrInfo:flickrInfo inManagedObjectContext:document.managedObjectContext];
//                // table will automatically update due to NSFetchedResultsController's observing of the NSMOC
//            }
//            // should probably saveToURL:forSaveOperation:(UIDocumentSaveForOverwriting)completionHandler: here!
//            // we could decide to rely on UIManagedDocument's autosaving, but explicit saving would be better
//            // because if we quit the app before autosave happens, then it'll come up blank next time we run
//            // this is what it would look like (ADDED AFTER LECTURE) ...
//            [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
//            // note that we don't do anything in the completion handler this time
//        }];
//    });
//    dispatch_release(fetchQ);
}

// 3. Open or create the document here and call setupFetchedResultsController

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.reasonDatabase.fileURL path]]) {
        // does not exist on disk, so create it
        [self.reasonDatabase saveToURL:self.reasonDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
//            [self setupFetchedResultsController];
            [self fetchReasonDataIntoDocument:self.reasonDatabase];
            
        }];
    } else if (self.reasonDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.reasonDatabase openWithCompletionHandler:^(BOOL success) {
//            [self setupFetchedResultsController];
        }];
    } else if (self.reasonDatabase.documentState == UIDocumentStateNormal) {
        // already open and ready to use
//        [self setupFetchedResultsController];
    }
}

// 2. Make the photoDatabase's setter start using it

- (void)setPhotoDatabase:(UIManagedDocument *)reasonDatabase
{
    if (_reasonDatabase != reasonDatabase) {
        _reasonDatabase = reasonDatabase;
        [self useDocument];
    }
}

-(int)isInFrontOf:(NSString *)planet1:(NSString *)planet2 :(NSString *) reason{
    [self inFrontGroupMessage:planet1 :planet2 :reason];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Submit Successful"
                                                        message:@"Your observation was submitted."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    return 1;
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPP Functions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary *)executeReasonFetch
{
//    query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", query, FlickrAPIKey];
//    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
  
//    NSString * initData= [[self appDelegate] getReasons];
//    
//    
//    NSData *jsonData = [initData encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error = nil;
//    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
//    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
//    // NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
//    
//    return results;
}

-(void)identify:(NSString *)planetColor :(NSString *)planetName:(NSString *) reason{
    
    [self identityGroupMessage:planetColor :planetName:reason];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Submit Successful"
                                                        message:@"Your observation was submitted."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    return;

}

- (void)sendMessage:(NSString *)msg:(NSString *)to{
    [[self appDelegate] sendMessage:msg :to];
}
-(void)sendGroupMessage:(NSString *)msg{
    [[self appDelegate] sendGroupMessage:msg];
}
-(int)inFrontGroupMessage:(NSString *)planet1:(NSString *)planet2:(NSString *) reason{
    return [[self appDelegate] inFrontGroupMessage:planet1:planet2:reason];
}
-(int)identityGroupMessage:(NSString *)planetColor:(NSString *)planetName:(NSString *) reason{
    return [[self appDelegate] identifyGroupMessage:planetColor:planetName:(NSString *) reason];
}
//-(int)orderReasonGroupMessage:(NSString *)reason{
//    return [[self appDelegate] orderReasonGroupMessage:reason];
//}
-(int)theoryReasonGroupMessage:(NSString *)reason{
    return [[self appDelegate] theoryReasonGroupMessage:reason];
}

@end
