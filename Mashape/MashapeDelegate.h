#import "MashapeResponse.h"

@protocol MashapeDelegate <NSObject>
    
@required
-(void)requestCompleted:(MashapeResponse*) response;

@end
