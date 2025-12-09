import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.child,
    this.foregroundColor,
    this.onPressed,
  });

   double? borderRadius;
   Widget? child;
   Color? backgroundColor;
   Color? foregroundColor;
   void Function()? onPressed;
   

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     style: ButtonStyle(
       minimumSize: WidgetStateProperty.all(const Size(double.infinity, 55)),

    backgroundColor: MaterialStateProperty.all(backgroundColor ?? Colors.green),
    foregroundColor: MaterialStateProperty.all(foregroundColor?? Colors.white),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
    ),
        ),
        
      onPressed: onPressed,
      child: Center(child: child), 
    );
  }
}
