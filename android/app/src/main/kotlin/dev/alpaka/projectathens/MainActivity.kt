package dev.alpaka.projectathens

import androidx.annotation.NonNull;
import dev.alpaka.projectathens.admob.DeputyNativeAdFactory
import dev.alpaka.projectathens.admob.SpeechNativeAdFactory
import dev.alpaka.projectathens.admob.TimelineNativeAdFactory
import dev.alpaka.projectathens.admob.VoteNativeAdFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "speechAd", SpeechNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "voteAd", VoteNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "deputyAd", DeputyNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "timelineAd", TimelineNativeAdFactory(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "speechAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "voteAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "deputyAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "timelineAd")
    }
}
