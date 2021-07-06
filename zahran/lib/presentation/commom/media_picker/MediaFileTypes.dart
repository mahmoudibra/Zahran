import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class MediaFileTypes extends Enum<String> {
  const MediaFileTypes(String val) : super(val);
  static const MediaFileTypes IMAGE = const MediaFileTypes('image');
  static const MediaFileTypes VIDEO = const MediaFileTypes('video');
  static const MediaFileTypes AUDIO = const MediaFileTypes('audio');
}
