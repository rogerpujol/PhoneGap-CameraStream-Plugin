#import "CameraStream.h"
#import <Cordova/CDV.h>

@implementation CameraStream

- (void)start:(CDVInvokedUrlCommand*)command
{

	// Create an acceleration object
    NSMutableDictionary* messageProps = [NSMutableDictionary dictionaryWithCapacity:3];

    [messageProps setValue:[NSString stringWithString:@"Alert Title"] forKey:@"Title"];
    [messageProps setValue:[NSString stringWithString:@"Message Title"] forKey:@"Message"];
    [messageProps setValue:[NSString stringWithString:@"Button Title"] forKey:@"Button"];

  	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:messageProps];
  	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end