import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    super.key,
    required this.mHeigth,
  });

  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => SizedBox(
        height: 0.2 * mHeigth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.0),
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.lime
                          .harmonizeWith(
                              Theme.of(context).colorScheme.secondaryContainer)
                          .withOpacity(0.4),
                      Theme.of(context).colorScheme.secondaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(child: Text('$index'))),
          ),
        ),
      ),
    ));
  }
}
