package dev.alpaka.projectathens.admob

import android.content.Context
import android.view.LayoutInflater
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import dev.alpaka.projectathens.databinding.AdDeputyBinding
import dev.alpaka.projectathens.databinding.AdSpeechBinding
import dev.alpaka.projectathens.ext.isInvisible
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class DeputyNativeAdFactory(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView = AdDeputyBinding.inflate(LayoutInflater.from(context)).let { binding ->
        binding.smallAdText.isInvisible = nativeAd.icon == null
        binding.largeAdText.isInvisible = nativeAd.icon != null
        nativeAd.icon?.let { binding.adIcon.setImageDrawable(it.drawable) }

        binding.adHeadline.text = nativeAd.headline
        binding.adBody.text = nativeAd.body

        binding.root.apply {
            iconView = binding.adIcon
            headlineView = binding.adHeadline
            bodyView = binding.adBody
            setNativeAd(nativeAd)
        }
    }
}
