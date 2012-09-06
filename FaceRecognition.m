#import "FaceRecognition.h"

@implementation FaceRecognition
@synthesize authHandlers;

- (FaceRecognition*) initWithKeys:(NSString*)mashapePublicKey mashapePrivateKey:(NSString*)mashapePrivateKey {
	authHandlers = [[NSMutableArray alloc]init];
	[authHandlers addObject: [[MashapeAuth alloc]initWithPublicKey:mashapePublicKey privateKey:mashapePrivateKey]];
	
	return self;
}

- (MashapeResponse*) createAlbum: (NSString*)album {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];
		
	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/album" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) createAlbumWithCallback: (NSString*)album callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];
		
	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/album" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}

- (MashapeResponse*) detect:  files:(NSString*)files urls:(NSString*)urls {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:files forKey:@"files"];[parameters setObject:urls forKey:@"urls"];
		
	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/detect" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) detectWithCallback:  files:(NSString*)files urls:(NSString*)urls callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:files forKey:@"files"];[parameters setObject:urls forKey:@"urls"];
		
	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/detect" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}

- (MashapeResponse*) detect {

	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/detect" parameters:nil authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) detectWithCallback: (id<MashapeDelegate>)callback {

	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/detect" parameters:nil authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}


- (MashapeResponse*) rebuildAlbum: (NSString*)album albumkey:(NSString*)albumkey {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];
		
	id response = [HttpClient doRequest:GET url:@"https://lambda-face-recognition.p.mashape.com/rebuild_album" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) rebuildAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];
		
	NSOperationQueue* response = [HttpClient doRequest:GET url:@"https://lambda-face-recognition.p.mashape.com/rebuild_album" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}

- (MashapeResponse*) recognize: (NSString*)album albumkey:(NSString*)albumkey files:(NSString*)files urls:(NSString*)urls {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];[parameters setObject:files forKey:@"files"];[parameters setObject:urls forKey:@"urls"];
		
	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/recognize" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) recognizeWithCallback: (NSString*)album albumkey:(NSString*)albumkey files:(NSString*)files urls:(NSString*)urls callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];[parameters setObject:files forKey:@"files"];[parameters setObject:urls forKey:@"urls"];
		
	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/recognize" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}

- (MashapeResponse*) recognize: (NSString*)album albumkey:(NSString*)albumkey {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];
		
	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/recognize" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) recognizeWithCallback: (NSString*)album albumkey:(NSString*)albumkey callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];
		
	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/recognize" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}


- (MashapeResponse*) trainAlbum: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid files:(NSString*)files rebuild:(NSString*)rebuild urls:(NSString*)urls {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];[parameters setObject:entryid forKey:@"entryid"];[parameters setObject:files forKey:@"files"];[parameters setObject:rebuild forKey:@"rebuild"];[parameters setObject:urls forKey:@"urls"];
		
	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/album_train" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) trainAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid files:(NSString*)files rebuild:(NSString*)rebuild urls:(NSString*)urls callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];[parameters setObject:entryid forKey:@"entryid"];[parameters setObject:files forKey:@"files"];[parameters setObject:rebuild forKey:@"rebuild"];[parameters setObject:urls forKey:@"urls"];
		
	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/album_train" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}

- (MashapeResponse*) trainAlbum: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];[parameters setObject:entryid forKey:@"entryid"];
		
	id response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/album_train" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) trainAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey entryid:(NSString*)entryid callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];[parameters setObject:entryid forKey:@"entryid"];
		
	NSOperationQueue* response = [HttpClient doRequest:POST url:@"https://lambda-face-recognition.p.mashape.com/album_train" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}


- (MashapeResponse*) viewAlbum: (NSString*)album albumkey:(NSString*)albumkey {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];
		
	id response = [HttpClient doRequest:GET url:@"https://lambda-face-recognition.p.mashape.com/album" parameters:parameters authHandlers:authHandlers encodeJson:YES];
	return response;
}

- (void) viewAlbumWithCallback: (NSString*)album albumkey:(NSString*)albumkey callback:(id<MashapeDelegate>)callback {

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
		[parameters setObject:album forKey:@"album"];[parameters setObject:albumkey forKey:@"albumkey"];
		
	NSOperationQueue* response = [HttpClient doRequest:GET url:@"https://lambda-face-recognition.p.mashape.com/album" parameters:parameters authHandlers:authHandlers encodeJson:YES callback:callback];
	return response;
}

@end
