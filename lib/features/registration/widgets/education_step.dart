import 'package:flutter/material.dart';

class EducationStep extends StatelessWidget {
  final String? qualification;

  final TextEditingController
      specializationController;

  final TextEditingController
      collegeController;

  final Function(String?)
      onQualificationChanged;

  const EducationStep({
    super.key,
    required this.qualification,
    required this.specializationController,
    required this.collegeController,
    required this.onQualificationChanged,
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

                DropdownButtonFormField<
                    String>(
                  initialValue:
                      qualification,

                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Highest Qualification',
                    ),
                    Icons.school,
                  ),

                  items: const [

                    DropdownMenuItem(
                      value: 'SSC',
                      child:
                          Text('SSC'),
                    ),

                    DropdownMenuItem(
                      value:
                          'Intermediate',
                      child: Text(
                        'Intermediate',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Diploma',
                      child:
                          Text(
                        'Diploma',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Degree',
                      child:
                          Text(
                        'Degree',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'B.Tech',
                      child:
                          Text(
                        'B.Tech',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'M.Tech',
                      child:
                          Text(
                        'M.Tech',
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'MBA',
                      child:
                          Text(
                        'MBA',
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'PhD',
                      child:
                          Text(
                        'PhD',
                      ),
                    ),
                  ],

                  onChanged:
                      onQualificationChanged,
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      specializationController,

                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Specialization',
                    ),
                    Icons.menu_book,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
  controller:
      collegeController,

  textCapitalization:
      TextCapitalization.words,

                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'College / University',
                    ),
                    Icons.account_balance,
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