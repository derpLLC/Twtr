import 'dart:io';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:twtr/environment_config.dart';

final twtrApiProvider = Provider<TwitterApi>((ref) {
  final config = ref.watch(environmentConfigProvider);
  final twtrApi = TwitterApi(
    client: TwitterClient(
      consumerKey: config.apiKey,
      consumerSecret: config.apiKeySecret,
      token: config.accessToken,
      secret: config.accessTokenSecret,
    ),
  );

  return twtrApi;
});

class Failure {
  Failure(this.message);
  final String message;
}

final twitterRepositoryProvider = Provider<TwitterRepository>((ref) {
  final twtrApi = ref.watch(twtrApiProvider);

  return TwitterRepository(twtrApi);
});

class TwitterRepository {
  TwitterRepository(this._twtrApi);
  final TwitterApi _twtrApi;

  Future<Either<Failure, String>> post(String status) async {
    try {
      Tweet tweet = await _twtrApi.tweetService.update(status: status);
      return Right(tweet.fullText as String);
    } on Response catch (response) {
      return Left(Failure(response.reasonPhrase as String));
    } on SocketException catch (_) {
      return Left(Failure('No Internet Connection!'));
    }
  }
}
