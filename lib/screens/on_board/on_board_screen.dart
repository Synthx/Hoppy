import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/widget/widget.dart';

class OnBoardScreen extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => OnBoardScreen(),
        fullscreenDialog: true,
      );

  @override
  State createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final _controller = PageController(
    initialPage: 0,
  );
  final _maxStep = 4;
  int _currentIndex = 0;

  void _closeDialog() {
    context.pop();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MiniFabButton(
        icon: Icon(Icons.clear),
        onTap: () => _closeDialog(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) => _onPageChanged(index),
                children: [
                  OnBoardStep(
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 128,
                      ),
                    ),
                    content: Localization.of(context).on_board_welcome,
                  ),
                  OnBoardStep(
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 128,
                      ),
                    ),
                    title: Localization.of(context).on_board_add_beer_title,
                    content: Localization.of(context).on_board_add_beer_content,
                  ),
                  OnBoardStep(
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 128,
                      ),
                    ),
                    title: Localization.of(context).on_board_add_check_in_title,
                    content:
                        Localization.of(context).on_board_add_check_in_content,
                  ),
                  OnBoardStep(
                    image: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 128,
                      ),
                    ),
                    title: Localization.of(context).on_board_statistics_title,
                    content:
                        Localization.of(context).on_board_statistics_content,
                  ),
                ],
              ),
            ),
            _buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    final indicatorSize = 10.0;

    return Container(
      height: indicatorSize,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ListView.separated(
        itemCount: _maxStep,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final color = _currentIndex != index
              ? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.2)
              : Theme.of(context).textTheme.bodyText1!.color;
          return Container(
            width: indicatorSize,
            height: indicatorSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(indicatorSize / 2),
              color: color,
            ),
          );
        },
      ),
    );
  }
}

class OnBoardStep extends StatelessWidget {
  final Widget image;
  final String? title;
  final String content;

  const OnBoardStep({
    this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          const SizedBox(height: 10),
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
            ),
          const SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
