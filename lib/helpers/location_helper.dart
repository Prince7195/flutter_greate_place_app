const GOOGLE_KEY = "GOOGLE_KEY_ENABLE_BILLING";

class LocationHelper {
  static String getLocationPreviewImage(
      {required double long, required double lat}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$GOOGLE_KEY';
  }
}
