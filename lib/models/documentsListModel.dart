

// To parse this JSON data, do
//
//     final dashboardOrganizationModel = dashboardOrganizationModelFromJson(jsonString);

import 'dart:convert';

DocumentOrganizationModel documentOrganizationModelFromJson(String str) => DocumentOrganizationModel.fromJson(json.decode(str));

String documentOrganizationModelToJson(DocumentOrganizationModel data) => json.encode(data.toJson());

class DocumentOrganizationModel {
  dynamic reportName;
  DateTime? dateFrom;
  DateTime? dateto;
  List<UplaodedDocument> uplaodedDocuments;
  dynamic createNewDocument;
  dynamic multiplefileupload;
  int organizationid;
  dynamic email;
  dynamic antiforegerytoken;

  DocumentOrganizationModel({
    this.reportName,
    required this.dateFrom,
    required this.dateto,
    required this.uplaodedDocuments,
    this.createNewDocument,
    this.multiplefileupload,
    required this.organizationid,
    this.email,
    this.antiforegerytoken,
  });

  factory DocumentOrganizationModel.fromJson(Map<String, dynamic> json) => DocumentOrganizationModel(
    reportName: json["ReportName"],
    dateFrom: json["DateFrom"] == null ? null : DateTime.parse(json["DateFrom"]),
    dateto: json["Dateto"] == null ? null : DateTime.parse(json["Dateto"]),
    uplaodedDocuments: json["UplaodedDocuments"] == null ? [] : List<UplaodedDocument>.from(json["UplaodedDocuments"].map((x) => UplaodedDocument.fromJson(x))),
    createNewDocument: json["createNewDocument"],
    multiplefileupload: json["multiplefileupload"],
    organizationid: json["Organizationid"],
    email: json["Email"],
    antiforegerytoken: json["antiforegerytoken"],
  );

  Map<String, dynamic> toJson() => {
    "ReportName": reportName,
    "DateFrom": dateFrom?.toIso8601String(),
    "Dateto": dateto?.toIso8601String(),
    "UplaodedDocuments": uplaodedDocuments == null ? [] : List<dynamic>.from(uplaodedDocuments.map((x) => x.toJson())),
    "createNewDocument": createNewDocument,
    "multiplefileupload": multiplefileupload,
    "Organizationid": organizationid,
    "Email": email,
    "antiforegerytoken": antiforegerytoken,
  };
}

class UplaodedDocument {
  int pkFileId;
  String fileType;
  String fileExtenstion;
  String fileName;
  String attachmentLocation;
  String documentText;
  String processStatus;
  int organizationId;
  dynamic organization;
  bool status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String deletedBy;
  String updatedBy;
  String createdBy;

  UplaodedDocument({
    required this.pkFileId,
    required this.fileType,
    required this.fileExtenstion,
    required this.fileName,
    required this.attachmentLocation,
    required this.documentText,
    required this.processStatus,
    required this.organizationId,
    this.organization,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedBy,
    required this.updatedBy,
    required this.createdBy,
  });

  factory UplaodedDocument.fromJson(Map<String, dynamic> json) => UplaodedDocument(
    pkFileId: json["PkFileId"],
    fileType: json["FileType"],
    fileExtenstion: json["FileExtenstion"],
    fileName: json["FileName"],
    attachmentLocation: json["AttachmentLocation"],
    documentText: json["DocumentText"],
    processStatus: json["ProcessStatus"],
    organizationId: json["OrganizationID"],
    organization: json["organization"],
    status: json["Status"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedBy: json["DeletedBy"],
    updatedBy: json["UpdatedBy"],
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "PkFileId": pkFileId,
    "FileType": fileType,
    "FileExtenstion": fileExtenstion,
    "FileName": fileName,
    "AttachmentLocation": attachmentLocation,
    "DocumentText": documentText,
    "ProcessStatus": processStatus,
    "OrganizationID": organizationId,
    "organization": organization,
    "Status": status,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedBy": deletedBy,
    "UpdatedBy": updatedBy,
    "CreatedBy": createdBy,
  };
}
