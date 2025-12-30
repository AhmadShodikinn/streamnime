abstract class CompleteEvent {}

class FetchCompleteAnimeData extends CompleteEvent {
  final int page;

  FetchCompleteAnimeData(this.page);
}

class FetchMoreCompleteAnimeData extends CompleteEvent {}
