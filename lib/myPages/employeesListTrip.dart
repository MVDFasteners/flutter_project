import 'package:flatten/models/trip_list.dart';
import 'package:flutter/material.dart';

class SearchTripEmployeePage extends StatefulWidget {
  const SearchTripEmployeePage({super.key});

  @override
  State<SearchTripEmployeePage> createState() => _SearchTripEmployeePageState();
}

class _SearchTripEmployeePageState extends State<SearchTripEmployeePage> {
  final TextEditingController _searchController = TextEditingController();

  // Your complete list
  List<TripEmployees> tripEmployees = [
    TripEmployees(employeeName: 'John Doe', employeeId: 'EMP001'),
    TripEmployees(employeeName: 'Jane Smith', employeeId: 'EMP002'),
    TripEmployees(employeeName: 'Michael Johnson', employeeId: 'EMP003'),
    TripEmployees(employeeName: 'Emily Davis', employeeId: 'EMP004'),
    TripEmployees(employeeName: 'David Brown', employeeId: 'EMP005'),
  ];

  // Filtered list
  List<TripEmployees> filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    filteredEmployees = tripEmployees;
    _searchController.addListener(_filterList);
  }

  void _filterList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEmployees = tripEmployees.where((emp) {
        final name = emp.employeeName?.toLowerCase() ?? '';
        final id = emp.employeeId?.toLowerCase() ?? '';
        return name.contains(query) || id.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Search'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or ID...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 📋 Filtered list
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final emp = filteredEmployees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(emp.employeeName ?? 'Unknown'),
                    subtitle: Text(emp.employeeId ?? ''),
                    onTap: () {
                      // Do something on tap, like open details
                    },
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
