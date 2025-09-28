import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterListView extends StatefulWidget {
  final List<String> filters;
  final Function(String)? onFilterSelected;
  final String? initialSelection;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double spacing;

  const FilterListView({
    super.key,
    required this.filters,
    this.onFilterSelected,
    this.initialSelection,
    this.selectedColor = Colors.black,
    this.unselectedColor = Colors.transparent,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black87,
    this.borderRadius = 25.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.spacing = 8.0,
  });

  @override
  State<FilterListView> createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialSelection ?? widget.filters.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          final filter = widget.filters[index];
          final isSelected = selectedFilter == filter;

          return Padding(
            padding: EdgeInsets.only(
              right: index < widget.filters.length - 1 ? widget.spacing : 0,
            ),
            child: FilterChip(
              filter: filter,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
                if (widget.onFilterSelected != null) {
                  widget.onFilterSelected!(filter);
                }
              },
              selectedColor: widget.selectedColor,
              unselectedColor: widget.unselectedColor,
              selectedTextColor: widget.selectedTextColor,
              unselectedTextColor: widget.unselectedTextColor,
              borderRadius: widget.borderRadius.r,
              padding: widget.padding,
            ),
          );
        },
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final String filter;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double borderRadius;
  final EdgeInsets padding;

  const FilterChip({
    super.key,
    required this.filter,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.borderRadius,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            filter,
            style: TextStyle(
              color: isSelected ? selectedTextColor : unselectedTextColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// مثال على الاستخدام
class FilterDemo extends StatefulWidget {
  const FilterDemo({super.key});

  @override
  State<FilterDemo> createState() => _FilterDemoState();
}

class _FilterDemoState extends State<FilterDemo> {
  String selectedCategory = 'Dresses';

  final List<String> categories = [
    'Dresses',
    'Jackets',
    'Jeans',
    'Shoes',
    'Accessories',
    'Bags',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Filter ListView Demo'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Filter ListView
          FilterListView(
            filters: categories,
            initialSelection: 'Dresses',
            onFilterSelected: (filter) {
              setState(() {
                selectedCategory = filter;
              });
            },
            selectedColor: Colors.black,
            unselectedColor: Colors.white,
            selectedTextColor: Colors.white,
            unselectedTextColor: Colors.black87,
          ),

          const SizedBox(height: 20),

          // عرض الفئة المختارة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Category:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedCategory,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // محتوى إضافي حسب الفئة المختارة
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Content for $selectedCategory category will be displayed here',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}