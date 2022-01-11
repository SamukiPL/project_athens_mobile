import UIKit
import Flutter

import google_mobile_ads

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    let speechNativeAdFactory = SpeechNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        self, factoryId: "speechAd", nativeAdFactory: speechNativeAdFactory)
      let voteNativeAdFactory = VoteNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self, factoryId: "voteAd", nativeAdFactory: voteNativeAdFactory)
      let deputyNativeAdFactory = DeputyNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self, factoryId: "deputyAd", nativeAdFactory: deputyNativeAdFactory)
      let timelineNativeAdFactory = TimelineNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self, factoryId: "timelineAd", nativeAdFactory: timelineNativeAdFactory)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
