class SalesTeamSummary {
  final double? totalBilled;
  final List<SalesTeamData>? data;

  SalesTeamSummary({this.totalBilled, this.data});

  factory SalesTeamSummary.fromJson(Map<String, dynamic> json) {
    return SalesTeamSummary(
      totalBilled: (json['total_billed'] ?? 0).toDouble(),
      data: (json['data'] as List<dynamic>)
          .map((e) => SalesTeamData.fromJson(e))
          .toList(),
    );
  }
}

class SalesTeamData {
  final String? salesPersonId;
  final String? salesPersonName;
  final double? totalBilled;
  final double? targetValue;

  SalesTeamData( {this.salesPersonId, this.salesPersonName, this.totalBilled, this.targetValue});

  factory SalesTeamData.fromJson(Map<String, dynamic> json) {
    return SalesTeamData(
      salesPersonId: json['sales_person_id'] ?? '',
      salesPersonName: json['sales_person_name'] ?? '',
      totalBilled: (json['total_billed'] ?? 0).toDouble(),
      targetValue: (json['custom_sales_team_target'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sales_person_id': salesPersonId,
    'sales_person_name': salesPersonName,
    'total_billed': totalBilled,
  };
}
