import 'package:flutter/material.dart';

class SearchableCardList extends StatefulWidget {
  final String title;
  final List<String> items;

  const SearchableCardList({required this.title, required this.items});

  @override
  _SearchableCardListState createState() => _SearchableCardListState();
}

class _SearchableCardListState extends State<SearchableCardList> {
  final _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    List<String> filtered = [];
    widget.items.forEach((item) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        filtered.add(item);
      }
    });
    setState(() {
      _filteredItems = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text(widget.title),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search for items',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) => _filterItems(query),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_filteredItems[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
