import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/sales_man.freezed.dart';
part '.generated/sales_man.g.dart';

@freezed
abstract class Salesman with _$Salesman {
  const factory Salesman({
    int? salesmanId,
    required String firstName,
    String? lastName,
    String? email,
    String? contactNumber,
    DateTime? hireDate,
  }) = _Salesman;

  factory Salesman.fromJson(Map<String, dynamic> json) =>
      _$SalesmanFromJson(json);
}
