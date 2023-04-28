import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/autogenerated_entity.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  int id;

  MovieDetailCubit({
    required this.id,
  }) : super(const MovieDetailState());

  Future<void> fetchData() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      final responseCast = await ApiService.fetchAutogenerated(id);
      final responDetail = await ApiService.fetchDetail(id);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.success,
          listCast: responseCast.cast,
          detailMovie: responDetail,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }
}
