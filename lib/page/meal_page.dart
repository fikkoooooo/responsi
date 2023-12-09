import 'package:flutter/material.dart';
import 'package:responsi/API/api_data_source.dart';
import 'package:responsi/page/deskripsi.dart';
import 'package:responsi/page/meal_model.dart';

const accessoriesColor = Color(0xffeab56f);

class meal_page extends StatefulWidget {
  const meal_page({super.key});

  @override
  State<meal_page> createState() => meal_pageState();
}

class meal_pageState extends State<meal_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accessoriesColor,
        title: const Text(
          "MEALS DETAIL",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _buildListAllBody(),

    );
  }

  Widget _buildListAllBody() {
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadMeals(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Meal meal = Meal.fromJson(snapshot.data);
              return _buildSuccessSection(meal);
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

  Widget _buildSuccessSection(Meal data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Menentukan jumlah kolom dalam grid
        crossAxisSpacing: 10.0, // Spasi antar kolom
        mainAxisSpacing: 10.0, // Spasi antar baris
        childAspectRatio:
        1, // Perbandingan tinggi terhadap lebar setiap item
      ),
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _BuildItemAll(data.meals![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _BuildItemAll(Meals Meal) {
    return InkWell(
      onTap: (){

      },
      child: Card(
        elevation: 20,
        color : Colors.pink[20],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Image.network(
                Meal.strMealThumb!,
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Meal.strMeal!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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