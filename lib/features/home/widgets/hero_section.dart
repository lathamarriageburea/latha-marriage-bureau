import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/responsive_utils.dart';
import '../../auth/screens/signup_screen.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  static const Color maroon = Color(0xFF7B0D1E);
  static const Color gold = Color(0xFFBF8C3C);

  Future<void> _callUs() async {
    final uri = Uri(
      scheme: 'tel',
      path: '+918919364223',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      color: const Color(0xFFFFFBF8),
      child: Center(
        child: Container(
          width: ResponsiveUtils.contentWidth(context),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 24 : 60,
          ),
          child: isMobile
              ? _buildMobileHero(context)
              : _buildDesktopHero(
                  context,
                  isTablet,
                ),
        ),
      ),
    );
  }

  Widget _buildMobileHero(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius:
              BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 1.05,
            child: Image.asset(
              'assets/images/hero_wedding.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),

        const SizedBox(height: 24),

        _buildContent(
          context,
          true,
        ),
      ],
    );
  }

  Widget _buildDesktopHero(
    BuildContext context,
    bool isTablet,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 11,
          child: _buildContent(
            context,
            false,
          ),
        ),

        SizedBox(
          width: isTablet ? 30 : 60,
        ),

        Expanded(
          flex: 9,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(28),
            child: AspectRatio(
              aspectRatio: 0.90,
              child: Image.asset(
                'assets/images/hero_wedding.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFF5EAD7,
            ),
            borderRadius:
                BorderRadius.circular(
              100,
            ),
          ),
          child: Row(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 15,
                color: Color(
                  0xFF8B5A00,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Trusted Telugu Marriage Bureau',
                style:
                    GoogleFonts.poppins(
                  fontSize:
                      isMobile
                          ? 11
                          : 13,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      const Color(
                    0xFF6B4200,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Find Your Perfect\nLife Partner',
          style:
              GoogleFonts.playfairDisplay(
            fontSize:
                isMobile
                    ? 30
                    : 58,
            fontWeight:
                FontWeight.w800,
            height: 1.05,
            color: maroon,
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: isMobile
              ? null
              : 520,
          child: Text(
            'Helping Telugu families discover meaningful and lasting relationships through trusted matchmaking services.',
            style:
                GoogleFonts.poppins(
              fontSize:
                  isMobile
                      ? 14
                      : 16,
              height: 1.7,
              color:
                  Colors.black87,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(
            isMobile ? 14 : 18,
          ),
          decoration: BoxDecoration(
            color:
                const Color(
              0xFFFDF7F1,
            ),
            borderRadius:
                BorderRadius.circular(
              16,
            ),
            border: Border.all(
              color:
                  const Color(
                0xFFE8D8C8,
              ),
            ),
          ),
          child: RichText(
            text: TextSpan(
              style:
                  GoogleFonts.poppins(
                fontSize:
                    isMobile
                        ? 13
                        : 15,
                height: 1.7,
                color:
                    Colors.black87,
              ),
              children: [
                TextSpan(
                  text:
                      'Second Marriage Special: ',
                  style:
                      GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.bold,
                    color:
                        maroon,
                  ),
                ),
                const TextSpan(
                  text: 'Get ',
                ),
                TextSpan(
                  text:
                      '10 direct contacts',
                  style:
                      GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.bold,
                    color:
                        maroon,
                  ),
                ),
                const TextSpan(
  text: ' for just ',
),
TextSpan(
  text: '₹2,000',
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: maroon,
  ),
),
const TextSpan(
  text: '. Please contact us on ',
),
TextSpan(
  text: '+91 89193 64223',
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: maroon,
  ),
),
const TextSpan(
  text: ' for more details.',
),
              ],
            ),
          ),
        ),

const SizedBox(height: 24),

LayoutBuilder(
  builder: (context, constraints) {
    final landscape =
        MediaQuery.of(context).orientation ==
            Orientation.landscape;

    final cardWidth = landscape
        ? (constraints.maxWidth - 36) / 4
        : (constraints.maxWidth - 12) / 2;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        SizedBox(
          width: cardWidth,
          child: const _TrustCard(
            Icons.verified_user,
            'Verified\nProfiles',
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const _TrustCard(
            Icons.people,
            'Family\nFocused',
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const _TrustCard(
            Icons.lock,
            'Privacy\nProtected',
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const _TrustCard(
            Icons.support_agent,
            'Personal\nSupport',
          ),
        ),
      ],
    );
  },
),

const SizedBox(height: 28),

isMobile
    ? Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SignupScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.person_add,
              ),
              label: Text(
                'Register For Free',
                style:
                    GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    maroon,
                foregroundColor:
                    Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 54,
            child:
                OutlinedButton.icon(
              onPressed: _callUs,
              icon: const Icon(
                Icons.phone,
              ),
              label: Text(
                'Talk To Us',
                style:
                    GoogleFonts.poppins(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    maroon,
                side:
                    const BorderSide(
                  color: maroon,
                  width: 1.4,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    : Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 58,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignupScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_add),
            label: Text(
              'Register For Free',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: maroon,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: SizedBox(
          height: 58,
          child: OutlinedButton.icon(
            onPressed: _callUs,
            icon: const Icon(Icons.phone),
            label: Text(
              'Talk To Us',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: maroon,
              side: const BorderSide(
                color: maroon,
                width: 1.4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
      ]
    );
  }
}
class _TrustCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _TrustCard(
    this.icon,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final isMobile =
        ResponsiveUtils.isMobile(context);

    return Container(
      height: isMobile ? 110 : 125,

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 14,
        vertical: isMobile ? 10 : 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE4D2C5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 38 : 48,
            height: isMobile ? 38 : 48,
            decoration:
                const BoxDecoration(
              color: Color(0xFFF8F1EA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color:
                  HeroSection.maroon,
              size:
                  isMobile ? 18 : 22,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign:
                TextAlign.center,
            maxLines: 2,
            overflow:
                TextOverflow.visible,
            style:
                GoogleFonts.poppins(
              fontSize:
                  isMobile ? 10 : 12,
              height: 1.3,
              fontWeight:
                  FontWeight.w600,
              color:
                  Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}