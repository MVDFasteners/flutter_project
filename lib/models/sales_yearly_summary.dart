class SalesSummaryYearly {
  final String? year;
  final List<String>? months;
  final List<double>? values;
  final double? totalYearly;

  SalesSummaryYearly({this.year, this.months, this.values, this.totalYearly});

  factory SalesSummaryYearly.fromJson(Map<String, dynamic> json) {
    return SalesSummaryYearly(
      year: json['year'] ?? '',
      months: List<String>.from(json['months'] ?? []),
      values: (json['values'] as List)
          .map((e) => (e is num) ? e.toDouble() : 0.0)
          .toList(),
      totalYearly: (json['total_yearly'] ?? 0).toDouble(),
    );
  }
}

class ChartSampleDataModel {
  final String? x;
  final double? y;

  ChartSampleDataModel({this.x, this.y});
}
