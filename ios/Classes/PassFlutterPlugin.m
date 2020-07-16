#import "PassFlutterPlugin.h"
#if __has_include(<pass_flutter/pass_flutter-Swift.h>)
#import <pass_flutter/pass_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pass_flutter-Swift.h"
#endif

@implementation PassFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPassFlutterPlugin registerWithRegistrar:registrar];
}
@end
