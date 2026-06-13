import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FamilyDetailsStep extends StatelessWidget {
  final TextEditingController fatherNameController;
  final TextEditingController fatherOccupationController;

  final TextEditingController motherNameController;
  final TextEditingController motherOccupationController;

  final TextEditingController brothersController;
  final TextEditingController sistersController;

  final TextEditingController nativePlaceController;

  final String? familyType;

  final Function(String?) onFamilyTypeChanged;

  const FamilyDetailsStep({
    super.key,
    required this.fatherNameController,
    required this.fatherOccupationController,
    required this.motherNameController,
    required this.motherOccupationController,
    required this.brothersController,
    required this.sistersController,
    required this.nativePlaceController,
    required this.familyType,
    required this.onFamilyTypeChanged,
  });

  Widget _requiredLabel(
    String text,
  ) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color:
                  Color(0xFF2D2D2D),
              fontSize: 15,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red,
              fontWeight:
                  FontWeight.bold,
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
        color:
            const Color(
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

      border:
          OutlineInputBorder(
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
          color:
              Color(
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

                TextFormField(
                  controller:
                      fatherNameController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Father Name',
                    ),
                    Icons.person,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextFormField(
                  controller:
                      fatherOccupationController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Father Occupation',
                    ),
                    Icons.work,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextFormField(
                  controller:
                      motherNameController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Mother Name',
                    ),
                    Icons.person_outline,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextFormField(
                  controller:
                      motherOccupationController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Mother Occupation',
                    ),
                    Icons.work_outline,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextFormField(
  controller:
      brothersController,

  keyboardType:
      TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Number of Brothers',
                    ),
                    Icons.people,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextFormField(
  controller:
      sistersController,

  keyboardType:
      TextInputType.number,

  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Number of Sisters',
                    ),
                    Icons.people_outline,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                TextFormField(
                  controller:
                      nativePlaceController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Native Place',
                    ),
                    Icons.location_on,
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                DropdownButtonFormField<
                    String>(
                  initialValue:
                      familyType,

                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Family Type',
                    ),
                    Icons.home,
                  ),

                  items: const [

                    DropdownMenuItem(
                      value:
                          'Joint Family',
                      child: Text(
                        'Joint Family',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Nuclear Family',
                      child: Text(
                        'Nuclear Family',
                      ),
                    ),
                  ],

                  onChanged:
                      onFamilyTypeChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}