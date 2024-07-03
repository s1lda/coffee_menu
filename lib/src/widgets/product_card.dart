import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final int productId;
  final String imageUrl;
  final String title;
  final String price;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onBuy;

  ProductCard({
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.onBuy,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageUrl,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(title),
        const SizedBox(height: 8),
        count > 0 ? buildCountControls() : buildBuyButton(),
      ],
    );
  }

  Widget buildBuyButton() {
    return Container(
      width: 116,
      height: 40, 
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onBuy,
        child: Text(
          price,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildCountControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onDecrement,
          color: Colors.lightBlueAccent,
        ),
        Text('$count'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onIncrement,
          color: Colors.lightBlueAccent,
        ),
      ],
    );
  }
}
