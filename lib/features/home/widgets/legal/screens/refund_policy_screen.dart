import 'package:flutter/material.dart';

class RefundPolicyScreen extends StatelessWidget {
  const RefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refund Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: SelectableText(
'''
Refund & Cancellation Policy

Effective Date: 11 June 2026

At Latha Marriage Bureau, we strive to provide quality matrimonial services to all members.

1. No Refund Policy

All registration fees, membership fees, subscription charges, service fees, and package payments made to Latha Marriage Bureau are strictly non-refundable.

Once a user has:

• Registered on the platform, or

• Purchased any membership plan, subscription, package, or service,

no refund shall be provided under any circumstances.

2. No Refund for Unused Services

Refunds will not be granted for:

• Change of mind

• Failure to find a suitable match

• Non-usage of services

• Dissatisfaction with matchmaking outcomes

• Personal reasons

• Account inactivity

3. Subscription Cancellation

Users may choose not to renew their membership or subscription after its expiry.

Cancellation of an active subscription does not entitle the user to any refund, whether full or partial.

4. Duplicate Payments

In cases of verified duplicate payments caused by technical errors, Latha Marriage Bureau may review the transaction and process an appropriate adjustment at its sole discretion.

5. Service Availability

Latha Marriage Bureau does not guarantee uninterrupted access to services.

Temporary interruptions due to maintenance, technical issues, or circumstances beyond our control shall not qualify for refunds.

6. Contact Us

For payment-related queries, please contact:

Latha Marriage Bureau

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

By registering and subscribing to our services, you acknowledge that you have read, understood, and agreed to this Refund & Cancellation Policy.
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