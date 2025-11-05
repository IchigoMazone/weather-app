
import 'package:flutter/material.dart';
import '../models/location_model.dart';
import 'preview_location_screen.dart';
import '../localization/app_localizations.dart';

class ManageCitiesScreen extends StatefulWidget {
  final List<Location> allLocations;
  final Location currentLocation;
  final Function(Location) onLocationRemoved;
  final Function(Location) onLocationAdded;
  final Function(Location) onLocationSelected;
  final VoidCallback onBack;

  const ManageCitiesScreen({
    super.key,
    required this.allLocations,
    required this.currentLocation,
    required this.onLocationRemoved,
    required this.onLocationAdded,
    required this.onLocationSelected,
    required this.onBack,
  });

  @override
  State<ManageCitiesScreen> createState() => _ManageCitiesScreenState();
}

class _ManageCitiesScreenState extends State<ManageCitiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredAddedLocations = [];
  List<Location> _searchSuggestions = [];

  static final List<Location> _allPossibleLocations = [
    Location(name: 'Tuyên Quang', country: 'Tuyên Quang, Việt Nam', temp: 23, condition: 'Cloudy', min: 21, max: 24),
    Location(name: 'Lào Cai', country: 'Lào Cai, Việt Nam', temp: 22, condition: 'Cloudy', min: 20, max: 25),
    Location(name: 'Thái Nguyên', country: 'Thái Nguyên, Việt Nam', temp: 25, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'Phú Thọ', country: 'Phú Thọ, Việt Nam', temp: 30, condition: 'Sunny', min: 25, max: 32),
    Location(name: 'Bắc Ninh', country: 'Bắc Ninh, Việt Nam', temp: 31, condition: 'Sunny', min: 26, max: 33),
    Location(name: 'Hưng Yên', country: 'Hưng Yên, Việt Nam', temp: 29, condition: 'Partly Cloudy', min: 24, max: 30),
    Location(name: 'Hải Phòng', country: 'Hải Phòng, Việt Nam', temp: 27, condition: 'Rainy', min: 23, max: 29),
    Location(name: 'Ninh Bình', country: 'Ninh Bình, Việt Nam', temp: 18, condition: 'Cloudy', min: 15, max: 22),
    Location(name: 'Hà Nội', country: 'Hà Nội, Việt Nam', temp: 24, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'Lai Châu', country: 'Lai Châu, Việt Nam', temp: 29, condition: 'Sunny', min: 25, max: 31),
    Location(name: 'Điện Biên', country: 'Điện Biên, Việt Nam', temp: 32, condition: 'Sunny', min: 27, max: 34),
    Location(name: 'Sơn La', country: 'Sơn La, Việt Nam', temp: 22, condition: 'Cloudy', min: 19, max: 25),
    Location(name: 'Lạng Sơn', country: 'Lạng Sơn, Việt Nam', temp: 24, condition: 'Partly Cloudy', min: 20, max: 27),
    Location(name: 'Quảng Ninh', country: 'Quảng Ninh, Việt Nam', temp: 20, condition: 'Cloudy', min: 18, max: 23),
    Location(name: 'Cao Bằng', country: 'Cao Bằng, Việt Nam', temp: 26, condition: 'Rainy', min: 23, max: 28),
    Location(name: 'Thanh Hóa', country: 'Thanh Hóa, Việt Nam', temp: 23, condition: 'Cloudy', min: 21, max: 24),
    Location(name: 'Nghệ An', country: 'Nghệ An, Việt Nam', temp: 22, condition: 'Cloudy', min: 20, max: 25),
    Location(name: 'Hà Tĩnh', country: 'Hà Tĩnh, Việt Nam', temp: 25, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'Quảng Trị', country: 'Quảng Trị, Việt Nam', temp: 30, condition: 'Sunny', min: 25, max: 32),
    Location(name: 'Đà Nẵng', country: 'Đà Nẵng, Việt Nam', temp: 31, condition: 'Sunny', min: 26, max: 33),
    Location(name: 'Quảng Ngãi', country: 'Quảng Ngãi, Việt Nam', temp: 29, condition: 'Partly Cloudy', min: 24, max: 30),
    Location(name: 'Gia Lai', country: 'Gia Lai, Việt Nam', temp: 27, condition: 'Rainy', min: 23, max: 29),
    Location(name: 'Khánh Hòa', country: 'Khánh Hòa, Việt Nam', temp: 18, condition: 'Cloudy', min: 15, max: 22),
    Location(name: 'Lâm Đồng', country: 'Lâm Đồng, Việt Nam', temp: 24, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'Đắk Lắk', country: 'Đắk Lắk, Việt Nam', temp: 29, condition: 'Sunny', min: 25, max: 31),
    Location(name: 'Huế', country: 'Thừa Thiên Huế, Việt Nam', temp: 32, condition: 'Sunny', min: 27, max: 34),
    Location(name: 'Hồ Chí Minh', country: 'Hồ Chí Minh, Việt Nam', temp: 22, condition: 'Cloudy', min: 19, max: 25),
    Location(name: 'Đồng Nai', country: 'Đồng Nai, Việt Nam', temp: 24, condition: 'Partly Cloudy', min: 20, max: 27),
    Location(name: 'Tây Ninh', country: 'Tây Ninh, Việt Nam', temp: 20, condition: 'Cloudy', min: 18, max: 23),
    Location(name: 'Cần Thơ', country: 'Cần Thơ, Việt Nam', temp: 26, condition: 'Rainy', min: 23, max: 28),
    Location(name: 'Vĩnh Long', country: 'Vĩnh Long, Việt Nam', temp: 23, condition: 'Cloudy', min: 21, max: 24),
    Location(name: 'Đồng Tháp', country: 'Đồng Tháp, Việt Nam', temp: 22, condition: 'Cloudy', min: 20, max: 25),
    Location(name: 'Cà Mau', country: 'Cà Mau, Việt Nam', temp: 25, condition: 'Rainy', min: 22, max: 27),
    Location(name: 'An Giang', country: 'An Giang, Việt Nam', temp: 30, condition: 'Sunny', min: 25, max: 32),
  ];

  @override
  void initState() {
    super.initState();
    _filteredAddedLocations = _getAddedLocations();
    _searchController.addListener(_onSearchChanged);
  }

  List<Location> _getAddedLocations() {
    return widget.allLocations.where((loc) => loc.name != widget.currentLocation.name).toList();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _searchSuggestions = [];
        _filteredAddedLocations = _getAddedLocations();
      } else {
        _searchSuggestions = _allPossibleLocations
            .where((loc) =>
                loc.name.toLowerCase().contains(query) ||
                loc.country.toLowerCase().contains(query))
            .take(10)
            .toList();
        _filteredAddedLocations = [];
      }
    });
  }

  void _addLocation(Location location) {
    final exists = widget.allLocations.any((loc) => loc.name == location.name);
    if (!exists) {
      widget.onLocationAdded(location);
    }
    _searchController.clear();
    setState(() {
      _searchSuggestions = [];
      _filteredAddedLocations = _getAddedLocations();
    });
  }

  void _removeLocation(Location location) {
    widget.onLocationRemoved(location);
    setState(() {
      _filteredAddedLocations.remove(location);
    });
  }

  void _openPreview(Location location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewLocationScreen(
          location: location,
          onAdd: () {
            _addLocation(location);
            widget.onLocationSelected(location);
            Navigator.pop(context);
            widget.onBack();
          },
          onCancel: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

    // Thêm hàm này vào đây (trong class _ManageCitiesScreenState)
  String _translateCondition(String condition, AppLocalizations loc) {
    switch (condition) {
      case 'Cloudy':
        return loc.translate('cloudy');
      case 'Sunny':
        return loc.translate('sunny');
      case 'Rainy':
        return loc.translate('rainy');
      case 'Partly Cloudy':
        return loc.translate('partly_cloudy');
      default:
        return condition;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: widget.onBack,
        ),
        title: Text(
          loc.translate('manage_cities'),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: loc.translate('enter_location'),
                  hintStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: isDark ? Colors.white70 : Colors.grey),
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),

            if (isSearching && _searchSuggestions.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _searchSuggestions.length,
                  itemBuilder: (context, index) {
                    final location = _searchSuggestions[index];
                    final isAdded = widget.allLocations.any((l) => l.name == location.name);

                    return InkWell(
                      onTap: () {
                        if (isAdded) {
                          widget.onLocationSelected(location);
                          widget.onBack();
                        } else {
                          _openPreview(location);
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isAdded ? (isDark ? Colors.grey[700] : Colors.grey[200]) : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.name,
                                    style: TextStyle(
                                      color: isAdded
                                          ? (isDark ? Colors.grey[400] : Colors.grey[600])
                                          : (isDark ? Colors.white : Colors.black87),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    location.country,
                                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            if (isAdded)
                              Icon(Icons.check, color: Colors.green[600], size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            if (!isSearching) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  loc.translate('current_location'),
                  style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildLocationCard(widget.currentLocation, isCurrent: true),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  loc.translate('added_locations'),
                  style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: _filteredAddedLocations.isEmpty
                      ? [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                          Center(
                            child: Text(
                              loc.translate('no_added_locations'),
                              style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500], fontSize: 16),
                            ),
                          ),
                        ]
                      : _filteredAddedLocations.map((location) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildLocationCard(location, onRemove: () => _removeLocation(location)),
                          );
                        }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(Location location, {bool isCurrent = false, VoidCallback? onRemove}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      location.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.location_on, color: isDark ? Colors.white70 : Colors.black54, size: 20),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _translateCondition(location.condition, loc),
                  style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[700], fontSize: 15),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${location.temp}°',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
                ),
                Text(
                  '${location.max}° / ${location.min}°',
                  style: TextStyle(color: isDark ? Colors.white70 : Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          ),
          if (!isCurrent) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.close, color: Colors.red, size: 20),
              ),
            ),
          ],
        ],
      ),
    );
  }
}