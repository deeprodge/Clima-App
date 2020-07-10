package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import app.loup.geolocation.GeolocationPlugin;
import com.baseflow.flutter.plugin.geolocator.GeolocatorPlugin;
import com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin;
import com.baseflow.location_permissions.LocationPermissionsPlugin;
import app.loup.streams_channel.StreamsChannelPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    GeolocationPlugin.registerWith(registry.registrarFor("app.loup.geolocation.GeolocationPlugin"));
    GeolocatorPlugin.registerWith(registry.registrarFor("com.baseflow.flutter.plugin.geolocator.GeolocatorPlugin"));
    GoogleApiAvailabilityPlugin.registerWith(registry.registrarFor("com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin"));
    LocationPermissionsPlugin.registerWith(registry.registrarFor("com.baseflow.location_permissions.LocationPermissionsPlugin"));
    StreamsChannelPlugin.registerWith(registry.registrarFor("app.loup.streams_channel.StreamsChannelPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
