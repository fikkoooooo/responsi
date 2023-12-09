import 'package:flutter/material.dart';
import 'package:responsi/API/api_data_source.dart';
import 'package:responsi/page/kategori_model.dart';
import 'package:responsi/page/meal_page.dart';

const accessoriesColor = Color(0xffeab56f);

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accessoriesColor,
        title: const Text(
          "MEALS CATEGORIES",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: accessoriesColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(
                'Daftar Kategori',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return home_page();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                'Favorit',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return home_page();
                }));
              },
            ),
          ],
        ),
      ),
      body: _buildListAllBody(),

    );
  }

  Widget _buildListAllBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Kategori kategori = Kategori.fromJson(snapshot.data);
              return _buildSuccessSection(kategori);
            }
            return _buildLoadingSection();
          }),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildSuccessSection(Kategori data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Menentukan jumlah kolom dalam grid
        crossAxisSpacing: 10.0, // Spasi antar kolom
        mainAxisSpacing: 10.0, // Spasi antar baris
        childAspectRatio:
        1, // Perbandingan tinggi terhadap lebar setiap item
      ),
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemAll(data.categories![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemAll(Categories Kategori) {
    return InkWell(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return meal_page();
      }));
      },
      child: Card(
        elevation: 20,
        color: Colors.pink[20],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Image.network(
                Kategori.strCategoryThumb!,
                width: 250,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Kategori.strCategory!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Kategori.strCategoryDescription!,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}