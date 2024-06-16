import 'package:mongo_dart/mongo_dart.dart';

class MaintenanceRequest {
  String department;
  String place;
  String issueType;
  String priority;
  String image; // Assuming this stores image path or URL
  String description;
  String submittedBy;

  MaintenanceRequest({
    required this.department,
    required this.place,
    required this.issueType,
    required this.priority,
    required this.image,
    required this.description,
    required this.submittedBy,
  });

  // Convert MaintenanceRequest instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'department': department,
      'place': place,
      'issueType': issueType,
      'priority': priority,
      'image': image,
      'description': description,
      'submittedBy': submittedBy,
    };
  }

  // Create MaintenanceRequest instance from JSON map
  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequest(
      department: json['department'],
      place: json['place'],
      issueType: json['issueType'],
      priority: json['priority'],
      image: json['image'],
      description: json['description'],
      submittedBy: json['submittedBy'],
    );
  }
}
