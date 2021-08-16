package dev.alpaka.projectathens

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;

class MainApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
    }

    override fun registerWith(registry: PluginRegistry) {

    }
}