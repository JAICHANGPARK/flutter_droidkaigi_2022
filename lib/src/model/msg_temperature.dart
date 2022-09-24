import 'package:json_annotation/json_annotation.dart';

part 'msg_temperature.g.dart';

@JsonSerializable()
class MsgTemperature {
  MsgTemperature(this.temperature);

  double temperature;

  factory MsgTemperature.fromJson(Map<String, dynamic> json) => _$MsgTemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$MsgTemperatureToJson(this);
}
