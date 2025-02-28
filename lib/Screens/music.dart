import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:music/Screens/songDetails.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List songs = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    final response = await http.get(Uri.parse('https://api.deezer.com/playlist/3155776842'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        songs = data['tracks']['data'];
      });
    }
  }

  void playSong(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildHeader(),
            const SizedBox(height: 10),
            Expanded(child: _buildSongList()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/elton.jpg'),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Elton John',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Cold Heart',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shuffle, color: Colors.white),
              const SizedBox(width: 60),
              Icon(Icons.playlist_add, color: Colors.white),
              const SizedBox(width: 60),
              Icon(Icons.favorite_border, color: Colors.white),
              const SizedBox(width: 60),
              Icon(Icons.share, color: Colors.white),
            ],
          ),
          const SizedBox(height: 15),
          Divider(color: Colors.white54, thickness: 1, indent: 0, endIndent: 0),
        ],
      ),
    );
  }

  Widget _buildSongList() {
    return songs.isEmpty
        ? const Center(child: CircularProgressIndicator(color: Colors.white))
        : ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          leading: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          title: Text(
            song['title'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            song['artist']['name'],
            style: TextStyle(color: Colors.white70),
          ),
          trailing: Icon(Icons.more_vert, color: Colors.white),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicDetailScreen(
                  songTitle: song['title'],
                  artistName: song['artist']['name'],
                  previewUrl: song['preview'],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.blueGrey.shade900,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
