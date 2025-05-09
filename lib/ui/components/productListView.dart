import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {

  final String name;
  final double price;
  final double rating;
  final VoidCallback? onTap;

  const ProductListView({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
    this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'RM${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            // Full stars
                            for (int i = 0; i < rating.floor(); i++)
                              Icon(Icons.star, color: Colors.amber, size: 16),
                            
                            // Half star if needed
                            if (rating - rating.floor() >= 0.5)
                              Icon(Icons.star_half, color: Colors.amber, size: 16),
                            
                            // Empty stars (if rating < 5)
                            for (int i = 0; i < 5 - rating.ceil(); i++)
                              Icon(Icons.star_border, color: Colors.amber, size: 16),

                            const SizedBox(width: 4),
                            
                            Text(
                              rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 20),
            ]
          )
        )
      )
    );
  }
}