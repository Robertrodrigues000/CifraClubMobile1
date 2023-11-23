import 'package:json_annotation/json_annotation.dart';

part 'send_email_to_blocked_song_dto.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class SendEmailToBlockedSongDto {
  final String email;
  final String url;

  SendEmailToBlockedSongDto({required this.email, required this.url});

  Map<String, dynamic> toJson() => _$SendEmailToBlockedSongDtoToJson(this);
}
