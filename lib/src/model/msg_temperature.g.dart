// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msg_temperature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MsgTemperature _$MsgTemperatureFromJson(Map<String, dynamic> json) =>
    MsgTemperature(
      (json['temperature'] as num).toDouble(),
    );

Map<String, dynamic> _$MsgTemperatureToJson(MsgTemperature instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
    };
