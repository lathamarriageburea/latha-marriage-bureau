import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive_utils.dart';

// Exact colours from prototype image 3
const _kStatFg  = Color(0xFFC8864A); // warm brownish-gold — icons AND numbers
const _kLabel   = Color(0xFFB09080); // warm grey-brown — labels
const _kBg      = Color(0xFFFDF5EC); // cream/ivory background
const _kDivider = Color(0xFFE8D5C0); // warm beige vertical divider
const _kTopLine = Color(0xFF8B002E); // thin maroon top border line
const _kFloral  = Color(0xFFC8A060); // warm gold — floral motif

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 2, color: _kTopLine),
        Container(
          width: double.infinity,
          color: _kBg,
          height: isMobile ? null : 90,
          child: isMobile ? _buildMobile() : _buildDesktop(),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _FloralMotif(mirrored: false),
        const Expanded(
          child: Row(
            children: [
              Expanded(child: _StatItem(icon: Icons.group_outlined,            value: '5000+', label: 'Happy Members')),
              _VDivider(),
              Expanded(child: _StatItem(icon: Icons.favorite,                  value: '1000+', label: 'Successful Matches')),
              _VDivider(),
              Expanded(child: _StatItem(icon: Icons.military_tech_outlined,    value: '15+',   label: 'Years of Trust')),
              _VDivider(),
              Expanded(child: _StatItem(icon: Icons.shield_outlined,           value: '100%',  label: 'Privacy Guaranteed')),
            ],
          ),
        ),
        const _FloralMotif(mirrored: true),
      ],
    );
  }

  Widget _buildMobile() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _StatItem(icon: Icons.group_outlined,   value: '5000+', label: 'Happy Members')),
              _VDivider(),
              Expanded(child: _StatItem(icon: Icons.favorite,         value: '1000+', label: 'Successful Matches')),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: _kDivider, height: 1),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _StatItem(icon: Icons.military_tech_outlined, value: '15+',  label: 'Years of Trust')),
              _VDivider(),
              Expanded(child: _StatItem(icon: Icons.shield_outlined,        value: '100%', label: 'Privacy Guaranteed')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
  fit: BoxFit.scaleDown,
  child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Prototype: icons are ~28px, warm brownish-gold
          Icon(
  icon,
  size: ResponsiveUtils.isMobile(context) ? 22 : 28,
  color: _kStatFg,
),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Prototype: numbers are ~26px bold
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize:
    ResponsiveUtils.isMobile(context)
        ? 20
        : 26,
                  fontWeight: FontWeight.w700,
                  color: _kStatFg,
                  height: 1.0,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize:
    ResponsiveUtils.isMobile(context)
        ? 11
        : 12.5,
                  fontWeight: FontWeight.w400,
                  color: _kLabel,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ],
      ),
      
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 44, color: _kDivider);
}

class _FloralMotif extends StatelessWidget {
  final bool mirrored;
  const _FloralMotif({required this.mirrored});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: mirrored ? -1.0 : 1.0,
      alignment: Alignment.center,
      child: CustomPaint(
        // Taller canvas so floral fills the bar height properly
        size: const Size(56, 82),
        painter: _FloralPainter(),
      ),
    );
  }
}

class _FloralPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.52;

    final stemP = Paint()
      ..color = _kFloral.withValues(alpha: 0.70)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final leafP = Paint()
      ..color = _kFloral.withValues(alpha: 0.65)
      ..style = PaintingStyle.fill;

    final dotP = Paint()
      ..color = _kFloral.withValues(alpha: 0.60)
      ..style = PaintingStyle.fill;

    // Central stem
    final stem = Path()
      ..moveTo(cx, h * 0.94)
      ..cubicTo(cx - 3, h * 0.68, cx + 3, h * 0.42, cx, h * 0.06);
    canvas.drawPath(stem, stemP);

    // 7 leaf pairs — pointed teardrop, gold
    final leafData = [
      [0.86, 3.5, 7.0, 42.0],
      [0.74, 3.2, 6.5, 40.0],
      [0.62, 3.0, 6.0, 38.0],
      [0.50, 2.8, 5.5, 36.0],
      [0.38, 2.5, 5.0, 34.0],
      [0.26, 2.2, 4.5, 32.0],
      [0.15, 2.0, 4.0, 28.0],
    ];

    for (final d in leafData) {
      final y   = h * d[0];
      final lw  = d[1];
      final lh  = d[2];
      final rad = d[3] * 3.14159265 / 180.0;
      final x   = cx + (d[0] > 0.5 ? -1.5 : 1.5);
      _leaf(canvas, leafP, x, y, lw, lh,  rad);
      _leaf(canvas, leafP, x, y, lw, lh, -rad);
    }

    // Tip bud
    _leaf(canvas, leafP, cx, h * 0.07, 2.0, 4.0, 0.0);

    // Dots between pairs
    for (final yf in [0.80, 0.68, 0.56, 0.44, 0.32, 0.20]) {
      canvas.drawCircle(Offset(cx, h * yf), 1.2, dotP);
    }

    // Curling tendrils
    canvas.drawPath(
      Path()..moveTo(cx, h*0.94)..cubicTo(cx+8,h*0.97,cx+13,h*0.90,cx+8,h*0.86),
      stemP,
    );
    canvas.drawPath(
      Path()..moveTo(cx, h*0.94)..cubicTo(cx-8,h*0.97,cx-13,h*0.90,cx-8,h*0.86),
      stemP,
    );
  }

  void _leaf(Canvas canvas, Paint paint,
      double x, double y, double lw, double lh, double angle) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..cubicTo(-lw, -lh*0.4, -lw*0.6, -lh*0.85, 0, -lh*1.4)
        ..cubicTo( lw*0.6, -lh*0.85,  lw, -lh*0.4, 0,  0),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FloralPainter old) => false;
}
