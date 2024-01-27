import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'map_model.g.dart';

@RestApi(baseUrl: "https://qutb.uz/api")
abstract class RestMap {
  factory RestMap(Dio dio) = _RestMap;

  @POST("/ads")
  Future<Response<dynamic>> saveMap(
    String title,
    String description,
    double lat,
    double lot,
  );
}

@JsonSerializable()
class MapModel {
  String title;
  String description;
  double lat;
  double id;
  DateTime createdAt;
  DateTime updatedAt;

  MapModel({
    required this.title,
    required this.description,
    required this.lat,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
  });


  factory MapModel.fromJson(Map<String, Object?> json) =>
      _$MapModelFromJson(json);

  Map<String, Object?> toJson() => _$MapModelToJson(this);

  MapModel copyWith(
    String? title,
    String? description,
    double? lat,
    double? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  ) =>
      MapModel(
        title: title ?? this.title,
        description: description ?? this.description,
        lat: lat ?? this.lat,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );
}
