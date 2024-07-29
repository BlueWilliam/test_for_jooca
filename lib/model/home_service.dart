import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_for_jooca/model/weather.dart';

import 'apiStatus.dart';
import '../constant.dart';


final repositoryProvider = Provider<HomeService>((_) => HomeServiceImpl());

abstract class HomeService{
  Future<Object> fetchWeatherData(String location);
}

class HomeServiceImpl extends HomeService {
  final Dio _dio = Dio();

  @override
  Future<Object> fetchWeatherData(String location) async {
    final Map<String, dynamic> queryParameters = {
      'Authorization': apiKey,
      'locationName': location,
      'sort': 'time',
    };

    try {
      await Future.delayed(const Duration(seconds: 5));
      final response = await _dio.get(kWeatherUrl, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final weatherData = weatherDataFromJson(json.encode(response.data));
        return Success(response: weatherData);
      } else {
        return Failure(code: response.statusCode, errorResponse: response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Failure(errorResponse: 'Error: ${e.response?.statusCode}, Data: ${e.response?.data}');
      } else {
        return Failure(errorResponse: 'Error: ${e.message}');
      }
    }
  }
}