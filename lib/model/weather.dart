import 'dart:convert';

WeatherData weatherDataFromJson(String str) => WeatherData.fromJson(json.decode(str));

String weatherDataToJson(WeatherData data) => json.encode(data.toJson());

class WeatherData {
  String success;
  Result result;
  Records records;

  WeatherData({
    required this.success,
    required this.result,
    required this.records,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    success: json["success"],
    result: Result.fromJson(json["result"]),
    records: Records.fromJson(json["records"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result.toJson(),
    "records": records.toJson(),
  };

  List<Map<String, dynamic>>sortDataByTime() {
    if(records.location.isEmpty) {
      return [];
    }

    Map<DateTime, Map<String, dynamic>> test = {};
    for(var element in records.location.first.weatherElement) {
      for(var timeData in element.time) {
        if(test[timeData.startTime] == null) {
          test[timeData.startTime] = {element.elementName: timeData.parameter.parameterName};
          test[timeData.startTime]!.addEntries([MapEntry("startTime", timeData.startTime)]);
          test[timeData.startTime]!.addEntries([MapEntry("endTime", timeData.endTime)]);
        }else {
          test[timeData.startTime]!.addEntries([MapEntry(element.elementName, timeData.parameter.parameterName)]);
        }
      }
    }

    List<MapEntry<DateTime, Map<String, dynamic>>> sortedEntries = test.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key));

    List<Map<String, dynamic>> resultList = [];
    for (var entry in sortedEntries) {
      resultList.add(entry.value);
    }

    return resultList;
  }
}

class Records {
  String datasetDescription;
  List<Location> location;

  Records({
    required this.datasetDescription,
    required this.location,
  });

  factory Records.fromJson(Map<String, dynamic> json) => Records(
    datasetDescription: json["datasetDescription"],
    location: List<Location>.from(json["location"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datasetDescription": datasetDescription,
    "location": List<dynamic>.from(location.map((x) => x.toJson())),
  };
}

class Location {
  String locationName;
  List<WeatherElement> weatherElement;

  Location({
    required this.locationName,
    required this.weatherElement,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationName: json["locationName"],
    weatherElement: List<WeatherElement>.from(json["weatherElement"].map((x) => WeatherElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "locationName": locationName,
    "weatherElement": List<dynamic>.from(weatherElement.map((x) => x.toJson())),
  };
}

class WeatherElement {
  String elementName;
  List<Time> time;

  WeatherElement({
    required this.elementName,
    required this.time,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
    elementName: json["elementName"],
    time: List<Time>.from(json["time"].map((x) => Time.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "elementName": elementName,
    "time": List<dynamic>.from(time.map((x) => x.toJson())),
  };
}

class Time {
  DateTime startTime;
  DateTime endTime;
  Parameter parameter;

  Time({
    required this.startTime,
    required this.endTime,
    required this.parameter,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    parameter: Parameter.fromJson(json["parameter"]),
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime.toIso8601String(),
    "endTime": endTime.toIso8601String(),
    "parameter": parameter.toJson(),
  };
}

class Parameter {
  String parameterName;
  String? parameterValue;
  String? parameterUnit;

  Parameter({
    required this.parameterName,
    this.parameterValue,
    this.parameterUnit,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
    parameterName: json["parameterName"],
    parameterValue: json["parameterValue"],
    parameterUnit: json["parameterUnit"],
  );

  Map<String, dynamic> toJson() => {
    "parameterName": parameterName,
    "parameterValue": parameterValue,
    "parameterUnit": parameterUnit,
  };
}

class Result {
  String resourceId;
  List<Field> fields;

  Result({
    required this.resourceId,
    required this.fields,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    resourceId: json["resource_id"],
    fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resource_id": resourceId,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  String id;
  String type;

  Field({
    required this.id,
    required this.type,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}
