import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../auth/screens/signup_screen.dart';

// CTA card colour — slightly lighter maroon than footer
const _kCardBg = Color(0xFF8B1A3A);
const _kGold   = Color(0xFFD4A24C);

// Outer background — ivory, same as page/scaffold background
const _kOuterBg = Color(0xFFFFF8F3);

class CtaBannerSection extends StatelessWidget {
  const CtaBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: _kOuterBg,
      padding: EdgeInsets.only(
        left:   isMobile ? 20 : 56,
        right:  isMobile ? 20 : 56,
        top:    isMobile ? 24 : 32,
        bottom: 0,
      ),
      child: Container(
        width: double.infinity,
        height: isMobile ? null : 96,
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: isMobile ? _buildMobile(context) : _buildDesktop(context),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 96, height: 96,
        child: CustomPaint(painter: _FloralPainter(mirrored: false)),
      ),
      const SizedBox(width: 16),
      Container(
        width: 58, height: 58,
        decoration: const BoxDecoration(color: _kGold, shape: BoxShape.circle),
        child: const Center(
          child: Icon(Icons.phone_rounded, color: Colors.white, size: 22),
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ready to Find Your Perfect Match?',
              style: const TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Register now and let us help you start your journey.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13, color: Colors.white.withValues(alpha: 0.80),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 20),
      _RegisterBtn(onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SignupScreen()),
        );
      }),
      const SizedBox(width: 16),
      SizedBox(
        width: 96, height: 96,
        child: CustomPaint(painter: _FloralPainter(mirrored: true)),
      ),
    ]);
  }

  Widget _buildMobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(color: _kGold, shape: BoxShape.circle),
              child: const Center(
                child: Icon(Icons.phone_rounded, color: Colors.white, size: 21),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                'Ready to Find Your Perfect Match?',
                style: const TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Text(
            'Register now and let us help you start your journey.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.5, color: Colors.white.withValues(alpha: 0.80),
            ),
          ),
          const SizedBox(height: 16),
          _RegisterBtn(onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignupScreen()),
            );
          }),
        ],
      ),
    );
  }
}

class _RegisterBtn extends StatefulWidget {
  final VoidCallback? onTap;
  const _RegisterBtn({this.onTap});

  @override
  State<_RegisterBtn> createState() => _RegisterBtnState();
}

class _RegisterBtnState extends State<_RegisterBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap ?? () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: _hov ? const Color(0xFFAA7830) : _kGold,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register Free Now',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white,
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

class _FloralPainter extends CustomPainter {
  final bool mirrored;
  const _FloralPainter({required this.mirrored});

  @override
  void paint(Canvas canvas, Size size) {
    if (mirrored) { canvas.translate(size.width, 0); canvas.scale(-1, 1); }
    final w = size.width; final h = size.height; final cx = w * 0.50;
    final stemP = Paint()..color = _kGold.withValues(alpha: 0.80)..style = PaintingStyle.stroke..strokeWidth = 1.2..strokeCap = StrokeCap.round;
    final leafP = Paint()..color = _kGold.withValues(alpha: 0.75)..style = PaintingStyle.fill;
    final dotP  = Paint()..color = _kGold.withValues(alpha: 0.70)..style = PaintingStyle.fill;
    canvas.drawPath(Path()..moveTo(cx,h*0.95)..cubicTo(cx-5,h*0.65,cx+5,h*0.35,cx,h*0.05), stemP);
    for (final d in <List<double>>[[0.87,5.0,10.0,46.0],[0.75,4.6,9.5,44.0],[0.63,4.2,9.0,42.0],[0.51,3.8,8.5,39.0],[0.39,3.4,8.0,36.0],[0.27,3.0,7.0,33.0],[0.15,2.6,6.0,29.0]]) {
      final y=h*d[0]; final lw=d[1]; final lh=d[2]; final rad=d[3]*3.14159265/180.0;
      final x=cx+(d[0]>0.5?-2.5:2.5);
      _leaf(canvas,leafP,x,y,lw,lh,rad); _leaf(canvas,leafP,x,y,lw,lh,-rad);
    }
    _leaf(canvas,leafP,cx,h*0.06,2.8,5.5,0.0);
    for (final yf in [0.81,0.69,0.57,0.45,0.33,0.21]) canvas.drawCircle(Offset(cx,h*yf),1.5,dotP);
    canvas.drawPath(Path()..moveTo(cx,h*0.95)..cubicTo(cx+12,h*0.99,cx+20,h*0.88,cx+12,h*0.83),stemP);
    canvas.drawPath(Path()..moveTo(cx,h*0.95)..cubicTo(cx-12,h*0.99,cx-20,h*0.88,cx-12,h*0.83),stemP);
  }

  void _leaf(Canvas canvas, Paint p, double x, double y, double lw, double lh, double a) {
    canvas.save(); canvas.translate(x,y); canvas.rotate(a);
    canvas.drawPath(Path()..moveTo(0,0)..cubicTo(-lw,-lh*0.40,-lw*0.6,-lh*0.85,0,-lh*1.45)..cubicTo(lw*0.6,-lh*0.85,lw,-lh*0.40,0,0),p);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FloralPainter old) => false;
}
