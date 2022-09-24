import 'package:json_annotation/json_annotation.dart';

part 'msg_battery_state.g.dart';

@JsonSerializable()
class MsgBatteryState {
  MsgBatteryState(this.msgHeader, this.current, this.voltage);

  double voltage;
  double current;
  @JsonKey(name: "header")
  MsgHeader msgHeader;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MsgBatteryState.fromJson(Map<String, dynamic> json) => _$MsgBatteryStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MsgBatteryStateToJson(this);
}

@JsonSerializable()
class MsgHeader {
  MsgHeader(this.frameId);

  @JsonKey(name: "frame_id")
  String? frameId;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MsgHeader.fromJson(Map<String, dynamic> json) => _$MsgHeaderFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MsgHeaderToJson(this);
}
