import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive_utils.dart';

const _kMaroon  = Color(0xFF7B0D1E);
const _kGold    = Color(0xFFBF8C3C);
const _kBg      = Color(0xFFFFF5F0);
const _kStar    = Color(0xFFF2B33A);
const _kSubtext = Color(0xFF666666);
const _kBorder  = Color(0xFFE7D8CC);

class SuccessStoriesSection extends StatefulWidget {
  final VoidCallback? onViewMore;
  const SuccessStoriesSection({super.key, this.onViewMore});

  @override
  State<SuccessStoriesSection> createState() => _SuccessStoriesSectionState();
}

class _SuccessStoriesSectionState extends State<SuccessStoriesSection> {
  int _page = 0;

  // FIX 1: Corrected "Prasad & Srujana.dart" → ".jpg"
  final List<_Story> _stories = const [
    _Story(
      image: 'assets/success/Anudeep & Priya.jpg',
      name: 'Sandeep & Divya',
      review: 'We are truly grateful to Latha Marriage Bureau for helping us find each other. Their personal attention and genuine care made our journey so smooth.',
    ),
    _Story(
      image: 'assets/success/Nagesh & Roopa.jpg',
      name: 'Venkatesh & Jyothi',
      review: 'Excellent service and very professional team. They understood our requirements perfectly and found the right match for us.',
    ),
    _Story(
      image: 'assets/success/Prasad & Srujana.jpg', // ← FIXED: was .dart
      name: 'Rohit & Harika',
      review: 'Our families are very happy with this match. Thank you Latha Marriage Bureau for making our dreams come true.',
    ),
    _Story(
      image: 'assets/success/Rahul & Pranavi.jpg',
      name: 'Rahul & Pranavi',
      review: 'Thank you for bringing our families together in such a warm and professional way.',
    ),
    _Story(
      image: 'assets/success/Ramesh & Sravani.jpg',
      name: 'Ramesh & Sravani',
      review: 'Their experience and dedication helped us find the right life partner with ease.',
    ),
    _Story(
      image: 'assets/success/Srikanth & Siri.jpg',
      name: 'Srikanth & Siri',
      review: 'Trust, transparency and guidance made all the difference in our matchmaking journey.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final pages = [_stories.sublist(0, 3), _stories.sublist(3, 6)];
    final current = pages[_page];

    return Container(
      width: double.infinity,
      color: _kBg,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: isMobile ? 28 : 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Section title ──────────────────────────────────────────────
              Text(
                'Success Stories',
                style: GoogleFonts.playfairDisplay(
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.w700,
                  color: _kMaroon,
                ),
              ),

              const SizedBox(height: 10),

              // ── Ornamental divider ─────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 32, height: 1, color: _kGold.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Transform.rotate(
                    angle: 0.785398,
                    child: Container(width: 5, height: 5, color: _kGold),
                  ),
                  const SizedBox(width: 6),
                  Container(width: 32, height: 1, color: _kGold.withValues(alpha: 0.6)),
                ],
              ),

              const SizedBox(height: 10),

              // ── Subtitle ───────────────────────────────────────────────────
              Text(
                'Real stories of happiness and new beginnings.',
                style: GoogleFonts.poppins(fontSize: 14, color: _kSubtext),
              ),

              const SizedBox(height: 24),

              // ── Cards row + pagination arrows ──────────────────────────────
              isMobile
                  ? _buildMobileCards(current)
                  : _buildDesktopCards(current, pages.length),

              const SizedBox(height: 24),

              // ── View More button ───────────────────────────────────────────
              _ViewMoreBtn(onTap: widget.onViewMore ?? () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopCards(List<_Story> current, int totalPages) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left arrow — always takes space so layout doesn't jump
        SizedBox(
          width: 40,
          child: _page > 0
              ? _ArrowBtn(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => setState(() => _page--),
                )
              : null,
        ),
        const SizedBox(width: 8),
        // Three cards
        Expanded(
          child: Row(
            children: [
              Expanded(child: _StoryCard(story: current[0])),
              const SizedBox(width: 14),
              Expanded(child: _StoryCard(story: current[1])),
              const SizedBox(width: 14),
              Expanded(child: _StoryCard(story: current[2])),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Right arrow
        SizedBox(
          width: 40,
          child: _page < totalPages - 1
              ? _ArrowBtn(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () => setState(() => _page++),
                )
              : null,
        ),
      ],
    );
  }

  Widget _buildMobileCards(List<_Story> current) {
    return Column(
      children: [
        _StoryCard(story: current[0]),
        const SizedBox(height: 12),
        _StoryCard(story: current[1]),
        const SizedBox(height: 12),
        _StoryCard(story: current[2]),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_page > 0) ...[
              _ArrowBtn(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => setState(() => _page--),
              ),
              const SizedBox(width: 16),
            ],
            if (_page < 1) ...[
              _ArrowBtn(
                icon: Icons.arrow_forward_ios_rounded,
                onTap: () => setState(() => _page++),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

// ── Story card — FIX 2: taller card, better image ratio ──────────────────────
// Prototype shows roughly a 1:2.5 image:text ratio inside the card.
// Image is square-ish (the full card height), text takes remaining width.

class _StoryCard extends StatelessWidget {
  final _Story story;
  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      // FIX: increased from 155 → 175 so text isn't clipped, matches prototype card height
      height: 175,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // FIX: image width = card height so it's a near-square photo
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: SizedBox(
              width: 120, // wider than before; prototype photo takes ~30% of card width
              height: double.infinity,
              child: Image.asset(
                story.image,
                fit: BoxFit.cover,
                // Graceful fallback when image missing
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF5EAD7),
                  child: const Icon(Icons.favorite, color: Color(0xFF7B0D1E), size: 32),
                ),
              ),
            ),
          ),
          // ── Text content ──────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Couple name
                  Text(
                    story.name,
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: _kMaroon,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  // Stars
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(Icons.star_rounded, size: 14, color: _kStar),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Review text — fills remaining space
                  Expanded(
                    child: Text(
                      story.review,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        height: 1.55,
                        color: _kSubtext,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Arrow button ──────────────────────────────────────────────────────────────

class _ArrowBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ArrowBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _kMaroon, width: 1.5),
          color: Colors.white,
        ),
        child: Icon(icon, color: _kMaroon, size: 15),
      ),
    );
  }
}

// ── View More button ──────────────────────────────────────────────────────────

class _ViewMoreBtn extends StatefulWidget {
  final VoidCallback onTap;
  const _ViewMoreBtn({required this.onTap});

  @override
  State<_ViewMoreBtn> createState() => _ViewMoreBtnState();
}

class _ViewMoreBtnState extends State<_ViewMoreBtn> {
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
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: _hov ? const Color(0xFF5A0018) : _kMaroon,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View More Success Stories',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _Story {
  final String image, name, review;
  const _Story({required this.image, required this.name, required this.review});
}
