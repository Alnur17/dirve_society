
import 'package:flutter/material.dart';


class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.isToggled,
    required this.onToggle,
  });

  final bool isToggled;
  final ValueChanged<bool> onToggle;

  @override
  State<ToggleButton> createState() => _ToggleButtonState(); 
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.isToggled;
  }

  void _toggle() {
    setState(() {
      _isToggled = !_isToggled;
    });
    widget.onToggle(_isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          color: _isToggled ? Colors.red : Colors.grey,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _isToggled ? 22 : 2,
              top: 2,
              child:  CircleAvatar(
                backgroundColor: Colors.white,
                radius: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
