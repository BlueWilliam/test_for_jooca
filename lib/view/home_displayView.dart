import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utilities.dart';
import '../model/weather.dart';


class DisplayView extends StatelessWidget {
  DisplayView({super.key, required this.weatherData});

  final WeatherData weatherData;

  final DateFormat format = DateFormat("MMM/dd HH:mm");

  @override
  Widget build(BuildContext context) {
    if(weatherData.records.location.isEmpty) {
      return const Center(
        child: Text('No weather data'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthFactor * 15),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final sortedData = weatherData.sortDataByTime();

    return Column(
      children: [
        for (var element in sortedData) ...[
          Padding(padding: EdgeInsets.only(top: heightFactor * 30)),
          _buildWeatherBody(element),
          Padding(padding: EdgeInsets.only(top: heightFactor * 30)),
        ]
      ],
    );
  }

  Widget _buildWeatherBody(Map<String, dynamic> element) {
    final DateFormat format = DateFormat("MMM/dd HH:mm");

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
          Text("${format.format(element["startTime"] ?? "")} - ${format.format(element["endTime"] ?? "")}"),

          Row(
            children: [
              if(element["Wx"] != null) ...[
                Expanded(
                  child: Text("${CommonUtils.getWeatherTitle("Wx")}: ${element["Wx"]}"),
                ),
              ],
              if(element["CI"] != null) ...[
                Expanded(
                  child: Text("${CommonUtils.getWeatherTitle("CI")}: ${element["CI"]}"),
                ),
              ],
            ],
          ),

          Row(
            children: [
              if(element["PoP"] != null) ...[
                Expanded(
                  child: Text("${CommonUtils.getWeatherTitle("PoP")}: ${element["PoP"]}%"),
                ),
              ],
              if(element["MinT"] != null) ...[
                Expanded(
                  child: Text("${CommonUtils.getWeatherTitle("MinT")}: ${element["MinT"]}°C"),
                ),
              ],
              if(element["MaxT"] != null) ...[
                Expanded(
                  child: Text("${CommonUtils.getWeatherTitle("MaxT")}: ${element["MaxT"]}°C"),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

}