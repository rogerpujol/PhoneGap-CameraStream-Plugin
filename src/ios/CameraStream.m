#import "CameraStream.h"
#import <Cordova/CDV.h>

@implementation CameraStream

@synthesize callbackId,base64Data;

- (void)start:(CDVInvokedUrlCommand*)command
{

	NSArray* arguments = command.arguments;
	self.callbackId = command.callbackId;

	// Create an acceleration object
    NSMutableDictionary* messageProps = [NSMutableDictionary dictionaryWithCapacity:3];

    [messageProps setValue:[NSString stringWithString:@"Alert Title"] forKey:@"Title"];
    [messageProps setValue:[NSString stringWithString:@"Message Title"] forKey:@"Message"];
    [messageProps setValue:[NSString stringWithString:@"Button Title"] forKey:@"Button"];

  	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:messageProps];
  	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];


  	self.session = [[AVCaptureSession alloc] init];
	self.session.sessionPreset = AVCaptureSessionPresetPhoto;
 
	self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    [self.session addInput:self.input];

    self.output = [[AVCaptureVideoDataOutput alloc] init];
    [self.output setAlwaysDiscardsLateVideoFrames:YES];
    self.output.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("canvas_camera_queue", NULL);
    
    [self.output setSampleBufferDelegate:(id)self queue:queue]; 
    [self.session addOutput:self.output];
    [self.session startRunning];
    dispatch_release(queue);
    self.videoConnection = [self.output connectionWithMediaType:AVMediaTypeVideo];
    
}

- (void)getData:(CDVInvokedUrlCommand*)command
{
	NSLog ( @"returnBase64Data: %@", self.base64Data );

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.base64Data];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
   
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);

    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    int width = CVPixelBufferGetWidth(imageBuffer);
    int height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image= [UIImage imageWithCGImage:newImage scale:1.0 orientation:UIImageOrientationUp];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString * encodedString  = [imageData base64Encoding];

    self.base64Data = @"data:image/jpeg;base64,";
    self.base64Data = [self.base64Data stringByAppendingString:encodedString];
    
    CGImageRelease(newImage);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
}
@end