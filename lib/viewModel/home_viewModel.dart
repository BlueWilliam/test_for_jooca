import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_for_jooca/model/weather.dart';

import '../model/apiStatus.dart';
import '../model/home_service.dart';

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(homeService: ref.read(repositoryProvider));
});

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.homeService,
  });

  final HomeService homeService;

  WeatherData? weatherData;
  Object? errorResponse;

  bool isLoading = false;

  Future<void> fetchData(String location) async {
    isLoading = true;
    errorResponse = null;
    notifyListeners();

    try {
      final obj = await homeService.fetchWeatherData(location);
      if(obj is Success) {
        weatherData = obj.response as WeatherData;
      }else {
        errorResponse = (obj as Failure).errorResponse;
      }
    } catch (exc) {
      errorResponse = 'Error in _fetchData: ${exc.toString()}';
    }

    isLoading = false;
    notifyListeners();
  }
}
