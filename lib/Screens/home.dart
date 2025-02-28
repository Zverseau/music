import 'package:flutter/material.dart';
import 'package:music/Screens/music.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

 
  final Color primaryColor = Colors.blueGrey;
  final Color secondaryColor = Colors.blueGrey.shade600;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [
                primaryColor.withOpacity(0.5),
                secondaryColor.withOpacity(0.5),
              ],
              stops: [0.5, 1.0],
            ),
          ),
        ),
        title: Text(
          "Discover",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search action
              print("Search button pressed");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Settings action
              print("Settings button pressed");
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor.withOpacity(0.5),
              secondaryColor.withOpacity(0.5),
            ],
            stops: [0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            _searchBar(),
            _featuredArtists(),
            _sectionTitle("New albums"),
            _albumList(),
            _sectionTitle("Today's hits"),
            _musicCard("Coldplay", "My Universe"),
            SizedBox(height: 80),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor.withOpacity(0.5),
              secondaryColor.withOpacity(0.5),
            ],
            stops: [0.5, 1.0],
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "Music"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.white54),
              SizedBox(width: 10),
              Text("Search...", style: TextStyle(color: Colors.white54, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuredArtists() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 140,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _featuredArtist("assets/elton.jpg", "Elton John", "Cold Heart"),
            SizedBox(width: 16),
            _featuredArtist("assets/billie.png", "Billie Eilish", "Happier"),
            SizedBox(width: 16),
            _featuredArtist("assets/kid.jpg", "Billie Eilish", "Happier"),
            SizedBox(width: 16),
            _featuredArtist("assets/dragon.jpg", "Billie Eilish", "Happier"),
          ],
        ),
      ),
    );
  }

  Widget _featuredArtist(String imagePath, String artist, String song) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicScreen(),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 180,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artist,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  song,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Icon(Icons.arrow_forward, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _albumList() {
    List<Map<String, String>> albums = [
      {"image": "assets/kid.jpg", "title": "The Kid LAROY"},
      {"image": "assets/glass.png", "title": "Glass Animals"},
      {"image": "assets/dragon.jpg", "title": "Imagine Dragons"},
      {"image": "assets/kid.jpg", "title": "The Kid LAROY"},
      {"image": "assets/glass.png", "title": "Glass Animals"},
      {"image": "assets/dragon.jpg", "title": "Imagine Dragons"},
    ];

    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16),
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(albums[index]["image"]!, width: 80, height: 80, fit: BoxFit.cover),
                ),
                SizedBox(height: 6),
                Text(albums[index]["title"]!, style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _musicCard(String artist, String song) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    song,
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  print("Play $song by $artist");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
