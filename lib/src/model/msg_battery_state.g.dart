// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msg_battery_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MsgBatteryState _$MsgBatteryStateFromJson(Map<String, dynamic> json) =>
    MsgBatteryState(
      MsgHeader.fromJson(json['header'] as Map<String, dynamic>),
      (json['current'] as num).toDouble(),
      (json['voltage'] as num).toDouble(),
    );

Map<String, dynamic> _$MsgBatteryStateToJson(MsgBatteryState instance) =>
    <String, dynamic>{
      'voltage': instance.voltage,
      'current': instance.current,
      'header': instance.msgHeader,
    };

MsgHeader _$MsgHeaderFromJson(Map<String, dynamic> json) => MsgHeader(
      json['frame_id'] as String?,
    );

Map<String, dynamic> _$MsgHeaderToJson(MsgHeader instance) => <String, dynamic>{
      'frame_id': instance.frameId,
    };
