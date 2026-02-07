import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo_and_code/fetch_album_network.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'mockito_api_service_test.mocks.dart';

// This annotation is what tells build_runner to generate mocks.
@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockHttpClient();

      // Stub the client.get() method to return a successful response:
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer(
        (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );

      // Call the function under test
      final album = await fetchAlbum(client);

      // Verify it returns an Album instance
      expect(album, isA<Album>());
      expect(album.title, 'mock'); // the title in the JSON we provided
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockHttpClient();

      // Stub the client.get() to return a 404 response:
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      // The fetchAlbum should throw an exception in this case
      expect(fetchAlbum(client), throwsException);
    });
  });
}
