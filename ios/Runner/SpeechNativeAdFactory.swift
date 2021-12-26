
import google_mobile_ads

class SpeechNativeAdFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("SpeechNativeAd", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView
        

        (nativeAdView.headlineView as! UILabel).font = UIFont.boldSystemFont(ofSize: 18)
        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline

        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil

        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil

        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        nativeAdView.nativeAd = nativeAd

        return nativeAdView
    }
}
