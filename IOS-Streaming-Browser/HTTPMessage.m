#import "HTTPMessage.h"


@implementation HTTPMessage


/**
    Initialize the HTTPMessage with an empty message
    returns self as an empty HTTP message
**/
- (id)initEmptyRequest
{
	if ((self = [super init]))
	{
        // Create an empty HTTP message
		message = CFHTTPMessageCreateEmpty(NULL, YES);
	}
	return self;
}

/**
    Initialize a request HTTPMessage with a URL and version
    param NSString
    param NSURL
    param NSString
    returns self (HTTPMessage)
 **/
- (id)initRequestWithMethod:(NSString *)method URL:(NSURL *)url version:(NSString *)version
{
	if ((self = [super init]))
	{
        // Create an http message with a method, url, and version
		message = CFHTTPMessageCreateRequest(NULL, (CFStringRef)method, (CFURLRef)url, (CFStringRef)version);
	}
	return self;
}

/**
    Initialize a response HTTPMessage with a code, description, and version
    param NSSInteger
    param NSString
    param NSSTring
 **/
- (id)initResponseWithStatusCode:(NSInteger)code description:(NSString *)description version:(NSString *)version
{
	if ((self = [super init]))
	{
        // Create an empty HTTP message with a code, description and version 
		message = CFHTTPMessageCreateResponse(NULL, (CFIndex)code, (CFStringRef)description, (CFStringRef)version);
	}
	return self;
}

/**
    Standard deconstructor
 **/
- (void)dealloc
{
	if (message)
	{
		CFRelease(message);
	}
	[super dealloc];
}

/**
    Returns whether can appendData to a message
    param NSData
**/
- (BOOL)appendData:(NSData *)data
{
    // Append date to the HTTP message
	return CFHTTPMessageAppendBytes(message, [data bytes], [data length]);
}

/**
    Whether the header is complete
    returns BOOL
**/
- (BOOL)isHeaderComplete
{
    // Test whether the http message header is complete
	return CFHTTPMessageIsHeaderComplete(message);
}


/**
    Gets the version
    returns NSString
**/
- (NSString *)version
{
	return [NSMakeCollectable(CFHTTPMessageCopyVersion(message)) autorelease];
}


/**
    Gets the method
    returns NSSTring
**/
- (NSString *)method
{
    
	return [NSMakeCollectable(CFHTTPMessageCopyRequestMethod(message)) autorelease];
}


/**
    Gets the url
    returns NSURL
**/
- (NSURL *)url
{
	return [NSMakeCollectable(CFHTTPMessageCopyRequestURL(message)) autorelease];
}


/**
    Gets the status code
    returns NSInteger
**/
- (NSInteger)statusCode
{
    // Returns the status code for the response as an integer
	return (NSInteger)CFHTTPMessageGetResponseStatusCode(message);
}


/**
    Gets a CFDictionary containing all of the header fields.
    returns NSDictionary
**/
- (NSDictionary *)allHeaderFields
{
    // Returns a CFDictionary containing all of the header fields.
	return [NSMakeCollectable(CFHTTPMessageCopyAllHeaderFields(message)) autorelease];
}


/**
    Gets a speicific header field
    param NSString
    returns NSString
**/
- (NSString *)headerField:(NSString *)headerField
{
	return [NSMakeCollectable(CFHTTPMessageCopyHeaderFieldValue(message, (CFStringRef)headerField)) autorelease];
}


/**
    Sets a header field
    param NSString
    param NSString
**/
- (void)setHeaderField:(NSString *)headerField 
                 value:(NSString *)headerFieldValue
{
    
	CFHTTPMessageSetHeaderFieldValue(message, (CFStringRef)headerField, (CFStringRef)headerFieldValue);
}


/**
    Gets the message data
    returns NSData
**/
- (NSData *)messageData
{
    
	return [NSMakeCollectable(CFHTTPMessageCopySerializedMessage(message)) autorelease];
}


/**
    Gets the message body
    returns NSData
**/
- (NSData *)body
{
	return [NSMakeCollectable(CFHTTPMessageCopyBody(message)) autorelease];
}


/**
    Sets the message body
    param NSData
**/
- (void)setBody:(NSData *)body
{
    // Set the message body
	CFHTTPMessageSetBody(message, (CFDataRef)body);
}

@end
