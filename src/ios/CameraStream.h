#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>


@interface CameraStream : CDVPlugin

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureVideoDataOutput *output;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
@property (nonatomic, strong) NSString* callbackStartId;
@property (nonatomic, strong) NSString* callbackGetDataId;
@property (nonatomic, strong) NSString* base64Data;

- (void)start:(CDVInvokedUrlCommand*)command;
- (void)getData:(CDVInvokedUrlCommand*)command;

@end