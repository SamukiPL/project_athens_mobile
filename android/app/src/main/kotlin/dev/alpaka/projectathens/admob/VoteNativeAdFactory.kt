package dev.alpaka.projectathens.admob

import android.content.Context
import android.view.LayoutInflater
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import dev.alpaka.projectathens.databinding.AdVoteBinding
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class VoteNativeAdFactory(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView = AdVoteBinding.inflate(LayoutInflater.from(context)).let { binding ->
        binding.adHeadline.text = nativeAd.headline
        binding.adBody.text = nativeAd.body

        binding.root.apply {
            setNativeAd(nativeAd)
        }
    }
}
