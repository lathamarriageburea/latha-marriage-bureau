class UserProfileModel {
  // Account
  final String uid;
  final String email;
  final String role;

  // Personal Details
  final String profileFor;
  final String fullName;
  final String mobileNumber;
  final String gender;
  final String maritalStatus;
  final String dateOfBirth;
  final String age;
  final String height;
  final String religion;
  final String caste;
  final String currentLocation;
  final String motherTongue;

  // Education
  final String qualification;
  final String specialization;
  final String college;

  // Profession
  final String occupation;
  final String company;
  final String annualIncome;
  final String workLocation;

  // Family
  final String fatherName;
  final String fatherOccupation;
  final String motherName;
  final String motherOccupation;
  final String familyType;
  final String nativePlace;
  final int brothers;
  final int sisters;

  // Partner Preferences
  final String preferredAge;
  final String preferredHeight;
  final String preferredReligion;
  final String preferredCaste;
  final String preferredEducation;
  final String preferredOccupation;

  // Photo
  final String photoUrl;

  // Membership
  final String membershipStatus;
  final String membershipPlan;

  // Approval
  final bool profileVisible;
  final String profileStatus;
  final bool isApproved;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.role,

    required this.profileFor,
    required this.fullName,
    required this.mobileNumber,
    required this.gender,
    required this.maritalStatus,
    required this.dateOfBirth,
    required this.age,
    required this.height,
    required this.religion,
    required this.caste,
    required this.currentLocation,
    required this.motherTongue,

    required this.qualification,
    required this.specialization,
    required this.college,

    required this.occupation,
    required this.company,
    required this.annualIncome,
    required this.workLocation,

    required this.fatherName,
    required this.fatherOccupation,
    required this.motherName,
    required this.motherOccupation,
    required this.familyType,
    required this.nativePlace,
    required this.brothers,
    required this.sisters,

    required this.preferredAge,
    required this.preferredHeight,
    required this.preferredReligion,
    required this.preferredCaste,
    required this.preferredEducation,
    required this.preferredOccupation,

    required this.photoUrl,

    required this.membershipStatus,
    required this.membershipPlan,

    required this.profileVisible,
    required this.profileStatus,
    required this.isApproved,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,

      'profileFor': profileFor,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'height': height,
      'religion': religion,
      'caste': caste,
      'currentLocation': currentLocation,
      'motherTongue': motherTongue,

      'qualification': qualification,
      'specialization': specialization,
      'college': college,

      'occupation': occupation,
      'company': company,
      'annualIncome': annualIncome,
      'workLocation': workLocation,

      'fatherName': fatherName,
      'fatherOccupation': fatherOccupation,
      'motherName': motherName,
      'motherOccupation': motherOccupation,
      'familyType': familyType,
      'nativePlace': nativePlace,
      'brothers': brothers,
      'sisters': sisters,

      'preferredAge': preferredAge,
      'preferredHeight': preferredHeight,
      'preferredReligion': preferredReligion,
      'preferredCaste': preferredCaste,
      'preferredEducation': preferredEducation,
      'preferredOccupation': preferredOccupation,

      'photoUrl': photoUrl,

      'membershipStatus': membershipStatus,
      'membershipPlan': membershipPlan,

      'profileVisible': profileVisible,
      'profileStatus': profileStatus,
      'isApproved': isApproved,

      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    };
  }
}