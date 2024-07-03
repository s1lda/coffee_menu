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

  const ProductCard({
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
    return Container(
      height: 180,
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          count > 0 ? buildCountControls() : buildBuyButton(),
        ],
      ),
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
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onIncrement,
          color: Colors.lightBlueAccent,
        ),
      ],
    );
  }
}
