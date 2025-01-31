import 'dart:io';

/// HttpHelper is a utility class for managing HttpClient instances.
/// 
/// This helper centralizes the configuration of HttpClient, allowing us to:
/// Bypass SSL Certificate Verification(useful for development when dealing with self-signed certificates).
/// In production, make sure to enable proper SSL validation.
class HttpHelper {
  static HttpClient getHttpClient() {
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}