#import "FsuperPlugin.h"
#if __has_include(<fsuper/fsuper-Swift.h>)
#import <fsuper/fsuper-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fsuper-Swift.h"
#endif

@implementation FsuperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFsuperPlugin registerWithRegistrar:registrar];
}
@end
