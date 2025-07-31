import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const CustomRow({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
           Icon(icon, color: Color(0xffFFFCFC), size: 24),

          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xffFFFCFC), fontSize: 16),
            ),
          ),
          IconButton(onPressed: onTap,  icon: Icon(Icons.arrow_forward_ios),color:  Color(0xffFFFCFC),),

        ],
      ),
    );
  }
}
