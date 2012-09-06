#import "Mashape/Mashape.h"

@interface FaceRecognition : NSObject {
	NSMutableArray* authHandlers;
}
@property() NSMutableArray* authHandlers;

- (FaceRecognition*) initWithKeys: (NSString*)mashapePublicKey mashapePrivateKey:(NSString*)mashapePrivateKey;
- (MashapeResponse*) createAlbum: (NSString*)album;
- (void) createAlbumWithCallback: (NSString*)album callback:(id<MashapeDelegate>)callback;
- (MashapeResponse*) detect:  files:(NSString*)files urls:(NSString*)urls;
- (void) detectWithCallback:  files:(NSString*)files urls:(NSString*)urls callback:(id<MashapeDelegate>)callback;
- (MashapeResponse*) detect;
- (void) detectWithCallback: (id<MashapeDelegate>)callback;

- (MashapeResponse*) rebuildAlbum: (NSString*)album albumkey:(NSString*)albumkey;
- (void) rebuildAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey callback:(id<MashapeDelegate>)callback;
- (MashapeResponse*) recognize: (NSString*)album albumkey:(NSString*)albumkey files:(NSString*)files urls:(NSString*)urls;
- (void) recognizeWithCallback: (NSString*)album albumkey:(NSString*)albumkey files:(NSString*)files urls:(NSString*)urls callback:(id<MashapeDelegate>)callback;
- (MashapeResponse*) recognize: (NSString*)album albumkey:(NSString*)albumkey;
- (void) recognizeWithCallback: (NSString*)album albumkey:(NSString*)albumkey callback:(id<MashapeDelegate>)callback;

- (MashapeResponse*) trainAlbum: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid files:(NSString*)files rebuild:(NSString*)rebuild urls:(NSString*)urls;
- (void) trainAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid files:(NSString*)files rebuild:(NSString*)rebuild urls:(NSString*)urls callback:(id<MashapeDelegate>)callback;
- (MashapeResponse*) trainAlbum: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid;
- (void) trainAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid callback:(id<MashapeDelegate>)callback;

- (MashapeResponse*) viewAlbum: (NSString*)album albumkey:(NSString*)albumkey;
- (void) viewAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey callback:(id<MashapeDelegate>)callback;

@end

