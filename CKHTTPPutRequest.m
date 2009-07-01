/*
 Copyright (c) 2004-2006, Greg Hulands <ghulands@mac.com>
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, 
 are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list 
 of conditions and the following disclaimer.
 
 Redistributions in binary form must reproduce the above copyright notice, this 
 list of conditions and the following disclaimer in the documentation and/or other 
 materials provided with the distribution.
 
 Neither the name of Greg Hulands nor the names of its contributors may be used to 
 endorse or promote products derived from this software without specific prior 
 written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
 SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
 BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY 
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CKHTTPPutRequest.h"
#import "CKAbstractConnection.h"


@implementation CKHTTPPutRequest

- (id)initWithMethod:(NSString *)method uri:(NSString *)uri data:(NSData *)data filename:(NSString *)filename
{
	if ((self = [super initWithMethod:method uri:uri]))
	{
		[myContent appendData:data];
		myFilename = [filename copy];
		
		if (!data)
		{
			NSFileManager *fm = [NSFileManager defaultManager];
			if ([fm fileExistsAtPath:myFilename])
			{
				NSData *fileData = [NSData dataWithContentsOfMappedFile:filename];
				if (fileData)
					myContent = [fileData retain];
			}
		}
		
		NSString *UTI = [(NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
																		  (CFStringRef)[myFilename pathExtension],
																		  NULL) autorelease];
		NSString *mime = [(NSString *)UTTypeCopyPreferredTagWithClass((CFStringRef)UTI, kUTTagClassMIMEType) autorelease];	
		if (!mime || [mime length] == 0)
		{
			mime = @"application/octet-stream";
		}
		
		[self setHeader:mime forKey:@"Content-Type"];
	}
	return self;
}

+ (id)putRequestWithData:(NSData *)data filename:(NSString *)filename uri:(NSString *)uri
{
	return [[[CKHTTPPutRequest alloc] initWithMethod:@"PUT" uri:uri data:data filename:filename] autorelease];
}

+ (id)putRequestWithContentsOfFile:(NSString *)path uri:(NSString *)uri
{
	return [[[CKHTTPPutRequest alloc] initWithMethod:@"PUT" uri:uri data:nil filename:path] autorelease];
}

- (void)dealloc
{
	[myFilename release];
	[super dealloc];
}

- (void)serializeContentWithPacket:(NSMutableData *)packet
{
	
}

#pragma mark -
#pragma mark Immutable Content Protection
- (void)appendContent:(NSData *)data
{
	@throw [NSException exceptionWithName:CKConnectionDomain
								   reason:@"CKDavUploadFileRequest contains immutable content. You cannnot append data to it!"
								 userInfo:nil];
}

- (void)appendContentString:(NSString *)str
{
	@throw [NSException exceptionWithName:CKConnectionDomain
								   reason:@"CKDavUploadFileRequest contains immutable content. You cannnot append data to it!"
								 userInfo:nil];
}

- (void)setContent:(NSData *)data
{
	@throw [NSException exceptionWithName:CKConnectionDomain
								   reason:@"CKDavUploadFileRequest contains immutable content. You cannnot append data to it!"
								 userInfo:nil];
}

- (void)setContentString:(NSString *)str
{
	@throw [NSException exceptionWithName:CKConnectionDomain
								   reason:@"CKDavUploadFileRequest contains immutable content. You cannnot append data to it!"
								 userInfo:nil];
}

@end