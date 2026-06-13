import 'package:flutter/material.dart';

class ProfessionStep extends StatelessWidget {
  final TextEditingController occupationController;
  final TextEditingController companyController;
  final TextEditingController incomeController;
  final TextEditingController workLocationController;

  const ProfessionStep({
    super.key,
    required this.occupationController,
    required this.companyController,
    required this.incomeController,
    required this.workLocationController,
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
    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(
          maxWidth: 900,
        ),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              24,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(
              30,
            ),
            child: Column(
              children: [

                const Icon(
                  Icons.work,
                  size: 60,
                  color: Color(
                    0xFF8B002E,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                const Text(
                  'Professional Details',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(
                      0xFF8B002E,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Text(
                  'Tell us about your career and work profile',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color:
                        Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),

                TextFormField(
                  controller:
                      occupationController,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Occupation',
                    ),
                    Icons.badge,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      companyController,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Company Name',
                    ),
                    Icons.business,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      incomeController,
                  keyboardType:
                      TextInputType.number,
                  decoration:
                      _fieldDecoration(
                    const Text(
                      'Annual Income',
                    ),
                    Icons.currency_rupee,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:
                      workLocationController,
                  decoration:
                      _fieldDecoration(
                    _requiredLabel(
                      'Work Location',
                    ),
                    Icons.location_city,
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