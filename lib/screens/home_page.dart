// lib/screens/home_page.dart
import 'package:flutter/cupertino.dart';
import 'workout_selection_page.dart';
import '../../widgets/feature_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
      const CupertinoNavigationBar(middle: Text('나의 운동')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '01.11. 토요일',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    CupertinoButton.filled(
                      child: const Text('오늘의 운동 시작하기'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const WorkoutSelectionPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '이번주 운동 목표',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        7,
                            (i) => Container(
                          width: 8,
                          height: (i + 1) * 10.0,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.pen, size: 20),
                          SizedBox(width: 4),
                          Text('이번주 목표', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FeatureButton(title: 'YouTube\nWorkout', onTap: () {}),
                  FeatureButton(title: 'Interval\nTimer', onTap: () {}),
                ],
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: CupertinoColors.systemGrey5,
                child: const Text('공유하기'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
