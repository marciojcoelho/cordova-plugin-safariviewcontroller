#import "SafariViewController.h"

@implementation SafariViewController

- (void) isAvailable:(CDVInvokedUrlCommand*)command {
  bool avail = NSClassFromString(@"SFSafariViewController") != nil;
  CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:avail];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) show:(CDVInvokedUrlCommand*)command {
  // testing safariviewcontroller --> requires an isAvailable function to check if isAtLeastVersion(9)
  NSDictionary* options = [command.arguments objectAtIndex:0];
  NSString* urlString = [options objectForKey:@"url"];
  if (urlString == nil) {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"url can't be empty"] callbackId:command.callbackId];
    return;
  }
  NSURL *url = [NSURL URLWithString:urlString];
  bool readerMode = [[options objectForKey:@"enterReaderModeIfAvailable"] isEqualToNumber:[NSNumber numberWithBool:YES]];

  SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:readerMode];
  vc.delegate = self;
  [self.viewController presentViewController:vc animated:YES completion:nil];
  [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

# pragma mark - SFSafariViewControllerDelegate

@end
