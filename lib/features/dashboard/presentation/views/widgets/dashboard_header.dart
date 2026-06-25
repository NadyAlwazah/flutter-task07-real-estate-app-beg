import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String selectedTab = 'Buy';
  String? selectedLocation;
  String? selectedPrice;
  String? selectedBeds;
  String? selectedBaths;

  final tabs = ['Buy', 'Rent', 'Sold', 'New Construction'];
  final locations = ['New York', 'Los Angeles', 'Chicago', 'Miami'];
  final prices = ['< \$500k', '\$500k - \$1M', '> \$1M'];
  final beds = ['1', '2', '3', '4+'];
  final baths = ['1', '2', '3', '4+'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs
          Row(
            children: tabs.map((tab) {
              final isActive = selectedTab == tab;
              return Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = tab),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tab,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isActive ? AppColors.blue : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2.h,
                        width: isActive ? (tab.length * 5).w : 0,
                        color: isActive ? AppColors.blue : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 20.h),

          //  Dropdowns + Buttons
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildDropdown(
                        'Location',
                        locations,
                        selectedLocation,
                        (val) => setState(() => selectedLocation = val),
                      ),
                      SizedBox(width: 10.w),
                      _buildDropdown(
                        'Price',
                        prices,
                        selectedPrice,
                        (val) => setState(() => selectedPrice = val),
                      ),
                      SizedBox(width: 10.w),
                      _buildDropdown(
                        'Beds',
                        beds,
                        selectedBeds,
                        (val) => setState(() => selectedBeds = val),
                      ),
                      SizedBox(width: 10.w),
                      _buildDropdown(
                        'Baths',
                        baths,
                        selectedBaths,
                        (val) => setState(() => selectedBaths = val),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _buildFilterButton(),
              SizedBox(width: 10.w),
              _buildSearchButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    final icons = {
      'Location': Icons.location_on_outlined,
      'Price': Icons.attach_money,
      'Beds': Icons.bed_outlined,
      'Baths': Icons.bathtub_outlined,
    };

    return SizedBox(
      width: 185,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownMenu<String>(
          trailingIcon: const Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 18,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          initialSelection: selectedValue,
          onSelected: onChanged,
          hintText: label,
          textStyle: const TextStyle(fontSize: 12),
          leadingIcon: Icon(
            icons[label] ?? Icons.arrow_drop_down,
            color: Colors.grey,
          ),
          dropdownMenuEntries: items
              .map((e) => DropdownMenuEntry(value: e, label: e))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      onPressed: () {},
      icon: const Icon(Icons.filter_list),
      label: const Text('Filter'),
    );
  }

  Widget _buildSearchButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 45),
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      ),
      onPressed: () {},
      child: const Text('Search', style: TextStyle(color: Colors.white)),
    );
  }
}
