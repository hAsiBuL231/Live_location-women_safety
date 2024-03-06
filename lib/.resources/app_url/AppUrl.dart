class AppUrl {
  //static const String baseUrl = 'https://track-live-ac5dc.firebaseio.com';

  static const String baseUrl = 'https://firestore.googleapis.com/v1/projects/track-live-ac5dc';

  static const String loginUrl = '$baseUrl/api.login';

  static const String database = '$baseUrl/databases/(default)/documents';

  static const String userCollectionUrl = '$database/User';
}
