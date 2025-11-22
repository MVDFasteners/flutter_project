import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';

// Simple models for Rack and Bin
class BinModel {
  final String id;
  bool filled;

  BinModel({required this.id, this.filled = false});
}

class RackModel {
  final String id;
  final List<BinModel> bins;

  RackModel({required this.id, required this.bins});
}

List<RackModel> generateSampleRacks() {
  return List.generate(12, (r) {
    return RackModel(
      id: 'Rack ${r + 1}',
      bins: List.generate(8, (b) => BinModel(id: 'R${r + 1}B${b + 1}')),
    );
  });
}

class RackView extends StatefulWidget {
  @override
  _RackGridPageState createState() => _RackGridPageState();
}

class _RackGridPageState extends State<RackView> {
  List<RackModel> racks = generateSampleRacks();

  @override
  Widget build(BuildContext context) {
    return Layout(
      scrollNeed: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.2,
          ),
          itemCount: racks.length,
          itemBuilder: (context, index) {
            final rack = racks[index];
            final filledCount = rack.bins.where((b) => b.filled).length;
            return GestureDetector(
              onTap: () async {
                final changed = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => RackDetailPage(rack: rack)),
                );
                if (changed == true) setState(() {});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rack.id,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.view_module, size: 36),
                              SizedBox(height: 6),
                              Text('${rack.bins.length} bins'),
                              SizedBox(height: 4),
                              Text(
                                '$filledCount filled',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Tap to open',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RackDetailPage extends StatefulWidget {
  final RackModel rack;

  RackDetailPage({required this.rack});

  @override
  _RackDetailPageState createState() => _RackDetailPageState();
}

class _RackDetailPageState extends State<RackDetailPage> {
  // track selected bin indices
  final Set<int> selected = {};

  void toggleSelect(int idx) {
    setState(() {
      if (selected.contains(idx)) {
        selected.remove(idx);
      } else {
        selected.add(idx);
      }
    });
  }

  void markSelected(bool filled) {
    setState(() {
      for (final idx in selected) {
        widget.rack.bins[idx].filled = filled;
      }
      selected.clear();
    });
    // notify parent to refresh if needed
    Navigator.of(context).pop(true); // return true indicating changes
  }

  @override
  Widget build(BuildContext context) {
    final bins = widget.rack.bins;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rack.id),
        actions: [
          if (selected.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text('${selected.length} selected'),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: bins.length,
          itemBuilder: (context, index) {
            final bin = bins[index];
            final isSelected = selected.contains(index);
            return GestureDetector(
              onTap: () => toggleSelect(index),
              onLongPress: () => toggleSelect(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 160),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.withOpacity(0.2)
                      : (bin.filled
                            ? Colors.green.withOpacity(0.12)
                            : Colors.grey.withOpacity(0.06)),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Colors.blue
                        : (bin.filled ? Colors.green : Colors.grey.shade300),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(bin.id, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Icon(bin.filled ? Icons.inventory_2 : Icons.inbox),
                    SizedBox(height: 8),
                    Text(bin.filled ? 'Filled' : 'Empty'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: selected.isEmpty
                      ? null
                      : () => markSelected(false),
                  child: Text('Empty'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: selected.isEmpty ? null : () => markSelected(true),
                  child: Text('Fill'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
