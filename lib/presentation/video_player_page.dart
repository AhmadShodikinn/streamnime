import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:streaming_app/bloc/watch/watch_bloc.dart';
import 'package:streaming_app/bloc/watch/watch_event.dart';
import 'package:streaming_app/bloc/watch/watch_state.dart';
import 'package:streaming_app/data/models/detail_anime_nonton.dart';
import 'package:streaming_app/data/repository/detail_anime_nonton_repository.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class VideoPlayerPage extends StatefulWidget {
  final String epsId;
  final String title;

  const VideoPlayerPage({super.key, required this.epsId, required this.title});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  void _loadVideo(String url) {
    _webViewController.loadRequest(Uri.parse(url));
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          WatchBloc(DetailAnimeNontonRepository())
            ..add(FetchDetailAnimeNonton(widget.epsId)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                "Detail episode",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Urbanist",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: BlocBuilder<WatchBloc, WatchState>(
              builder: (context, state) {
                if (state is WatchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is WatchError) {
                  return Center(child: Text(state.message));
                }

                if (state is WatchLoaded || state is WatchChangeServerLoading) {
                  final isServerLoading = state is WatchChangeServerLoading;
                  final data = isServerLoading
                      ? state.currentData
                      : (state as WatchLoaded).detailAnimeNontonModel;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _loadVideo(data.data.defaultStreamingUrl);
                  });

                  return Stack(
                    children: [
                      ListView(
                        children: [
                          _videoPlayer(),
                          _episodeInfo(data.data),
                          _divider("Server selection"),
                          _serverSelection(data.data.server.qualities, context),
                          _divider("Download list"),
                          _downloadSection(data.data.downloadUrl.qualities),
                        ],
                      ),

                      if (isServerLoading)
                        const Positioned.fill(
                          child: ColoredBox(
                            color: Colors.white,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                    ],
                  );

                  // return ListView(
                  //   children: [
                  //     _videoPlayer(),
                  //     _episodeInfo(data.data),
                  //     _divider("Server selection"),
                  //     _serverSelection(data.data.server.qualities, context),
                  //     _divider("Download list"),
                  //     _downloadSection(data.data.downloadUrl.qualities),
                  //   ],
                  // );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _videoPlayer() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: WebViewWidget(controller: _webViewController),
    );
  }

  // Widget _episodeInfo(String title, String releaseTime) {
  Widget _episodeInfo(DetailAnimeNontonData animeData) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            animeData.title,
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(animeData.releaseTime, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      animeData.hasPrevEpisode && animeData.prevEpisode != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerPage(
                                epsId: animeData.prevEpisode!.episodeId,
                                title: animeData.prevEpisode!.title,
                              ),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.keyboard_arrow_left),
                  label: const Text("Prev"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: animeData.hasPrevEpisode
                        ? Colors.green
                        : Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      animeData.hasNextEpisode && animeData.nextEpisode != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerPage(
                                epsId: animeData.nextEpisode!.episodeId,
                                title: animeData.nextEpisode!.title,
                              ),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.keyboard_arrow_right),
                  label: const Text("Next"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: animeData.hasNextEpisode
                        ? Colors.white
                        : Colors.grey,
                    foregroundColor: animeData.hasNextEpisode
                        ? Colors.green
                        : Colors.grey,
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

  Widget _divider(String type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Divider(),
          SizedBox(height: 8),
          Center(
            child: Text(
              type,
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _serverSelection(List<ServerQuality> server, BuildContext context) {
    return Column(
      children: server.map((quality) {
        final hasServers = quality.serverList.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  quality.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),

              hasServers
                  ? Row(
                      spacing: 8,
                      children: quality.serverList.map((url) {
                        return InkWell(
                          onTap: () {
                            context.read<WatchBloc>().add(
                              ChangeStreamingServer(url.serverId),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColors.softGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              url.title,
                              style: const TextStyle(
                                color: AppColors.softGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : const Text(
                      "Tidak tersedia",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

              const SizedBox(height: 16),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _downloadSection(List<DownloadQuality> qualities) {
    return Column(
      children: qualities.map((quality) {
        final hasUrls = quality.urls.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${quality.title} | ${quality.size}",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),

              hasUrls
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: quality.urls.map((url) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  builder: (_) {
                                    return _bottomSheetContent(
                                      context,
                                      quality,
                                      url,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  url.title,
                                  style: const TextStyle(
                                    color: AppColors.softGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const Text(
                      "Tidak tersedia",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _bottomSheetContent(
    BuildContext context,
    DownloadQuality quality,
    DownloadItem url,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const Text(
              "Download episode?",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Urbanist",
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            Divider(thickness: 0.4, color: Colors.grey),

            const SizedBox(height: 8),
            const Text(
              "Kamu akan diarahkan ke browser untuk mengunduh video ini.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://otakudesu.best/wp-content/uploads/2025/03/Kimetsu-no-Yaiba-Season-4-Sub-Indo.jpg",
                    width: 90,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Urbanist",
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Quality: ${quality.title}",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          quality.size,
                          style: const TextStyle(
                            color: AppColors.softGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(thickness: 0.4, color: Colors.grey),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await launchUrl(Uri.parse(url.url));
                    },
                    child: const Text("Download"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
