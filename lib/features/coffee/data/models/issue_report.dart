class IssueReport {
  String batchId;
  String issueType;
  String description;
  DateTime reportDate;
  // i don't what we use for
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
