// lib/screens/calendar_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TextStyle;

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('캘린더')),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.chevron_left),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                const Text('1월 2025',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.chevron_right),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.2,
                ),
                itemCount: 32,
                itemBuilder: (ctx, i) {
                  if (i == 0) {
                    return const Center(
                      child: Text('', style: TextStyle(color: CupertinoColors.systemGrey)),
                    );
                  }
                  return Center(
                    child: Text(
                      '$i',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('1월 11일 토',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  CupertinoButton.filled(
                    child: const Text('오늘의 운동 계획하기'),
                    onPressed: () {},
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
