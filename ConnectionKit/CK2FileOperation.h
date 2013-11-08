//
//  CK2FileOperation.h
//  Connection
//
//  Created by Mike on 22/03/2013.
//
//

#import "CK2FileManager.h"


@class CK2Protocol;
@interface CK2FileOperation : NSObject
{
  @private
    CK2FileManager  *_manager;
    NSURL           *_URL;
    NSString        *_descriptionForErrors;
    dispatch_queue_t    _queue;
    
    CK2Protocol     *_protocol;
    
    void    (^_completionBlock)(NSError *);
    void    (^_enumerationBlock)(NSURL *);
    NSURL   *_localURL;
    
    BOOL    _cancelled;
}

- (void)cancel;

@end
