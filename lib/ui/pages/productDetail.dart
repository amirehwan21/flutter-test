import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/model/productModel.dart';

class ProductDetailPage extends StatefulWidget {

  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
        child: Column(
          children: [
            productImage(),
            SizedBox(height: 10),
            divider(),
            productName(),
            Row(
              children: [
                productPrice(),
                SizedBox(width: 10),
                productRating(widget.product.rating.rate)
              ],
            ),
            SizedBox(height: 15),
            
            productDesc()
            
                
          ],
        ),
      ),
    );
  }

  Widget productImage() {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          child: InteractiveViewer(
            panEnabled: true, // Enable panning
            boundaryMargin: EdgeInsets.all(20),
            minScale: 0.5, // Minimum zoom scale
            maxScale: 4, // Maximum zoom scale
            child: Image.network(
              widget.product.image,
              fit: BoxFit.contain,
            ),
          )
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 10),
          child: Icon(Icons.arrow_back_ios, color: Colors.black)
        ),
      ],
    );
  }

  Widget productName() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.product.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget productPrice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'RM${widget.product.price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green
        ),
      ),
    );
  }

  Widget productRating(double rating) {
    return Row(
      children: [
        // Full stars
        for (int i = 0; i < rating.floor(); i++)
          Icon(Icons.star, color: Colors.amber, size: 14),

        // Half star if needed
        if (rating - rating.floor() >= 0.5)
          Icon(Icons.star_half, color: Colors.amber, size: 14),

        // Empty stars
        for (int i = 0; i < (5 - rating.floor() - (rating - rating.floor() >= 0.5 ? 1 : 0)); i++)
          Icon(Icons.star_border, color: Colors.amber, size: 14),

        const SizedBox(width: 4),
        
        Text(
          '${widget.product.rating.rate.toStringAsFixed(1)} Rating',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget productDesc() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey
        ),
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: Colors.grey,
      height: 20,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}

