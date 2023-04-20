import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key, required this.mHeigth});
  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 0.4 * mHeigth,
      // color: Colors.purple,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 3,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: SizedBox(
              width: 200,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Center(child: Text('$index'))),
                ),
              ),
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    ));
  }
}
