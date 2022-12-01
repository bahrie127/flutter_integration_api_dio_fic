import 'package:fic_rest_api/features/product/data/models/medical_model.dart';
import 'package:fic_rest_api/models/request_model.dart';
import 'package:fic_rest_api/utils/network_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  final descriptonController = TextEditingController();

  List<Medical> medicals = [];

  bool isLoading = false;

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    final result = await NetworkManager().getAll();
    medicals = result.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: medicals.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    formData(medicals[index]);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(medicals[index].attributes.name),
                      subtitle: Text(medicals[index].attributes.description),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formData(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void formData(Medical? data) async {
    if (data != null) {
      nameController.text = data.attributes.name;
      stockController.text = data.attributes.stock.toString();
      priceController.text = data.attributes.price.toString();
      descriptonController.text = data.attributes.description;
    }
    bool confirm = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data == null ? 'Add' : 'Update'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: nameController,
                  // initialValue: '',
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Medical name",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: stockController,
                  // initialValue: '0',
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Stock?",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: priceController,
                  // initialValue: '10000',
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "price?",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: descriptonController,
                  // initialValue: '',
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Description?",
                  ),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (data != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ),
                onPressed: () async {
                  await NetworkManager().deleteData(data.id);
                  await refreshData();
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                confirm = true;
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirm) {
      print("Confirmed!");
      RequestMedical request = RequestMedical(
        nameController.text,
        int.parse(stockController.text),
        int.parse(priceController.text),
        descriptonController.text,
      );
      if (data == null) {
        await NetworkManager().addData(request);
      } else {
        await NetworkManager().updateData(data.id, request);
      }

      nameController.clear();
      stockController.clear();
      priceController.clear();
      descriptonController.clear();
      await refreshData();
    }
  }
}
