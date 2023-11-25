import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Search',
      //       style: TextStyle(
      //         color: Colors.white,
      //       )),
      //   backgroundColor: Colors.black,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a movie',
                  hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      final searchTerm = _searchController.text;
                      if (searchTerm.isNotEmpty) {
                        Provider.of<MovieProvider>(context, listen: false)
                            .searchMovies(searchTerm);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Consumer<MovieProvider>(
                builder: (context, movieProvider, child) {
                  if (movieProvider.searchResults.isEmpty) {
                    return const Center(
                      child: Text('No results found.'),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: movieProvider.searchResults.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              movieProvider.searchResults[index].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/details',
                                arguments: movieProvider.searchResults[index],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
