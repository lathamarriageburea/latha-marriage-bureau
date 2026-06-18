import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile_model.dart';
import '../services/registration_service.dart';
import '../widgets/personal_details_step.dart';
import '../widgets/education_step.dart';
import '../widgets/family_details_step.dart';
import '../widgets/profession_step.dart';
import '../widgets/partner_preferences_step.dart';
import '../widgets/photo_upload_step.dart';
//import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class RegistrationWizard extends StatefulWidget {
  const RegistrationWizard({super.key});

  @override
  State<RegistrationWizard> createState() =>
      _RegistrationWizardState();
}

class _RegistrationWizardState
    extends State<RegistrationWizard> {

  int currentStep = 0;

  // PERSONAL
  final fullNameController =
      TextEditingController();

  final mobileNumberController =
    TextEditingController();

  final dobController =
      TextEditingController();

  final casteController =
      TextEditingController();
  
  final currentLocationController =
    TextEditingController();

  String? profileFor;
  String? gender;
  String? maritalStatus;
  String? religion;
  String? motherTongue;
  String? height;

  // EDUCATION
  String? qualification;

  final specializationController =
      TextEditingController();

  final collegeController =
      TextEditingController();

  // PROFESSION
  final occupationController =
      TextEditingController();

  final companyController =
      TextEditingController();

  final incomeController =
      TextEditingController();

  final workLocationController =
      TextEditingController();

  // FAMILY
  final fatherNameController =
      TextEditingController();

  final fatherOccupationController =
      TextEditingController();

  final motherNameController =
      TextEditingController();

  final motherOccupationController =
      TextEditingController();

  final brothersController =
      TextEditingController();

  final sistersController =
      TextEditingController();

  final nativePlaceController =
      TextEditingController();

  String? familyType;

  // PARTNER PREFERENCES
  final ageFromController =
      TextEditingController();

  final ageToController =
      TextEditingController();

  final preferredCasteController =
      TextEditingController();

  final preferredEducationController =
      TextEditingController();

  final preferredOccupationController =
      TextEditingController();

  String? preferredHeight;
  String? preferredReligion;
  String? profilePhotoPath;
  Uint8List? profilePhotoBytes;

  bool validateStep1() {
  if (profileFor == null) return false;
  final fullName =
    fullNameController.text.trim();

if (fullName.isEmpty) {
  return false;
}

if (!RegExp(r"^[a-zA-Z ]+$")
    .hasMatch(fullName)) {
  return false;
}

  final mobile =
    mobileNumberController.text.trim();

if (mobile.isEmpty) {
  return false;
}

if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
  return false;
}

  if (gender == null) return false;
  if (dobController.text.trim().isEmpty) {
  return false;
}

final dobParts =
    dobController.text.split('/');

final birthYear =
    int.parse(dobParts[2]);

final age =
    DateTime.now().year - birthYear;

if (age < 18 || age > 70) {
  return false;
}
  if (height == null) return false;
  if (maritalStatus == null) return false;
  if (religion == null) return false;
  if (motherTongue == null) return false;

if (currentLocationController.text
    .trim()
    .isEmpty) {
  return false;
}



  final caste =
    casteController.text.trim();

if (caste.isEmpty) {
  return false;
}

if (!RegExp(r"^[a-zA-Z ]+$")
    .hasMatch(caste)) {
  return false;
}

  return true;
}

bool validateStep2() {
  if (qualification == null) return false;
  final college =
    collegeController.text.trim();

if (college.isEmpty) {
  return false;
}

if (college.length < 3) {
  return false;
}

  return true;
}

bool validateStep3() {
  if (familyType == null) {
    return false;
  }
  return true;
}

bool validateStep4() {
  if (occupationController.text.trim().isEmpty) return false;
  if (workLocationController.text.trim().isEmpty) return false;

  return true;
}

bool validateStep5() {

  if (ageFromController.text.isNotEmpty &&
      ageToController.text.isNotEmpty) {

    final ageFrom =
        int.tryParse(
          ageFromController.text,
        );

    final ageTo =
        int.tryParse(
          ageToController.text,
        );

    if (ageFrom == null ||
        ageTo == null) {
      return false;
    }

    if (ageFrom > ageTo) {
      return false;
    }
  }

  return true;
}

bool validateStep6() {
  return profilePhotoPath != null;
}

void showValidationError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

  Future<void> nextStep() async {

  if (currentStep == 0) {
    if (!validateStep1()) {
      showValidationError(
        'Please complete all mandatory Personal Details fields.',
      );
      return;
    }
  }

  if (currentStep == 1) {
    if (!validateStep2()) {
      showValidationError(
        'Please complete Education Details.',
      );
      return;
    }
  }

  if (currentStep == 2) {
    if (!validateStep3()) {
      showValidationError(
        'Please complete Family Details.',
      );
      return;
    }
  }

  if (currentStep == 3) {
    if (!validateStep4()) {
      showValidationError(
        'Please complete Profession Details.',
      );
      return;
    }
  }

  if (currentStep == 4) {
    if (!validateStep5()) {
      showValidationError(
        'Please complete Partner Preferences.',
      );
      return;
    }
  }

  if (currentStep < 5) {
  setState(() {
    currentStep++;
  });
} else {

  if (!validateStep6()) {
    showValidationError(
      'Please upload a profile photo.',
    );
    return;
  }

  await submitProfile();
}
}

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

 Future<void> pickPhoto() async {
  final result =
      await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true,
  );

  if (result == null) return;

  setState(() {
    profilePhotoPath =
        result.files.single.name;

    profilePhotoBytes =
        result.files.single.bytes;
  });
}


  Future<void> submitProfile() async {
  try {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      showValidationError(
        'User not logged in.',
      );
      return;
    }

    if (profilePhotoBytes == null) {
      showValidationError(
        'Please upload profile photo.',
      );
      return;
    }
    

    final registrationService =
        RegistrationService();

    

final dobParts =
    dobController.text.split('/');

final birthYear =
    int.parse(dobParts[2]);

final calculatedAge =
    DateTime.now().year - birthYear;

final photoUrl = '';
    final profile = UserProfileModel(
  uid: user.uid,
  email: user.email ?? '',

  role: user.email == 'lathamarriagebureau@gmail.com'
      ? 'admin'
      : 'member',

  profileFor: profileFor ?? '',

  mobileNumber:
      mobileNumberController.text.trim(),

  fullName:
      fullNameController.text.trim(),

  gender: gender ?? '',

  maritalStatus:
      maritalStatus ?? '',

  dateOfBirth:
      dobController.text.trim(),

  age: calculatedAge.toString(),

  height: height ?? '',

  religion: religion ?? '',

  caste:
      casteController.text.trim(),

  currentLocation:
      currentLocationController.text.trim(),

  motherTongue:
      motherTongue ?? '',

  qualification:
      qualification ?? '',

  specialization:
      specializationController.text.trim(),

  college:
      collegeController.text.trim(),

  occupation:
      occupationController.text.trim(),

  company:
      companyController.text.trim(),

  annualIncome:
      incomeController.text.trim(),

  workLocation:
      workLocationController.text.trim(),

  fatherName:
      fatherNameController.text.trim(),

  fatherOccupation:
      fatherOccupationController.text.trim(),

  motherName:
      motherNameController.text.trim(),

  motherOccupation:
      motherOccupationController.text.trim(),

  familyType:
      familyType ?? '',

  nativePlace:
      nativePlaceController.text.trim(),

  brothers:
      int.tryParse(
            brothersController.text,
          ) ??
          0,

  sisters:
      int.tryParse(
            sistersController.text,
          ) ??
          0,

  preferredAge:
      "${ageFromController.text}-${ageToController.text}",

  preferredHeight:
      preferredHeight ?? '',

  preferredReligion:
      preferredReligion ?? '',

  preferredCaste:
      preferredCasteController.text.trim(),

  preferredEducation:
      preferredEducationController.text.trim(),

  preferredOccupation:
      preferredOccupationController.text.trim(),

  photoUrl: photoUrl,

  membershipStatus: 'Free',
  membershipPlan: 'None',

  profileVisible: false,
  profileStatus: 'Pending',
  isApproved: false,
);

    await registrationService
        .saveProfile(profile);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text(
      'Profile saved successfully ✓',
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.green,
    margin: EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
);
  } catch (e) {
    showValidationError(
      e.toString(),
    );
  }
}

 @override
Widget build(BuildContext context) {

  final stepTitles = [
    'Personal Details',
    'Education',
    'Family Details',
    'Profession',
    'Partner Preferences',
    'Photo Upload',
  ];

  return Scaffold(
    backgroundColor:
        const Color(0xFFFAF5F2),

    appBar: AppBar(
  backgroundColor:
      const Color(0xFF8B002E),

  elevation: 0,

  centerTitle: true,

  iconTheme:
      const IconThemeData(
    color: Colors.white,
  ),

  title: const Text(
    'Profile Registration',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  ),
),

    body: Column(
      children: [

        Container(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            children: [

              Column(
  children: [

    const Icon(
      Icons.favorite,
      color: Color(0xFF8B002E),
      size: 32,
    ),

    const SizedBox(
      height: 8,
    ),

    Text(
      stepTitles[currentStep],
      style: const TextStyle(
        fontSize: 30,
        fontWeight:
            FontWeight.bold,
        color:
            Color(0xFF8B002E),
      ),
    ),

    const SizedBox(
      height: 6,
    ),

    const Text(
      'Complete your matrimonial profile',
      style: TextStyle(
        color: Colors.grey,
      ),
    ),
  ],
),

              const SizedBox(
                height: 12,
              ),

              SizedBox(
  width: 500,

  child: ClipRRect(
    borderRadius:
        BorderRadius.circular(
      20,
    ),

    child:
        LinearProgressIndicator(
                  minHeight: 10,

                  value:
                      (currentStep + 1) / 6,

                  backgroundColor:
                      Color(0xFFE7DCCF),

                  valueColor:
                      AlwaysStoppedAnimation(
                    Color(0xFF8B002E),
                  ),
                ),
              ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                'Step ${currentStep + 1} of 6',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        Expanded(
  child: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 10,
    ),
    child: Column(
      children: [

        if (currentStep == 0)
          PersonalDetailsStep(
            fullNameController:
                fullNameController,
            mobileNumberController:
                mobileNumberController,
            dobController:
                dobController,
            casteController:
                casteController,
            currentLocationController:
                currentLocationController,
            profileFor: profileFor,
            gender: gender,
            maritalStatus:
                maritalStatus,
            religion: religion,
            height: height,
            motherTongue:
                motherTongue,
            onProfileForChanged:
                (value) {
              setState(() {
                profileFor = value;
              });
            },
            onGenderChanged:
                (value) {
              setState(() {
                gender = value;
              });
            },
            onMaritalStatusChanged:
                (value) {
              setState(() {
                maritalStatus = value;
              });
            },
            onReligionChanged:
                (value) {
              setState(() {
                religion = value;
              });
            },
            onHeightChanged:
                (value) {
              setState(() {
                height = value;
              });
            },
            onMotherTongueChanged:
                (value) {
              setState(() {
                motherTongue = value;
              });
            },
            onSelectDob: () async {
              final picked =
                  await showDatePicker(
                context: context,
                initialDate:
                    DateTime(1995),
                firstDate:
                    DateTime(1960),
                lastDate:
                    DateTime.now(),
              );

              if (picked != null) {
                dobController.text =
                    "${picked.day}/${picked.month}/${picked.year}";
              }
            },
          ),

        if (currentStep == 1)
          EducationStep(
            qualification:
                qualification,
            specializationController:
                specializationController,
            collegeController:
                collegeController,
            onQualificationChanged:
                (value) {
              setState(() {
                qualification = value;
              });
            },
          ),

        if (currentStep == 2)
          FamilyDetailsStep(
            fatherNameController:
                fatherNameController,
            fatherOccupationController:
                fatherOccupationController,
            motherNameController:
                motherNameController,
            motherOccupationController:
                motherOccupationController,
            brothersController:
                brothersController,
            sistersController:
                sistersController,
            nativePlaceController:
                nativePlaceController,
            familyType:
                familyType,
            onFamilyTypeChanged:
                (value) {
              setState(() {
                familyType = value;
              });
            },
          ),

        if (currentStep == 3)
          ProfessionStep(
            occupationController:
                occupationController,
            companyController:
                companyController,
            incomeController:
                incomeController,
            workLocationController:
                workLocationController,
          ),

        if (currentStep == 4)
          PartnerPreferencesStep(
            ageFromController:
                ageFromController,
            ageToController:
                ageToController,
            preferredCasteController:
                preferredCasteController,
            preferredEducationController:
                preferredEducationController,
            preferredOccupationController:
                preferredOccupationController,
            preferredHeight:
                preferredHeight,
            preferredReligion:
                preferredReligion,
            onPreferredHeightChanged:
                (value) {
              setState(() {
                preferredHeight =
                    value;
              });
            },
            onPreferredReligionChanged:
                (value) {
              setState(() {
                preferredReligion =
                    value;
              });
            },
          ),

        if (currentStep == 5)
          PhotoUploadStep(
            photoPath:
                profilePhotoPath,
            onPickPhoto:
                pickPhoto,
          ),

        const SizedBox(
          height: 30,
        ),

        LayoutBuilder(
  builder: (context, constraints) {

    final isMobile =
        constraints.maxWidth < 450;

    if (isMobile) {

      return Column(
        children: [

          if (currentStep > 0)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: previousStep,
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      const Color(0xFF8B002E),
                  side: const BorderSide(
                    color: Color(0xFF8B002E),
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Back'),
              ),
            ),

          if (currentStep > 0)
            const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: nextStep,
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF8B002E),
                foregroundColor:
                    Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30),
                ),
              ),
              child: Text(
                currentStep == 5
                    ? 'Submit Profile'
                    : 'Continue',
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [

        if (currentStep > 0)
          SizedBox(
            width: 120,
            height: 50,
            child: OutlinedButton(
              onPressed: previousStep,
              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    const Color(0xFF8B002E),
                side: const BorderSide(
                  color: Color(0xFF8B002E),
                ),
              ),
              child: const Text('Back'),
            ),
          ),

        if (currentStep > 0)
          const SizedBox(width: 16),

        SizedBox(
          width: 180,
          height: 50,
          child: ElevatedButton(
            onPressed: nextStep,
            child: Text(
              currentStep == 5
                  ? 'Submit Profile'
                  : 'Continue',
            ),
          ),
        ),
      ],
    );
  },
),

        const SizedBox(
          height: 40,
        ),
      ],
    ),
  ),
),
],
),
);
}
}
