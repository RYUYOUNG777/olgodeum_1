// lib/screens/workout_selection_page.dart

import 'package:flutter/cupertino.dart';
// 만약 Firebase나 Firestore 사용 안 하면 import 제거 가능
// import 'package:cloud_firestore/cloud_firestore.dart';

// 만약 카메라 페이지와 연결하기 위해 아래처럼 camera_page.dart를 import
// 실제 경로는 자신의 프로젝트 구조에 맞게 수정
import 'camera_page.dart';

/// (A) 운동 데이터
final Map<String, Map<String, List<String>>> workoutData = {
  '하체': {
    '바벨': [
      '스쿼트',
      '데드리프트',
      '프론트 스쿼트',
      '바벨 런지',
      '굿모닝',
      '바벨 힙 쓰러스트',
      '오버헤드 스쿼트',
      '스내치'
    ],
    '덤벨': [
      '덤벨 런지',
      '덤벨 스플릿 스쿼트',
      '덤벨 데드리프트',
      '덤벨 스텝업',
      '덤벨 가블렛 스쿼트',
      '덤벨 카프 레이즈'
    ],
    '머신': [
      '레그 프레스',
      '레그 익스텐션',
      '레그 컬',
      '스미스 머신 스쿼트',
      '핵 스쿼트',
      '힙 어브덕터 머신'
    ],
    '케이블': [
      '케이블 킥백',
      '케이블 런지',
      '케이블 글루트 드라이브',
      '케이블 스쿼트',
      '케이블 힙 어브덕션'
    ],
    '맨몸': [
      '점프 스쿼트',
      '불가리안 스플릿 스쿼트',
      '싱글 레그 데드리프트',
      '카프 레이즈',
      '월 싯',
      '글루트 브릿지'
    ],
  },
  '등': {
    '바벨': [
      '바벨 로우',
      '데드리프트',
      'T바 로우',
      '바벨 풀오버',
      '바벨 슈러그',
      '바벨 페이스풀',
      '스내치'
    ],
    '덤벨': [
      '덤벨 로우',
      '덤벨 풀오버',
      '원암 덤벨 로우',
      '덤벨 슈러그',
      '덤벨 리어 델트 로우'
    ],
    '머신': [
      '렛 풀다운',
      '시티드 로우',
      '머신 풀오버',
      '리버스 플라이 머신',
      '허리 익스텐션 머신',
      '어시스티드 풀업 머신'
    ],
    '케이블': [
      '케이블 랫 풀다운',
      '케이블 로우',
      '케이블 풀오버',
      '케이블 페이스 풀',
      '케이블 스트레이트 암 풀다운'
    ],
    '맨몸': [
      '풀업',
      '친업',
      '슈퍼맨 익스텐션',
      '행잉 레그 레이즈',
      '리버스 플라이',
      '브릿지'
    ],
  },
  '가슴': {
    '바벨': [
      '벤치프레스',
      '인클라인 벤치프레스',
      '디클라인 벤치프레스',
      '바벨 플랫 플라이',
      '스미스 머신 벤치프레스'
    ],
    '덤벨': [
      '덤벨 벤치프레스',
      '덤벨 플라이',
      '덤벨 풀오버',
      '덤벨 인클라인 프레스',
      '덤벨 네거티브 벤치프레스'
    ],
    '머신': [
      '체스트 프레스',
      '펙 덱 머신',
      '인클라인 체스트 프레스',
      '머신 플라이',
      '스미스 머신 인클라인 프레스'
    ],
    '케이블': [
      '케이블 크로스오버',
      '케이블 플라이',
      '케이블 프레스',
      '케이블 풀오버',
      '케이블 언더암 크로스오버'
    ],
    '맨몸': [
      '푸쉬업',
      '딥스',
      '클랩 푸쉬업',
      '디클라인 푸쉬업',
      '인클라인 푸쉬업',
      '플라이 푸쉬업'
    ],
  },
  '어깨': {
    '바벨': [
      '바벨 오버헤드 프레스',
      '바벨 프론트 레이즈',
      '바벨 업라이트 로우',
      '바벨 클린 앤 프레스',
      '바벨 리버스 프레스'
    ],
    '덤벨': [
      '덤벨 숄더 프레스',
      '덤벨 레터럴 레이즈',
      '덤벨 리버스 플라이',
      '덤벨 프론트 레이즈',
      '덤벨 아놀드 프레스'
    ],
    '머신': [
      '머신 숄더 프레스',
      '머신 레터럴 레이즈',
      '머신 업라이트 로우',
      '스미스 머신 오버헤드 프레스'
    ],
    '케이블': [
      '케이블 레터럴 레이즈',
      '케이블 프론트 레이즈',
      '케이블 리버스 플라이',
      '케이블 페이스 풀',
      '케이블 업라이트 로우'
    ],
    '맨몸': [
      '핸드스탠드 푸쉬업',
      '파이크 푸쉬업',
      '버드독',
      '사이드 플랭크',
      '크랩 워크'
    ],
  },
  '팔': {
    '바벨': [
      '바벨 컬',
      '클로즈 그립 벤치프레스',
      '바벨 해머 컬',
      '바벨 리버스 컬',
      '바벨 프리처 컬',
      '바벨 스컬크러셔'
    ],
    '덤벨': [
      '덤벨 컬',
      '덤벨 트라이셉스 익스텐션',
      '덤벨 해머 컬',
      '덤벨 컨센트레이션 컬',
      '덤벨 킥백',
      '덤벨 리버스 컬'
    ],
    '케이블': [
      '케이블 푸쉬다운',
      '케이블 트라이셉스 익스텐션',
      '케이블 프론트 컬',
      '케이블 리버스 컬',
      '케이블 오버헤드 익스텐션'
    ],
    '머신': [
      '프리처 컬 머신',
      '트라이셉스 익스텐션 머신',
      '머신 바이셉스 컬',
      '머신 트라이셉스 딥'
    ],
    '맨몸': [
      '다이아몬드 푸쉬업',
      '딥스',
      '플로어 트라이셉스 익스텐션',
      '클로즈 그립 푸쉬업',
      '트라이셉스 딥'
    ],
  },
  '유산소': {
    '머신': [
      '러닝머신',
      '스텝머신',
      '사이클',
      '로잉 머신',
      '크로스 트레이너',
      '에어 바이크'
    ],
    '맨몸': [
      '버피',
      '마운틴 클라이머',
      '점핑 잭',
      '하이 니즈',
      '런지 점프',
      '스케이터 점프',
      '플랭크 잭'
    ],
  },
};

/// (B) 운동 선택 페이지
class WorkoutSelectionPage extends StatefulWidget {
  const WorkoutSelectionPage({super.key});

  @override
  State<WorkoutSelectionPage> createState() => _WorkoutSelectionPageState();
}

class _WorkoutSelectionPageState extends State<WorkoutSelectionPage> {
  String? selectedGroup;
  String? selectedTool;
  String? selectedWorkout;

  int setCount = 3;
  double weight = 0;

  bool get isWeightAvailable {
    if (selectedTool == null) return false;
    return ['바벨', '덤벨', '머신', '케이블'].contains(selectedTool);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('WorkoutSelectionPage build');
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('운동 선택')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildGroupSelector(),
              const SizedBox(height: 16),
              if (selectedGroup != null) _buildToolSelector(selectedGroup!),
              const SizedBox(height: 16),
              if (selectedGroup != null && selectedTool != null)
                _buildWorkoutList(selectedGroup!, selectedTool!),
              const SizedBox(height: 16),
              if (selectedWorkout != null) _buildSetAndWeightInput(),
              const SizedBox(height: 16),
              if (selectedWorkout != null)
                CupertinoButton.filled(
                  child: const Text('카메라 페이지로 이동'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => CameraPage(
                          muscleGroup: selectedGroup!,
                          tool: selectedTool!,
                          workoutName: selectedWorkout!,
                          setCount: setCount,
                          weight: isWeightAvailable ? weight : null,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupSelector() {
    final groups = workoutData.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('근육 그룹 선택:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: groups.map((group) {
            final isSelected = (group == selectedGroup);
            return CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: isSelected ? CupertinoColors.activeBlue : CupertinoColors.systemGrey5,
              child: Text(
                group,
                style: TextStyle(
                  color: isSelected ? CupertinoColors.white : CupertinoColors.black,
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedGroup = group;
                  selectedTool = null;
                  selectedWorkout = null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildToolSelector(String group) {
    final tools = workoutData[group]!.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('[$group] 도구 선택:', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tools.map((tool) {
            final isSelected = (tool == selectedTool);
            return CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: isSelected ? CupertinoColors.activeOrange : CupertinoColors.systemGrey5,
              child: Text(
                tool,
                style: TextStyle(
                  color: isSelected ? CupertinoColors.white : CupertinoColors.black,
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedTool = tool;
                  selectedWorkout = null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildWorkoutList(String group, String tool) {
    final workouts = workoutData[group]![tool]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('[$group - $tool] 운동 선택:', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Column(
          children: workouts.map((name) {
            final isSelected = (name == selectedWorkout);
            return Column(
              children: [
                CupertinoButton(
                  color: isSelected ? CupertinoColors.activeGreen : CupertinoColors.systemGrey6,
                  padding: const EdgeInsets.all(8),
                  onPressed: () => setState(() => selectedWorkout = name),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: isSelected ? CupertinoColors.white : CupertinoColors.black,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: CupertinoColors.white,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSetAndWeightInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('세트 수:', style: TextStyle(fontSize: 16)),
        Row(
          children: [
            CupertinoButton(
              child: const Icon(CupertinoIcons.minus_circle),
              onPressed: () {
                setState(() {
                  if (setCount > 1) setCount--;
                });
              },
            ),
            Text('$setCount 세트', style: const TextStyle(fontSize: 16)),
            CupertinoButton(
              child: const Icon(CupertinoIcons.add_circled),
              onPressed: () {
                setState(() {
                  setCount++;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (isWeightAvailable)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('무게(kg):', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.minus_circle),
                    onPressed: () {
                      setState(() {
                        if (weight > 0) weight--;
                      });
                    },
                  ),
                  Text('${weight.toInt()} kg', style: const TextStyle(fontSize: 16)),
                  CupertinoButton(
                    child: const Icon(CupertinoIcons.add_circled),
                    onPressed: () {
                      setState(() {
                        weight++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
