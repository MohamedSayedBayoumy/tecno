import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';

class NotificationCardWidget extends StatefulWidget {
  const NotificationCardWidget({
    super.key,
    required this.timeLabel,
    required this.title,
    required this.description,
    this.onTap,
    this.enablePulse = false,
    this.pulsePeriod = const Duration(seconds: 2),
    this.highlightColor,
  });

  final String timeLabel;
  final String title;
  final String description;
  final void Function()? onTap;

  final bool enablePulse;

  final Duration pulsePeriod;

  final Color? highlightColor;

  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _radius = 12.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.pulsePeriod ~/ 2,
    );

    if (widget.enablePulse) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant NotificationCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pulsePeriod != widget.pulsePeriod) {
      _controller.duration = widget.pulsePeriod ~/ 2;
      if (widget.enablePulse) {
        _controller.repeat(reverse: true);
      }
    }

    if (oldWidget.enablePulse != widget.enablePulse) {
      if (widget.enablePulse) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0.0; // رجّع اللون شفاف
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final basePulseColor =
        (widget.highlightColor ?? Theme.of(context).colorScheme.primary)
            .withOpacity(0.16);

    final card = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.06),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.home_rounded,
              size: 20,
              color: Colors.black.withOpacity(.55),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.styleBold18
                            .copyWith(color: Colors.black, height: 2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.timeLabel),
                  ],
                ),
                Text(
                  widget.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.styleRegular15
                      .copyWith(color: Colors.black, height: 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: Stack(
          children: [
            card,
            if (widget.enablePulse)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      // منحنى ناعم
                      final t = Curves.easeInOut.transform(_controller.value);
                      // مزج تدريجي من شفاف إلى لون النبض
                      final color = Color.lerp(
                        Colors.transparent,
                        basePulseColor,
                        t,
                      );
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(_radius),
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: color),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
