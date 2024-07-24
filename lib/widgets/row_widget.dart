import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {

  final String? name;
  final String? species;
  final String? gender;
  final String? image;
  final Function() onTap;

  const RowWidget({
    super.key,
    this.name,
    this.species,
    this.gender,
    this.image,
    required this.onTap
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: image != null ? NetworkImage(image!) : const AssetImage('assets/placeholder.jpg'),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(name ?? '', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),

                // Species
                Text(species ?? '', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),

                // Gender
                Text(gender ?? '', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
