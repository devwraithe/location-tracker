import 'package:flutter/material.dart';
import 'package:location_tracker/app/shared/utilities/constants.dart';
import 'package:shimmer/shimmer.dart';

class MapLoader extends StatelessWidget {
  const MapLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[400]!,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(
                  Constants.mapRadius,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Shimmer.fromColors(
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey[400]!,
          child: Container(
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(
                Constants.buttonRadius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
