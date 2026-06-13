import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PartnerPreferencesStep extends StatelessWidget {
  final TextEditingController ageFromController;
  final TextEditingController ageToController;

  final TextEditingController preferredCasteController;
  final TextEditingController preferredEducationController;
  final TextEditingController preferredOccupationController;

  final String? preferredHeight;
  final String? preferredReligion;

  final Function(String?) onPreferredHeightChanged;
  final Function(String?) onPreferredReligionChanged;

  const PartnerPreferencesStep({
    super.key,
    required this.ageFromController,
    required this.ageToController,
    required this.preferredCasteController,
    required this.preferredEducationController,
    required this.preferredOccupationController,
    required this.preferredHeight,
    required this.preferredReligion,
    required this.onPreferredHeightChanged,
    required this.onPreferredReligionChanged,
  });

  InputDecoration _fieldDecoration(
    Widget label,
    IconData icon,
  ) {
    return InputDecoration(
      label: label,
      prefixIcon: Icon(
        icon,
        color: const Color(
          0xFF8B002E,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          14,
        ),
        borderSide:
            const BorderSide(
          color: Color(
            0xFFE7DCCF,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final heights = List.generate(
      37,
      (index) {
        final totalInches =
            48 + index;
        final feet =
            totalInches ~/ 12;
        final inches =
            totalInches % 12;

        return "$feet'$inches\"";
      },
    );

    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(
          maxWidth: 580,
        ),
        child: Card(
  elevation: 18,
  shadowColor: Colors.black12,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              24,
            ),
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
                Row(
                  children: [

                    Expanded(
                      child:
                         TextFormField(
  controller:
      ageFromController,

  keyboardType:
      TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
                        decoration:
                            _fieldDecoration(
                          const Text(
                            'Age From',
                          ),
                          Icons.cake,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 16,
                    ),

                    Expanded(
                      child:
                          TextFormField(
  controller:
      ageToController,

  keyboardType:
      TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
                        decoration:
                            _fieldDecoration(
                          const Text(
                            'Age To',
                          ),
                          Icons.cake_outlined,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                DropdownButtonFormField<
                    String>(
                  initialValue:
                      preferredHeight,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Preferred Height',
                    ),
                    Icons.height,
                  ),
                  items: heights
                      .map(
                        (e) =>
                            DropdownMenuItem(
                          value: e,
                          child:
                              Text(e),
                        ),
                      )
                      .toList(),
                  onChanged:
                      onPreferredHeightChanged,
                ),

                const SizedBox(
                  height: 20,
                ),

                DropdownButtonFormField<
                    String>(
                  initialValue:
                      preferredReligion,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Preferred Religion',
                    ),
                    Icons.temple_hindu,
                  ),
                  items: const [

                    DropdownMenuItem(
                      value:
                          'Hindu',
                      child:
                          Text(
                        'Hindu',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Christian',
                      child:
                          Text(
                        'Christian',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Muslim',
                      child:
                          Text(
                        'Muslim',
                      ),
                    ),
                  ],
                  onChanged:
                      onPreferredReligionChanged,
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      preferredCasteController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Preferred Caste',
                    ),
                    Icons.groups,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      preferredEducationController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Preferred Education',
                    ),
                    Icons.school,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      preferredOccupationController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Preferred Occupation',
                    ),
                    Icons.work,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}