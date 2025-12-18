import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;

  const VideoPlayerPage({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final WebViewController _controller;
  bool _isVideoPlaying = false;
  bool _isEpisodeListVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize the WebView
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.videoUrl));

    // Set the NavigationDelegate to listen for page load events
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            _isVideoPlaying = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isVideoPlaying = false;
          });
        },
      ),
    );
  }

  final List<Map<String, dynamic>> dummyDownloads = [
    {"quality": "360p", "items": List.generate(4, (i) => "Server ${i + 1}")},
    {"quality": "480p", "items": List.generate(4, (i) => "Server ${i + 1}")},
    {"quality": "720p", "items": List.generate(4, (i) => "Server ${i + 1}")},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Detail anime",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Urbanist",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Screenview(),
            watchServerSelector(),
            dividerSection(),

            // Download section
            ...dummyDownloads.map((e) {
              return downloadSection(
                quality: e['quality'],
                items: List<String>.from(e['items']),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget Screenview() {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: WebViewWidget(controller: _controller),
    );
  }

  int selectedQuality = 1;

  Widget watchServerSelector() {
    final qualities = ['360p', '480p', '720p'];

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            "Kimetsu no Yaiba: Mugen Ressha-hen Episode 1 Subtitle Indonesia",
            style: TextStyle(
              fontFamily: "Urbanist",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Release on 9:24 pm",
              style: TextStyle(fontSize: 16, fontFamily: "Urbanist"),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Your button logic here
                    print('Button pressed!');
                  },
                  label: const Text('Resolution'),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.softGreen,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    print("Button pressed!");
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.softGreen,
                  ),
                  label: const Text(
                    'Server',
                    style: TextStyle(color: AppColors.softGreen),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(width: 2, color: AppColors.softGreen),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dividerSection() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: Column(
        children: [
          Divider(height: 0.4, color: Colors.grey),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Download Anime",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget downloadSection({
    required String quality,
    required List<String> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Header kualitas
          Text(
            "$quality | size 44.2 MB",
            style: const TextStyle(fontSize: 18, fontFamily: "Urbanist"),
          ),
          const SizedBox(height: 6),

          /// List download (inline)
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List.generate(items.length * 2 - 1, (index) {
              if (index.isOdd) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "|",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              final i = index ~/ 2;
              return InkWell(
                onTap: () {
                  debugPrint("Download ${items[i]} - $quality");
                },
                child: Text(
                  items[i],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.softGreen,
                    fontFamily: "Urbanist",
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
