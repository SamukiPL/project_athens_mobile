package dev.alpaka.projectathens.admob

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import dev.alpaka.projectathens.databinding.AdSpeechBinding
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class SpeechNativeAdFactory(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView = AdSpeechBinding.inflate(LayoutInflater.from(context)).let { binding ->
        binding.smallAdText.isInvisible = nativeAd.icon == null
        binding.largeAdText.isInvisible = nativeAd.icon != null
        nativeAd.icon?.let { binding.adIcon.setImageDrawable(it.drawable) }

        binding.adHeadline.text = nativeAd.headline
        binding.adBody.text = nativeAd.body

        binding.root.apply {
            setNativeAd(nativeAd)
        }
    }
}

var View.isInvisible: Boolean
    get() = visibility == View.VISIBLE
    set(value) {
        visibility = if (value) {
            View.VISIBLE
        } else {
            View.GONE
        }
    }
