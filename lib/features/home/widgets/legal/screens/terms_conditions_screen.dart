import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SelectableText(
'''
Terms and Conditions

Effective Date: 11 June 2026

By accessing or using the services of Latha Marriage Bureau, you agree to be bound by these Terms and Conditions.

1. Eligibility

Users must be legally eligible to marry under applicable laws of India.

2. Registration

• Users must provide accurate and truthful information.

• Submission of false, misleading, or fraudulent information may result in account suspension or termination.

• Latha Marriage Bureau reserves the right to verify user information.

3. Service Nature

Latha Marriage Bureau provides matrimonial introduction and matchmaking services.

We do not guarantee marriage, engagement, compatibility, or successful relationships.

4. User Conduct

Users agree not to:

• Upload false information

• Harass, threaten, or abuse other members

• Use the platform for unlawful purposes

• Share offensive, defamatory, or inappropriate content

• Solicit money or engage in fraudulent activities

5. Verification Disclaimer

While we may perform reasonable checks, Latha Marriage Bureau does not guarantee the accuracy, authenticity, character, background, financial status, health condition, or intentions of any member.

Users are advised to independently verify all information before making matrimonial decisions.

6. Limitation of Liability

Latha Marriage Bureau shall not be liable for:

• Any direct or indirect losses

• Failed matrimonial matches

• Misrepresentation by members

• Personal disputes between users

• Emotional, financial, or legal consequences arising from interactions between members

7. Intellectual Property

All website content, logos, designs, and materials belong to Latha Marriage Bureau and may not be copied or reproduced without written permission.

8. Account Suspension

We reserve the right to suspend or terminate accounts that violate these Terms and Conditions.

9. Modifications

Latha Marriage Bureau may update these Terms and Conditions at any time without prior notice.

10. Governing Law

These Terms shall be governed by the laws of India.

Any disputes shall be subject to the jurisdiction of competent courts in Telangana.

11. Contact Information

Latha Marriage Bureau

Phone: +91 89193 64223

Email: lathamarriageburea@gmail.com
''',
  style: TextStyle(
    fontSize: 16,
    height: 1.7,
  ),
),
      ),
    );
  }
}