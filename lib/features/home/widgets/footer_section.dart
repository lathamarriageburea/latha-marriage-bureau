import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';



const _kBg      = Color(0xFF6B0020);
const _kGold    = Color(0xFFD4A24C);
const _kWhite70 = Color(0xB3FFFFFF);
const _kDiv     = Color(0x40FFFFFF);

class FooterSection extends StatelessWidget {
  final Map<String, VoidCallback> onNavTap;
  const FooterSection({super.key, this.onNavTap = const {}});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      color: _kBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              isMobile ? 20 : 48,
              isMobile ? 20 : 24,
              isMobile ? 20 : 48,
              isMobile ? 16 : 20,
            ),
            child: isMobile ? _mobile() : _desktop(),
          ),
          Container(height: 1, color: _kDiv),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '© 2026 Latha Marriage Bureau. All Rights Reserved.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _kWhite70, fontSize: 12, fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Desktop layout ────────────────────────────────────────────────────────
  Widget _desktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 28, child: _Brand()),
        const SizedBox(width: 20),
        _VDiv(),
        const SizedBox(width: 20),
        Expanded(flex: 18, child: _Links(
          'Quick Links',
          [
  'Home',
  'Why Choose Us',
  'Success Stories',
  'About Us',
  'Contact Us',
  //'Admin Login',
],
          arrow: true,
          onNavTap: onNavTap,
        )),
        const SizedBox(width: 20),
        _VDiv(),
        const SizedBox(width: 20),
        Expanded(flex: 22, child: _Links(
          'Our Services',
          ['Personalized Matching', 'Family Consultation', 'Horoscope Matching',
           'Pre Wedding Guidance', 'Marriage Assistance'],
          arrow: false,
          onNavTap: {},
        )),
        const SizedBox(width: 20),
        _VDiv(),
        const SizedBox(width: 20),
        Expanded(flex: 24, child: _ReachUs()),
        const SizedBox(width: 20),
        _VDiv(),
        const SizedBox(width: 20),
        Expanded(flex: 18, child: _Links(
          'Policies',
          ['Terms & Conditions', 'Privacy Policy', 'Refund Policy'],
          arrow: true,
          onNavTap: onNavTap,
        )),
        const SizedBox(width: 20),
        _VDiv(),
        const SizedBox(width: 20),
        Expanded(flex: 18, child: _FollowUs()),
      ],
    );
  }

  Widget _mobile() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      _Brand(),

      const SizedBox(height: 24),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: _FollowUs(),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: _Links(
              'Quick Links',
              [
                'Home',
                'Why Choose Us',
                'Success Stories',
                'About Us',
                'Contact Us',
                //'Admin Login',
              ],
              arrow: true,
              onNavTap: onNavTap,
            ),
          ),
        ],
      ),

      const SizedBox(height: 24),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: _Links(
              'Our Services',
              [
                'Personalized Matching',
                'Family Consultation',
                'Horoscope Matching',
                'Pre Wedding Guidance',
                'Marriage Assistance',
              ],
              arrow: false,
              onNavTap: {},
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: _ReachUs(),
          ),
        ],
      ),

      const SizedBox(height: 24),

      _Links(
        'Policies',
        [
          'Terms & Conditions',
          'Privacy Policy',
          'Refund Policy',
        ],
        arrow: true,
        onNavTap: onNavTap,
      ),
    ],
  );
}
}

// ── Vertical divider ──────────────────────────────────────────────────────────
class _VDiv extends StatelessWidget {
  const _VDiv();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 140, color: _kDiv);
}

// ── Brand column ──────────────────────────────────────────────────────────────
class _Brand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFF4E8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.5),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          ),
          const SizedBox(width: 9),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Latha Marriage Bureau',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white,
                  ),
                  softWrap: true,
                ),
                Text(
                  'We Connect Hearts, We Build Futures.',
                  style: GoogleFonts.poppins(fontSize: 9, color: _kWhite70),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 12),
        Text(
          'Latha Marriage Bureau is a trusted name among Telugu matchmaking '
          'services. We are committed to helping families build happy and lasting relationships.',
          style: GoogleFonts.poppins(fontSize: 11, height: 1.65, color: _kWhite70),
        ),
      ],
    );
  }
}

// ── Generic links column ──────────────────────────────────────────────────────
class _Links extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool arrow;
  final Map<String, VoidCallback> onNavTap;
  const _Links(this.title, this.items, {required this.arrow, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: GoogleFonts.poppins(
          fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 12),
        ...items.map((item) {
          final cb = onNavTap[item];
          return GestureDetector(
            onTap: cb,
            child: MouseRegion(
              cursor: cb != null ? SystemMouseCursors.click : MouseCursor.defer,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (arrow) ...[
                    Text('›', style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w700,
                      color: _kGold, height: 1.25)),
                    const SizedBox(width: 5),
                  ],
                  Expanded(child: Text(item, style: GoogleFonts.poppins(
                    fontSize: 11.5, height: 1.4, color: _kWhite70))),
                ]),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ── Reach Us column ───────────────────────────────────────────────────────────
// CHANGES:
//   • Removed second phone number (82476 87723)
//   • Added +91 prefix to first phone number
//   • Email uses softWrap: true so full address displays without ellipsis
class _ReachUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Reach Us',
          style: GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),

        // Office address
        _ReachRow(
          icon: Icons.location_on_rounded,
          child: Text(
            'Sainagar, Malkajgiri,\nHyderabad – 500047',
            style: GoogleFonts.poppins(fontSize: 11.5, height: 1.5, color: _kWhite70),
          ),
        ),
        const SizedBox(height: 9),

        // Phone — +91 prefix added, second number removed
        _TappableReachRow(
          icon: Icons.phone_rounded,
          label: '+91 89193 64223',
          onTap: () {},
        ),
        const SizedBox(height: 9),

        // Email — softWrap so full address is always visible
        _ReachRow(
          icon: Icons.email_rounded,
          child: Text(
            'lathamarriagebureau@gmail.com',
            softWrap: true,
            style: GoogleFonts.poppins(fontSize: 11, color: _kWhite70, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ReachRow extends StatelessWidget {
  final IconData icon;
  final Widget child;
  const _ReachRow({required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Icon(icon, color: _kGold, size: 13),
      ),
      const SizedBox(width: 7),
      Expanded(child: child),
    ]);
  }
}

class _TappableReachRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _TappableReachRow({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _ReachRow(
          icon: icon,
          child: Text(
            label,
            style: GoogleFonts.poppins(fontSize: 11.5, height: 1.45, color: _kWhite70),
          ),
        ),
      ),
    );
  }
}

// ── Follow Us column ──────────────────────────────────────────────────────────
class _FollowUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Follow Us', style: GoogleFonts.poppins(
          fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 12),
        _SocialRow(FontAwesomeIcons.facebookF, 'Facebook'),
        const SizedBox(height: 9),
        _SocialRow(FontAwesomeIcons.instagram, 'Instagram'),
        const SizedBox(height: 9),
        _SocialRow(FontAwesomeIcons.whatsapp, 'WhatsApp'),
        const SizedBox(height: 9),
        _SocialRow(FontAwesomeIcons.youtube, 'YouTube'),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SocialRow(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Center(child: FaIcon(icon, color: Colors.white, size: 12)),
      ),
      const SizedBox(width: 8),
      Expanded(child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(fontSize: 12, color: _kWhite70),
      )),
    ]);
  }
}
