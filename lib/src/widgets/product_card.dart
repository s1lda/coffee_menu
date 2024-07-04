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
          Image.asset(
            imageUrl,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: count > 0 ? buildCountControls() : buildBuyButton(),
          ),
        ],
      ),
    );
  }

  Widget buildBuyButton() {
    return Center(
      child: Container(
        width: 116,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: onBuy,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(color: Colors.white),
          ),
          child: Center(
            child: Text(
              price,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCountControls() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: onDecrement,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onIncrement,
            color: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
  }
}
