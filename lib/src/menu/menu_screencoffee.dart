import 'package:flutter/material.dart';
import 'package:coffee_menu/src/data/data_product.dart';
import 'package:coffee_menu/src/widgets/categorysection.dart';
import 'package:coffee_menu/src/widgets/product_card.dart';
import 'package:coffee_menu/src/theme/app_colors.dart';
class CoffeeHomePage extends StatefulWidget {
  @override
  _CoffeeHomePageState createState() => _CoffeeHomePageState();
}
class _CoffeeHomePageState extends State<CoffeeHomePage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();
  int _selectedCategoryIndex = 0;
  final List<GlobalKey> categoryKeys = List.generate(4, (index) => GlobalKey());
  final Map<int, int> productCounts = {};
  bool _isScrollingToCategory = false;

  @override
   void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _categoryScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrollingToCategory) return;

    for (int i = 0; i < categories.length; i++) {
      if (_isWidgetVisible(categoryKeys[i])) {
        _selectCategory(i, scroll: false);
        break;
      }
    }
  }

  bool _isWidgetVisible(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;
      return position.dy >= 0 && position.dy < screenHeight - AppBar().preferredSize.height - 50;
    }
    return false;
  }

  void _selectCategory(int index, {bool scroll = true}) {
    if (_selectedCategoryIndex != index) {
      setState(() {
        _selectedCategoryIndex = index;
      });
      if (scroll) {
        _scrollToCategory(index);
      }
      _scrollCategoryRow(index);
    }
  }

  void _scrollToCategory(int index) {
    final GlobalKey key = categoryKeys[index];
    _scrollController.removeListener(_onScroll);
    setState(() {
      _isScrollingToCategory = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ).then((_) {
        _scrollController.addListener(_onScroll);
        setState(() {
          _isScrollingToCategory = false;
        });
      });
    });
  }

  void _scrollCategoryRow(int index) {
    final categoryPosition = index * 150.0;
    _categoryScrollController.animateTo(
      categoryPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _addToCart(int productId) {
    setState(() {
      if ((productCounts[productId] ?? 0) < 10) {
        productCounts[productId] = (productCounts[productId] ?? 0) + 1;
      }
    });
  }

  void _removeFromCart(int productId) {
    setState(() {
      if (productCounts.containsKey(productId)) {
        if (productCounts[productId]! > 1) {
          productCounts[productId] = productCounts[productId]! - 1;
        } else {
          productCounts.remove(productId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Добавление отступа сверху
            child: ListView.builder(
              controller: _categoryScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => _selectCategory(index),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? CoffeeAppColors.activeCategoryBackground : CoffeeAppColors.categoryBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? CoffeeAppColors.activeCategoryBackground : Colors.grey),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? CoffeeAppColors.activeCategoryTextColor : CoffeeAppColors.categoryTextColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategorySection(
                      key: categoryKeys[0],
                      title: 'Черный кофе',
                      items: products.sublist(0, 4).map((product) => ProductCard(
                        productId: product.id,
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        count: productCounts[product.id] ?? 0,
                        onIncrement: () => _addToCart(product.id),
                        onDecrement: () => _removeFromCart(product.id),
                        onBuy: () => _addToCart(product.id),
                      )).toList(),
                    ),
                    const SizedBox(height: 32),
                    CategorySection(
                      key: categoryKeys[1],
                      title: 'Кофе с молоком',
                      items: products.sublist(4, 8).map((product) => ProductCard(
                        productId: product.id,
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        count: productCounts[product.id] ?? 0,
                        onIncrement: () => _addToCart(product.id),
                        onDecrement: () => _removeFromCart(product.id),
                        onBuy: () => _addToCart(product.id),
                      )).toList(),
                    ),
                    const SizedBox(height: 32),
                    CategorySection(
                      key: categoryKeys[2],
                      title: 'Чай',
                      items: products.sublist(8, 12).map((product) => ProductCard(
                        productId: product.id,
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        count: productCounts[product.id] ?? 0,
                        onIncrement: () => _addToCart(product.id),
                        onDecrement: () => _removeFromCart(product.id),
                        onBuy: () => _addToCart(product.id),
                      )).toList(),
                    ),
                    const SizedBox(height: 32),
                    CategorySection(
                      key: categoryKeys[3],
                      title: 'Авторские напитки',
                      items: products.sublist(12, 16).map((product) => ProductCard(
                        productId: product.id,
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        count: productCounts[product.id] ?? 0,
                        onIncrement: () => _addToCart(product.id),
                        onDecrement: () => _removeFromCart(product.id),
                        onBuy: () => _addToCart(product.id),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}