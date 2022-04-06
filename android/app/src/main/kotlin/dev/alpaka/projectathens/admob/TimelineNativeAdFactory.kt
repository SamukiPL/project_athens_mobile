package dev.alpaka.projectathens.admob

import android.content.Context
import android.view.LayoutInflater
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import dev.alpaka.projectathens.databinding.AdTimelineBinding
import dev.alpaka.projectathens.databinding.AdVoteBinding
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class TimelineNativeAdFactory(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView = AdTimelineBinding.inflate(LayoutInflater.from(context)).let { binding ->
        binding.adHeadline.text = nativeAd.headline
        binding.adBody.text = nativeAd.body

        binding.root.apply {
            headlineView = binding.adHeadline
            bodyView = binding.adBody
            setNativeAd(nativeAd)
        }
    }
}
