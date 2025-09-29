import 'package:streaming_app/src/features/anime/domain/entities/CompleteAnimeEntitiy.dart';
import 'package:streaming_app/src/features/anime/domain/entities/OnGoingAnimeEntity.dart';

class HomeAnimeEntity {
  final List<OnGoingAnimeEntity> onGoingAnime;
  final List<CompleteAnimeEntitiy> completeAnime;

  HomeAnimeEntity({required this.onGoingAnime, required this.completeAnime});
}
