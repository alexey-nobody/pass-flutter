#import "PasskitPlugin.h"
#if __has_include(<passkit/passkit-Swift.h>)
#import <passkit/passkit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "passkit-Swift.h"
#endif

@implementation PasskitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPasskitPlugin registerWithRegistrar:registrar];
}
@end
