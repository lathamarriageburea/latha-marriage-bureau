import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive_utils.dart';

const _kMaroon  = Color(0xFF7B0D1E);
const _kGold    = Color(0xFFBF8C3C);
const _kBg      = Color(0xFFFFF8F2);
const _kSubtext = Color(0xFF888888);
const _kCardBg  = Color(0xFFFFFFFF);
const _kBorder  = Color(0xFFEBD8C9);
const _kDescClr = Color(0xFF666666);
const _kTitleClr= Color(0xFF2F2F2F);

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: _kBg,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 0,
        vertical: isMobile ? 32 : 44,
      ),
      child: Center(
        child: SizedBox(
          width: ResponsiveUtils.contentWidth(context),
          child: Column(
            children: [
              // ── Section title ──────────────────────────────────────────────
              Text(
                'Why Choose Latha Marriage Bureau?',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.w700,
                  color: _kMaroon,
                ),
              ),

              const SizedBox(height: 10),

              // ── Gold ornamental divider — matches prototype ─────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 36, height: 1, color: _kGold.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Transform.rotate(
                    angle: 0.785398,
                    child: Container(width: 6, height: 6, color: _kGold),
                  ),
                  const SizedBox(width: 6),
                  Container(width: 36, height: 1, color: _kGold.withValues(alpha: 0.6)),
                ],
              ),

              const SizedBox(height: 14),

              // ── Subtitle ───────────────────────────────────────────────────
              Text(
                'Trusted matchmaking services built on family values, privacy, and personal guidance.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: _kSubtext,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // ── Cards ──────────────────────────────────────────────────────
              isMobile ? _buildMobile() : _buildDesktop(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _WhyCard(icon: Icons.groups_outlined,  title: 'Trusted & Experienced',   desc: 'Years of expertise in helping families find the perfect match.')),
        SizedBox(width: 20),
        Expanded(child: _WhyCard(icon: Icons.favorite,         title: 'Personalized Matching',   desc: 'We understand your preferences and suggest the best matches.')),
        SizedBox(width: 20),
        Expanded(child: _WhyCard(icon: Icons.lock_outline,     title: 'Complete Privacy',        desc: 'Your information is safe and always protected.')),
        SizedBox(width: 20),
        Expanded(child: _WhyCard(icon: Icons.support_agent,    title: 'Support at Every Step',   desc: 'From registration to marriage, we are with you always.')),
      ],
    );
  }

  Widget _buildMobile() {
    return const Column(
      children: [
        _WhyCard(icon: Icons.groups_outlined, title: 'Trusted & Experienced',  desc: 'Years of expertise in helping families find the perfect match.'),
        SizedBox(height: 16),
        _WhyCard(icon: Icons.favorite,        title: 'Personalized Matching',  desc: 'We understand your preferences and suggest the best matches.'),
        SizedBox(height: 16),
        _WhyCard(icon: Icons.lock_outline,    title: 'Complete Privacy',       desc: 'Your information is safe and always protected.'),
        SizedBox(height: 16),
        _WhyCard(icon: Icons.support_agent,   title: 'Support at Every Step',  desc: 'From registration to marriage, we are with you always.'),
      ],
    );
  }
}

class _WhyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _WhyCard({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Solid dark maroon circle with white icon
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: _kMaroon,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),

          const SizedBox(height: 18),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _kTitleClr,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              color: _kDescClr,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}
