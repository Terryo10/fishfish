import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
    int? count;
    int? pages;
    String? next;
    dynamic prev;

    Info({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

  factory Info.fromJson(Map<String, dynamic> json) =>
      _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}