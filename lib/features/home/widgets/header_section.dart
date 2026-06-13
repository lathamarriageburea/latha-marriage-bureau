import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/signup_screen.dart';
//import '../../admin/screens/admin_login_screen.dart';

const _kMaroon   = Color(0xFF7B0D1E);
const _kGold     = Color(0xFFBF8C3C);
const _kButtonBg = Color(0xFF6B0020);

// ── helpers ──────────────────────────────────────────────────────────────────


Future<void> _launchWhatsApp() async {
  // wa.me opens WhatsApp Web on desktop, native app on mobile
  final uri = Uri.parse('https://wa.me/918919364223');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return Container(
      width: double.infinity,
      height: isMobile ? 120 : 72,
      color: Colors.white,
      child: Column(children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: ResponsiveUtils.contentWidth(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: isMobile ? const _MobileHeader() : const _DesktopHeader(),
              ),
            ),
          ),
        ),
        Container(height: 1, color: const Color(0xFFE8DDD5)),
      ]),
    );
  }
}

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 1050;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _BrandSection(compact: compact),
          const Spacer(),
          _WhatsAppButton(compact: compact),
          SizedBox(width: compact ? 6 : 8),

          _LoginButton(compact: compact),
          SizedBox(width: compact ? 6 : 8),

          _RegisterButton(compact: compact),
          
        ],
      );
    });
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        const _MobileLogo(),
        const SizedBox(width: 10),
        Expanded(child: Text('Latha Marriage Bureau',
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.playfairDisplay(
            fontSize: 15, fontWeight: FontWeight.w700, color: _kMaroon))),
      ]),
      const SizedBox(height: 8),
      const Row(children: [
        Expanded(child: _WhatsAppButtonMobile()),
        SizedBox(width: 6),
        Expanded(child: _LoginButtonMobile()),
        SizedBox(width: 6),
        Expanded(child: _RegisterButtonMobile()),
      ]),
    ]);
  }
}

class _BrandSection extends StatelessWidget {
  final bool compact;
  const _BrandSection({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: compact ? 44 : 54,
        height: compact ? 44 : 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFAF0E0),
          border: Border.all(color: _kGold, width: 1.6)),
        clipBehavior: Clip.hardEdge,
        child: Image.asset('assets/images/logo.png', fit: BoxFit.cover)),
      const SizedBox(width: 10),
      Text('Latha Marriage Bureau',
        style: GoogleFonts.playfairDisplay(
          fontSize: compact ? 18.0 : 24.0,
          fontWeight: FontWeight.w800,
          color: _kMaroon)),
    ]);
  }
}

class _MobileLogo extends StatelessWidget {
  const _MobileLogo();
  @override
  Widget build(BuildContext context) => Container(
    width: 38, height: 38,
    decoration: BoxDecoration(shape: BoxShape.circle,
      color: const Color(0xFFFAF0E0),
      border: Border.all(color: _kGold, width: 1.4)),
    clipBehavior: Clip.hardEdge,
    child: Image.asset('assets/images/logo.png', fit: BoxFit.cover));
}


class _WhatsAppButton extends StatelessWidget {
  final bool compact;
  const _WhatsAppButton({required this.compact});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchWhatsApp,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _HeaderBtn(
          height: compact ? 40 : 48, hPad: compact ? 10 : 14,
          bgColor: _kButtonBg, borderColor: _kButtonBg,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: compact ? 16 : 18),
            SizedBox(width: compact ? 5 : 7),
            Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('WhatsApp', style: GoogleFonts.poppins(
                fontSize: compact ? 8.5 : 9.5,
                color: Colors.white.withValues(alpha: 0.85))),
              Text('+91 89193 64223', style: GoogleFonts.poppins(
                fontSize: compact ? 10.5 : 12,
                fontWeight: FontWeight.w700, color: Colors.white)),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool compact;
  const _LoginButton({required this.compact});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 40 : 48,
      child: OutlinedButton(
        onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ),
  );
},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _kMaroon, width: 1.3),
          padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text('Login', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: compact ? 12 : 13, color: _kMaroon)),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final bool compact;
  const _RegisterButton({required this.compact});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 40 : 48,
      child: ElevatedButton(
        onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const SignupScreen(),
    ),
  );
},
        style: ElevatedButton.styleFrom(
          backgroundColor: _kButtonBg, foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text('Register for Free', style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600, fontSize: compact ? 12 : 13)),
      ),
    );
  }
}

/*
class _AdminButton extends StatelessWidget {
  final bool compact;

  const _AdminButton({
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: compact ? 40 : 48,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AdminLoginScreen(),
            ),
          );
        },

        icon: const Icon(
          Icons.admin_panel_settings,
          size: 18,
          color: _kMaroon,
        ),

        label: Text(
          'Admin',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: compact ? 12 : 13,
            color: _kMaroon,
          ),
        ),

        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: _kMaroon,
            width: 1.3,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12 : 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
*/

class _HeaderBtn extends StatelessWidget {
  final double height, hPad;
  final Color bgColor, borderColor;
  final Widget child;
  const _HeaderBtn({required this.height, required this.hPad,
    required this.bgColor, required this.borderColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.3)),
      child: Center(child: child),
    );
  }
}

// ── Mobile buttons ────────────────────────────────────────────────────────────


class _WhatsAppButtonMobile extends StatelessWidget {
  const _WhatsAppButtonMobile();
  @override
  Widget build(BuildContext context) => SizedBox(height: 32,
    child: ElevatedButton.icon(onPressed: _launchWhatsApp,
      icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 12),
      label: const Text('WhatsApp', style: TextStyle(fontSize: 10)),
      style: ElevatedButton.styleFrom(
        backgroundColor: _kButtonBg, foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap)));
}

class _LoginButtonMobile extends StatelessWidget {
  const _LoginButtonMobile();
  @override
  Widget build(BuildContext context) => SizedBox(height: 32,
    child: OutlinedButton(onPressed: () {
        Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    ),
  );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        side: const BorderSide(color: _kMaroon),
        minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      child: const Text('Login', style: TextStyle(fontSize: 10, color: _kMaroon))));
}

class _RegisterButtonMobile extends StatelessWidget {
  const _RegisterButtonMobile();
  @override
  Widget build(BuildContext context) => SizedBox(height: 32,
    child: ElevatedButton(onPressed: () {
        Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const SignupScreen(),
    ),
  );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _kButtonBg, foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      child: const Text('Register', style: TextStyle(fontSize: 10))));
}
