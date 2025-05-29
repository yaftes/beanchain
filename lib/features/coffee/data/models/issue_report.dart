class IssueReport {
  String batchId;
  String issueType;
  String description;
  DateTime reportDate;

  IssueReport({
    required this.batchId,
    required this.issueType,
    required this.description,
    required this.reportDate,
  });

  factory IssueReport.createObject(Map<String, dynamic> json) {
    return IssueReport(
      batchId: json["id"],
      issueType: json["issueType"],
      description: json["description"],
      reportDate: json["reportDate"],
    );
  }
}
