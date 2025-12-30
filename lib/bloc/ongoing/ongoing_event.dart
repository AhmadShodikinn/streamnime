abstract class OngoingEvent {}

class FetchOngoingAnimeData extends OngoingEvent {
  final int page;

  FetchOngoingAnimeData(this.page);
}

class FetchMoreOngoingAnimeData extends OngoingEvent {}
