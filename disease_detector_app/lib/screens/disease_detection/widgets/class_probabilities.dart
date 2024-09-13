import 'package:flutter/material.dart';

class ClassProbabilities extends StatelessWidget {
  const ClassProbabilities({
    super.key,
    required this.name,
    this.confidence,
  });

  final String name;
  final double? confidence;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$name: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: '${confidence!.toStringAsFixed(2)}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            children: [
              Positioned.fill(
                child: CircularProgressIndicator(
                  value: confidence! / 100,
                  backgroundColor: Colors.grey[200],
                  color: Colors.blue,
                ),
              ),
              Center(
                child: Text(
                  '${confidence!.toStringAsFixed(2)}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Divider(
          color: Theme.of(context).colorScheme.outline,
          height: 20,
          thickness: 2,
        ),
      ],
    );
  }
}
