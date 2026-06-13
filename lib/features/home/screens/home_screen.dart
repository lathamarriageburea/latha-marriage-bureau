import 'package:flutter/material.dart';

import '../widgets/header_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/why_choose_section.dart';
import '../widgets/success_stories_section.dart';
import '../widgets/about_section.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/footer_section.dart';
import '../../admin/screens/admin_login_screen.dart';
import '../widgets/legal/screens/terms_conditions_screen.dart';
import '../widgets/legal/screens/privacy_policy_screen.dart';
import '../widgets/legal/screens/refund_policy_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  final _headerKey    = GlobalKey();
  final _heroKey      = GlobalKey();
  final _whyChooseKey = GlobalKey();
  final _successKey   = GlobalKey();
  final _aboutKey     = GlobalKey();
  final _ctaKey       = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut);
    }
  }

  void _scrollToTop() => _scrollController.animateTo(0,
      duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);

  void _scrollToCta() => _scrollTo(_ctaKey);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeaderSection(key: _headerKey),
            HeroSection(key: _heroKey),
            const StatsSection(),
            WhyChooseSection(key: _whyChooseKey),
            SuccessStoriesSection(
              key: _successKey,
              onViewMore: _scrollToCta,
            ),
            AboutSection(
              key: _aboutKey,
              onKnowMore: _scrollToCta,
            ),

            // ── CTA Banner — sits on ivory background, clearly separate ──────
            // The prototype shows: About section ends → ivory bg continues →
            // CTA card floats with padding on all 4 sides → ivory bg ends →
            // Footer dark maroon begins as its own independent section.
            CtaBannerSection(key: _ctaKey),

            // ── Footer — completely independent dark section ─────────────────
            FooterSection(
  onNavTap: {
    'Home': _scrollToTop,

    'Why Choose Us': () => _scrollTo(_whyChooseKey),

    'Success Stories': () => _scrollTo(_successKey),

    'About Us': () => _scrollTo(_aboutKey),

    'Contact Us': () => _scrollTo(_headerKey),

    'Admin Login': () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminLoginScreen(),
        ),
      );
    },

    'Terms & Conditions': () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TermsConditionsScreen(),
        ),
      );
    },

    'Privacy Policy': () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
        ),
      );
    },

    'Refund Policy': () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const RefundPolicyScreen(),
        ),
      );
    },
  },
),

          ],
        ),
      ),
    );
  }
}