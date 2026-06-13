import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive_utils.dart';

const _kMaroon   = Color(0xFF7B0D1E);
const _kGold     = Color(0xFFBF8C3C);
const _kBg       = Color(0xFFFFFBF8);
//const _kCardBg   = Color(0xFFFFFFFF);
const _kBorder   = Color(0xFFF1D7BF);
//const _kIconBg   = Color(0xFFFFF0F0);
const _kBodyText = Color(0xFF4A4A4A);
const _kDescClr  = Color(0xFF888888);
const _kTitleClr = Color(0xFF222222);

class AboutSection extends StatelessWidget {
  /// Callback for "Know More About Us" — scrolls to CTA/register section
  final VoidCallback? onKnowMore;

  const AboutSection({super.key, this.onKnowMore});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: _kBg,
      padding: EdgeInsets.symmetric(
  horizontal: isMobile ? 20 : 60,
  vertical: isMobile ? 36 : 48,
),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
  _buildLeft(context),
  const SizedBox(height: 28),
  _buildRight(context),
]
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 4, child: _buildLeft(context)),
                    const SizedBox(width: 48),
                    Expanded(flex: 6, child: _buildRight(context)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLeft(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'About Us',
          style: GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w600,
            color: _kGold, letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Building Relationships\nThat Last Forever',
          style: GoogleFonts.playfairDisplay(
            fontSize: ResponsiveUtils.isMobile(context)
    ? 24
    : MediaQuery.of(context).size.width < 1100
        ? 30
        : 36, fontWeight: FontWeight.w700,
            color: _kMaroon, height: 1.25,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Latha Marriage Bureau is a trusted name among Telugu families. '
          'We are committed to helping individuals and families find '
          'compatible life partners with trust, respect and understanding.',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.isMobile(context) ? 13 : 15, height: 1.7, color: _kBodyText,
          ),
        ),
        const SizedBox(height: 22),
        // FIX Q8: pass onKnowMore callback down
        _KnowMoreBtn(onTap: onKnowMore ?? () {}),
      ],
    );
  }

  Widget _buildRight(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  final items = const [
    _FeatureData(
      icon: FontAwesomeIcons.userGroup,
      title: 'Our Mission',
      desc: 'To connect hearts and build happy families.',
    ),
    _FeatureData(
      icon: FontAwesomeIcons.eye,
      title: 'Our Vision',
      desc: 'To be the most trusted marriage bureau for generations.',
    ),
    _FeatureData(
      icon: FontAwesomeIcons.handHoldingHeart,
      title: 'Our Values',
      desc: 'Trust, Transparency, Respect and Commitment.',
    ),
    _FeatureData(
      icon: FontAwesomeIcons.peopleGroup,
      title: 'Our Promise',
      desc: 'We treat every member like our own family.',
    ),
  ];

  if (width < 768) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.70,
    ),
    itemBuilder: (_, index) {
      return _FeatureCard(data: items[index]);
    },
  );
}

  if (width < 1100) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, index) {
        return _FeatureCard(data: items[index]);
      },
    );
  }

  return Row(
    children: items
        .map(
          (e) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _FeatureCard(data: e),
            ),
          ),
        )
        .toList(),
  );
}
}

class _KnowMoreBtn extends StatefulWidget {
  final VoidCallback onTap;
  const _KnowMoreBtn({required this.onTap});

  @override
  State<_KnowMoreBtn> createState() => _KnowMoreBtnState();
}

class _KnowMoreBtnState extends State<_KnowMoreBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _hov
                ? _kGold.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _kGold,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Know More About Us',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _kMaroon,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 15,
                color: _kGold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _FeatureData {
  final IconData icon;
  final String title;
  final String desc;

  const _FeatureData({
    required this.icon,
    required this.title,
    required this.desc,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureData data;

  const _FeatureCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.all(mobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
     child: Column(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: mobile ? 52 : 64,
            height: mobile ? 52 : 64,
            decoration: const BoxDecoration(
              color: _kMaroon,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FaIcon(
                data.icon,
                color: Colors.white,
                size: mobile ? 18 : 22,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: mobile ? 14 : 17,
              fontWeight: FontWeight.w700,
              color: _kTitleClr,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: mobile ? 11.5 : 13,
              height: 1.7,
              color: _kDescClr,
            ),
          ),
        ],
      ),
    );

  }
}

