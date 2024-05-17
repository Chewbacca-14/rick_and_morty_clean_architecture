import 'package:flutter/material.dart';
import 'package:rick_and_morty_clean_architecture/core/utils/color_palette.dart';
import 'package:rick_and_morty_clean_architecture/core/utils/gender_icons.dart';

class Item extends StatefulWidget {
  final String name;
  final String status;
  final String gender;
  final String lastLocation;
  final void Function()? onTap;

  const Item({
    super.key,
    required this.name,
    required this.status,
    required this.gender,
    required this.lastLocation,
    required this.onTap,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {
  late Icon genderIcon;
  late Color statusColor;

  late AnimationController _animationController;
  late Animation<double> _animation;

  Color _getStatusColor() {
    switch (widget.status) {
      case 'Alive':
        return ColorPalette.aliveStatusColor;
      case 'Dead':
        return ColorPalette.deadStatusColor;
      default:
        return ColorPalette.unknownStatusColor;
    }
  }

  @override
  void initState() {
    super.initState();
    genderIcon =
        widget.gender == 'Male' ? GenderIcons.maleIcon : GenderIcons.femaleIcon;
    statusColor = _getStatusColor();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _animationController.reverse();
        });
      }
    });
    _animation = Tween<double>(begin: 2, end: 30).animate(_animationController);
  }

  void _longPressStart() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Material(
              color: statusColor,
              borderRadius: BorderRadius.circular(_animation.value),
              child: InkWell(
                onTap: widget.onTap,
                onLongPress: _longPressStart,
                splashColor: Colors.blue.withOpacity(0.7),
                borderRadius: BorderRadius.circular(_animation.value),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.all(Radius.circular(_animation.value)),
                  ),
                  child: Column(
                    children: [
                      Text('NAME: ${widget.name}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              genderIcon,
                              const SizedBox(width: 8),
                            ],
                          ),
                          Text('LOCATION: ${widget.lastLocation}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
