package com.sagar.watchnext

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent
import android.graphics.Color
import android.opengl.Visibility
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.*

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;
import android.view.LayoutInflater;
import android.view.View
import androidx.annotation.NonNull
import androidx.core.view.WindowCompat
import com.google.android.gms.ads.MediaContent
import com.google.android.gms.ads.nativead.MediaView;
import io.flutter.plugin.common.MethodChannel;

class MainActivity: FlutterActivity() {
    override fun onCreate(
            savedInstanceState: Bundle?
    ) {
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }
        super.onCreate(savedInstanceState)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.getPlugins().add(GoogleMobileAdsPlugin())
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample", NativeAdFactoryExample(LayoutInflater.from(this)))

    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample")
    }
}

internal class NativeAdFactoryExample(private var layoutInflater: LayoutInflater?) : NativeAdFactory {


    override fun createNativeAd(@NonNull nativeAd: NativeAd, customOptions: MutableMap<String, Any>): NativeAdView {

        val adView: NativeAdView = layoutInflater?.inflate(R.layout.gnt_medium_template_view, null) as NativeAdView

        adView.headlineView = adView.findViewById(R.id.primary)
        adView.advertiserView = adView.findViewById(R.id.secondary)
        adView.iconView = adView.findViewById(R.id.icon)
        adView.starRatingView = adView.findViewById(R.id.rating_bar)
        adView.bodyView = adView.findViewById(R.id.body)
        adView.mediaView = adView.findViewById(R.id.media_view)
        adView.callToActionView = adView.findViewById(R.id.cta)

        adView.setNativeAd(nativeAd)

        (adView.headlineView as TextView).text = nativeAd.headline

        if (nativeAd.icon != null) {
            (adView.iconView as ImageView).setImageDrawable(nativeAd.icon?.drawable)
        } else {
            (adView.iconView as ImageView).visibility = View.GONE
        }
        (adView.advertiserView as TextView).text = nativeAd.advertiser


        if (nativeAd.starRating != null) {
            (adView.starRatingView as RatingBar).rating = nativeAd?.starRating.toFloat()
        } else {
            (adView.starRatingView as RatingBar).visibility = View.GONE
        }

        (adView.bodyView as TextView).text = nativeAd.body
        (adView.callToActionView as Button).text = nativeAd.callToAction

        return adView
    }
}