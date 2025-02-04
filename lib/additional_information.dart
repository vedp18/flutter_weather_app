
import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  
  final IconData icon;
  final String label;
  final String value;
  
  const AdditionalInformation({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
  
        //icon
        Icon(
          icon,
          size: 32,
        ),
    
        //spaces
        const SizedBox(height: 8,),
    
        // text
        Text(
          label,
        ),
    
        //spaces
        const SizedBox(height: 8,),
        
        // text
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ], // children
    );
  }
}
