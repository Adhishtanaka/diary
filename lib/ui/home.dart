import 'package:flutter/material.dart';
import 'package:diary/ui/diaryDetail.dart';
import 'package:diary/utils/auth_helper.dart';
import 'package:diary/utils/diary_helper.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final now = DateTime.now().toString();
  late List<DateTime> markedDates = [];

  @override
  void initState() {
    super.initState();
    fetchDiaries();
  }

  Future<void> fetchDiaries() async {
    int? userId = await getUserData();
    if (userId != null) {
      List<DateTime> fetchedDiariesDate = await getMarkedDates(userId);
      if (mounted) {
        setState(() {
          markedDates = fetchedDiariesDate;
        });
      }
    }
  }

  Future<void> _onDayTapped(DateTime date) async {
    int? userId = await getUserData();
    if (userId != null) {
      Map<String, dynamic>? diary = await getUserDiary(userId, date);
      if (diary != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiaryDetail(diary: diary),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No Information to show")));
      }
    }
  }

  Future<String?> getUserName() async {
    int? userId = await getUserData();
    if (userId != null) {
      String? username = await getNameById(userId);
      if (username != null) {
        return "$username's Diary";
      } else {
        return null;
      }
    }
    return null;
  }

  late final CleanCalendarController calendarController =
      CleanCalendarController(
    minDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
    initialFocusDate: DateTime.now(),
    maxDate: DateTime.now(),
    rangeMode: false,
    onDayTapped: (date) => _onDayTapped(date),
  );

  void logoutUser() {
    logout();
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          logoutUser();
                          Navigator.pop(context);
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
        title: FutureBuilder<String?>(
          future: getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...", style: TextStyle(fontSize: 18));
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Text("Diary", style: TextStyle(fontSize: 18));
            } else {
              return Text(snapshot.data!, style: const TextStyle(fontSize: 18));
            }
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: ScrollableCleanCalendar(
          calendarController: calendarController,
          layout: Layout.DEFAULT,
          calendarCrossAxisSpacing: 10,
          dayBuilder: (context, date) {
            bool isMarked = markedDates.any((d) =>
                d.year == date.day.year &&
                d.month == date.day.month &&
                d.day == date.day.day);

            bool isFutureDate = date.day.isAfter(DateTime.now());

            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isMarked ? Colors.black45 : Colors.transparent,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${date.day.day}',
                    style: TextStyle(
                      color: isFutureDate
                          ? Colors.black38
                          : (isMarked ? Colors.white : Colors.black54),
                      fontWeight:
                          isFutureDate ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime day = DateTime.now();
          String formattedDate = DateTime(day.year, day.month, day.day).toIso8601String();
          if (markedDates.contains(DateTime.parse(formattedDate))) {
            Navigator.pushNamed(context, '/updateDiary');
          } else {
            Navigator.pushNamed(context, '/addDiary');
          }
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
