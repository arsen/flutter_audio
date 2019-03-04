#import "FlutterAudioPlugin.h"
#import <flutter_audio/flutter_audio-Swift.h>

@implementation FlutterAudioPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAudioPlugin registerWithRegistrar:registrar];
}
@end
