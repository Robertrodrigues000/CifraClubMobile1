import 'package:cifraclub/domain/youtube/models/youtube_video.dart';
import 'package:faker/faker.dart';

YouTubeVideo getFakeYouTubeVideo() => YouTubeVideo(
      videoId: faker.jwt.valid(),
      title: faker.animal.name(),
      viewCount: faker.randomGenerator.integer(1000).toString(),
      duration: faker.randomGenerator.integer(1000),
      imageUrl: faker.image.image(),
    );
