import 'package:flutter/material.dart';
import '/views/themes/styles/colors.dart';
import '/views/themes/styles/styles.dart';
import '../../../bloc/restaurateurs_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userworkside/models/restaurateur.dart';
import '/views/screens/homescreen/Restaurantprofile.dart';

class SearchPage extends StatefulWidget {
  final String? initialQuery; // Accept initial query

  const SearchPage({super.key, this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = "";
  List<Restaurateur>? _filteredRestaurants;
  final TextEditingController _searchController = TextEditingController(); // Controller for TextField

  @override
  void initState() {
    super.initState();
    context.read<RestaurateursCubit>().loadAllRestaurateurs();

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchQuery = widget.initialQuery!;
      _searchController.text = _searchQuery; // Set initial text in TextField
      final restaurateursList = context.read<RestaurateursCubit>().state;
      if (restaurateursList != null) {
        _updateSearchResults(_searchQuery, restaurateursList);
      }
    }
  }

  void _updateSearchResults(String query, List<Restaurateur> restaurateursList) {
    setState(() {
      _searchQuery = query;
      _filteredRestaurants = restaurateursList
          .where((restau) => restau.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: const Text("Search Restaurants", style: blackHeadlineStyle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _searchController, // Assign controller
              onChanged: (query) {
                final restaurateursList = context.read<RestaurateursCubit>().state;
                if (restaurateursList != null) {
                  _updateSearchResults(query, restaurateursList);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: lightGrayColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Lookup a place to test",
                hintStyle: grayBodyTextStyle,
                suffixIcon: const Icon(Icons.search, color: darkGrayColor),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RestaurateursCubit, List<Restaurateur>?>( 
              builder: (context, restaurateursList) {
                if (restaurateursList == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                final List<Restaurateur> searchResults =
                    _searchQuery.isEmpty ? restaurateursList : _filteredRestaurants ?? [];

                if (searchResults.isEmpty) {
                  return const Center(child: Text("No restaurants found!"));
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final restau = searchResults[index];
                      return restaurantCard(
                        restau.photo ?? "no photo",
                        restau.name ?? "no name",
                        restau.location ?? "no location",
                        restau.ratingValueAverage.toString(),
                        context,
                        restau.restaurateurID ?? 0,
                      );
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

  Widget restaurantCard(String picture, String restauName, String location, String rating, context, int restauID) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantViewPage(restaurateurID: restauID),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(picture, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restauName, style: blackBodyTextStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(location, style: grayBodyTextStyle),
                  Row(
                    children: [
                      Icon(Icons.star_rate, color: darkOrangeColor, size: 16),
                      Text(rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
