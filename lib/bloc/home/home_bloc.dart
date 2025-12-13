import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/data/repository/home_anime_repository.dart';
import 'package:streaming_app/bloc/home/home_event.dart';
import 'package:streaming_app/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeAnimeRepository homeAnimeRepository;

  HomeBloc(this.homeAnimeRepository) : super(HomeInitial()) {
    on<FetchHomeData>(_onFetchHomeData);
  }

  Future<void> _onFetchHomeData(
    FetchHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final homeData = await homeAnimeRepository.fetchHomeAnimeData();
      emit(HomeLoaded(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
