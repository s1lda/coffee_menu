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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              width: 116,
              child: IndexedStack(
                index: count > 0 ? 1 : 0,
                children: [
                  buildBuyButton(),
                  buildCountControls(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBuyButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onBuy,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: Colors.white,
        ),
        child: Center(
          child: Text(
            price,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildCountControls() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: onDecrement,
            color: Colors.lightBlueAccent,
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 24),
            onPressed: onIncrement,
            color: Colors.lightBlueAccent,
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
