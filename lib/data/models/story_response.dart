import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:submision_flutter_intermediate/data/models/story_data.dart';

part 'story_response.freezed.dart';
part 'story_response.g.dart';

@freezed
class StoryResponse with _$StoryResponse {
  factory StoryResponse({
    bool? error,
    String? message,
    @Default([]) List<StoryData> listStory,
  }) = _StoryResponse;

  factory StoryResponse.fromJson(json) => _$StoryResponseFromJson(json);
}
