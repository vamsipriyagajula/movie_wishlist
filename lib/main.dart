import 'package:flutter/material.dart';

void main() {
  runApp(const MovieWishlistApp());
}

class MovieWishlistApp extends StatelessWidget {
  const MovieWishlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Wishlist',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MovieListScreen(),
    );
  }
}

class Movie {
  final String title;
  final String posterUrl;

  Movie(this.title, this.posterUrl);
}

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  // Sample movie data with posters
  final List<Movie> movies = [
    Movie("They Call Him OG", "https://m.media-amazon.com/images/M/MV5BOTg2NDNhZTYtNTYxMS00ZjM5LWIyZWEtMjk2MGI2NmMxZmI4XkEyXkFqcGc@._V1_.jpg"),
    Movie("Salaar", "https://m.media-amazon.com/images/M/MV5BNTU0ZjYxOWItOWViMC00YWVlLWJlMGUtZjc1YWU0NTlhY2ZhXkEyXkFqcGc@._V1_QL75_UX820_.jpg"),
    Movie("Sitamma Vakitlo Sirimalle Chettu", "https://i.scdn.co/image/ab67616d0000b273e32653e779b5835374ae4a7a"),
    Movie("Nuvve Nuvve", "https://m.media-amazon.com/images/M/MV5BNWY0NjNjN2UtNzA2NC00ZGEzLTg4YTUtMDc1MWY0MjBmNWIzXkEyXkFqcGc@._V1_.jpg"),
    Movie("Khaleja","https://upload.wikimedia.org/wikipedia/en/d/dc/Mahesh_khaleja_poster.jpg"),
    Movie("oopiri", "https://images.justwatch.com/poster/266157073/s718/oopiri.jpg"),
  ];

  // Wishlist set
  final Set<Movie> wishlist = {};

  void toggleWishlist(Movie movie) {
    setState(() {
      if (wishlist.contains(movie)) {
        wishlist.remove(movie);
      } else {
        wishlist.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Wishlist"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WishlistScreen(wishlist: wishlist.toList()),
                ),
              );
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isInWishlist = wishlist.contains(movie);

          return GestureDetector(
            onTap: () => toggleWishlist(movie),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: Colors.black54,
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    isInWishlist ? Icons.favorite : Icons.favorite_border,
                    color: isInWishlist ? Colors.red : Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WishlistScreen extends StatelessWidget {
  final List<Movie> wishlist;
  const WishlistScreen({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "No movies in wishlist yet!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final movie = wishlist[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.network(
                        movie.posterUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          color: Colors.black54,
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}