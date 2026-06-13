import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
'''
Privacy Policy

Effective Date: 11 June 2026

Welcome to Latha Marriage Bureau. We respect your privacy and are committed to protecting your personal information.

1. About Us

Latha Marriage Bureau
Registered under the Telangana Shops & Establishments Act, 1988

Registration No.: SEA/MED/ALO/MLJ/1324627/2026

Address:
H.No. 32-75/1/C/1,
Sainiknagar,
Ramakrishnapuram,
Neredmet,
Malkajgiri,
Medchal,
Telangana, India.

Phone: +91 89193 64223
Email: lathamarriageburea@gmail.com

2. Information We Collect

• Full Name
• Date of Birth
• Gender
• Marital Status
• Contact Number
• Email Address
• Residential Address
• Occupation and Educational Details
• Photographs
• Partner Preferences
• Any other information voluntarily submitted during registration

3. How We Use Your Information

• Create and manage your matrimonial profile
• Match profiles based on preferences
• Communicate regarding services and updates
• Verify profile authenticity
• Improve our services
• Comply with legal requirements

4. Sharing of Information

By registering with us, you consent to sharing relevant profile information with prospective matches and members of our matrimonial network.

We do not sell personal information to third parties.

Information may be shared:

• With prospective matrimonial matches
• When required by law or government authorities
• To protect our legal rights and interests

5. Data Security

We take reasonable measures to protect your personal information from unauthorized access, misuse, or disclosure.

However, no online platform can guarantee complete security.

6. User Responsibilities

• Providing accurate information
• Updating profile details when necessary
• Maintaining confidentiality of account credentials

7. Cookies and Analytics

Our website may use cookies and analytics tools to improve user experience and website performance.

8. Profile Removal

Users may request profile removal by contacting us. However, information may be retained where required by law or for legitimate business purposes.

9. Children's Privacy

Our services are intended only for individuals who are legally eligible for marriage under applicable laws.

10. Changes to this Policy

We reserve the right to modify this Privacy Policy at any time. Updated versions will be published on our website.

11. Contact Us

Latha Marriage Bureau

H.No. 32-75/1/C/1,
Sainiknagar,
Ramakrishnapuram,
Neredmet,
Malkajgiri,
Medchal,
Telangana, India.

Phone: +91 89193 64223

Email: lathamarriageburea@gmail.com
''',
style: const TextStyle(
  fontSize: 16,
  height: 1.7,
),
),
      ),
    );
  }
}