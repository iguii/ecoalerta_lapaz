import 'package:ecoalerta_lapaz/bloc/rain_state.dart';
import 'package:ecoalerta_lapaz/service/rain_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RainCubit extends Cubit<RainState> {
  RainCubit() : super(const RainState());

  void getAcidRainRisk() async {
    try {
      String data = await RainService.getAcidRainRisk();
      emit(state.copyWith(data: data));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void postEnvironmentalData(
    double zone,
    double pm10,
    double no2,
  ) async {
    try {
      String data = await RainService.postEnvironmentalData(zone, pm10, no2);
      emit(state.copyWith(data: data));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
