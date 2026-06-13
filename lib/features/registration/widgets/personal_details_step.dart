import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalDetailsStep extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController mobileNumberController;
  final TextEditingController dobController;
  final TextEditingController casteController;
  final TextEditingController currentLocationController;

  final String? profileFor;
  final String? gender;
  final String? maritalStatus;
  final String? religion;
  final String? height;
  final String? motherTongue;

  final Function(String?) onProfileForChanged;
  final Function(String?) onGenderChanged;
  final Function(String?) onMaritalStatusChanged;
  final Function(String?) onReligionChanged;
  final Function(String?) onHeightChanged;
  final Function(String?) onMotherTongueChanged;

  final VoidCallback onSelectDob;

  const PersonalDetailsStep({
    super.key,
    required this.fullNameController,
    required this.mobileNumberController,
    required this.dobController,
    required this.casteController,
    required this.currentLocationController,
    required this.profileFor,
    required this.gender,
    required this.maritalStatus,
    required this.religion,
    required this.height,
    required this.motherTongue,
    required this.onProfileForChanged,
    required this.onGenderChanged,
    required this.onMaritalStatusChanged,
    required this.onReligionChanged,
    required this.onHeightChanged,
    required this.onMotherTongueChanged,
    required this.onSelectDob,
  });

  Widget _requiredLabel(String text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Color(0xFF2D2D2D),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(
    Widget label,
    IconData icon,
  ) {
    return InputDecoration(
      label: label,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF8B002E),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE7DCCF),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heights = List.generate(
      37,
      (index) {
        final totalInches = 48 + index;
        final feet = totalInches ~/ 12;
        final inches = totalInches % 12;
        return "$feet'$inches\"";
      },
    );
        return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 580,
        ),
        child: Card(
  elevation: 18,
  shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
          color: Colors.white,

child: Padding(
            padding:
                 const EdgeInsets.symmetric(
  horizontal: 32,
  vertical: 28,
),
                
            child: Column(
              children: [

                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  initialValue: profileFor,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Profile For',
                    ),
                    Icons.badge,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Self',
                      child: Text('Self'),
                    ),
                    DropdownMenuItem(
                      value: 'Son',
                      child: Text('Son'),
                    ),
                    DropdownMenuItem(
                      value: 'Daughter',
                      child: Text('Daughter'),
                    ),
                    DropdownMenuItem(
                      value: 'Brother',
                      child: Text('Brother'),
                    ),
                    DropdownMenuItem(
                      value: 'Sister',
                      child: Text('Sister'),
                    ),
                  ],
                  onChanged:
                      onProfileForChanged,
                ),

                const SizedBox(height: 14),

                TextFormField(
  controller:
      fullNameController,

  textCapitalization:
      TextCapitalization.words,

  inputFormatters: [
    FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z ]"),
    ),
  ],

  decoration:
      _fieldDecoration(
    _requiredLabel(
      'Full Name',
    ),
    Icons.person_outline,
  ),
),

                const SizedBox(height: 14),

                TextFormField(
  controller: mobileNumberController,
  keyboardType: TextInputType.number,
  maxLength: 10,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],

  decoration: _fieldDecoration(
    _requiredLabel('Mobile Number'),
    Icons.phone,
  ),
),

                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  initialValue: gender,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Gender',
                    ),
                    Icons.people,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged:
                      onGenderChanged,
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller:
                      dobController,
                  readOnly: true,
                  onTap: onSelectDob,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Date Of Birth',
                    ),
                    Icons.calendar_month,
                  ).copyWith(
                    suffixIcon:
                        const Icon(
                      Icons
                          .calendar_month,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  initialValue: height,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Height',
                    ),
                    Icons.height,
                  ),
                  items: heights
                      .map(
                        (e) =>
                            DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged:
                      onHeightChanged,
                ),

                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  initialValue:
                      maritalStatus,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Marital Status',
                    ),
                    Icons.favorite,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value:
                          'Never Married',
                      child: Text(
                        'Never Married',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Divorced',
                      child:
                          Text('Divorced'),
                    ),
                    DropdownMenuItem(
                      value: 'Widowed',
                      child:
                          Text('Widowed'),
                    ),
                  ],
                  onChanged:
                      onMaritalStatusChanged,
                ),

                const SizedBox(height: 14),
                                DropdownButtonFormField<String>(
                  initialValue: religion,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Religion',
                    ),
                    Icons.temple_hindu,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Hindu',
                      child: Text('Hindu'),
                    ),
                    DropdownMenuItem(
                      value: 'Christian',
                      child: Text('Christian'),
                    ),
                    DropdownMenuItem(
                      value: 'Muslim',
                      child: Text('Muslim'),
                    ),
                  ],
                  onChanged:
                      onReligionChanged,
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller:
                      casteController,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Caste',
                    ),
                    Icons.groups,
                  ),
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller:
                      currentLocationController,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Current Location',
                    ),
                    Icons.location_on,
                  ),
                ),

                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  initialValue:
                      motherTongue,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Mother Tongue',
                    ),
                    Icons.record_voice_over,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Telugu',
                      child: Text('Telugu'),
                    ),
                    DropdownMenuItem(
                      value: 'Tamil',
                      child: Text('Tamil'),
                    ),
                    DropdownMenuItem(
                      value: 'Kannada',
                      child: Text('Kannada'),
                    ),
                    DropdownMenuItem(
                      value: 'Hindi',
                      child: Text('Hindi'),
                    ),
                  ],
                  onChanged:
                      onMotherTongueChanged,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}