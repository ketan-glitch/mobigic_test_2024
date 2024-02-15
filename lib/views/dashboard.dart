import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobigic_test_2024/services/extensions.dart';

import 'base/custom_appbar.dart';
import 'base/route_helper.dart';
import 'question_screen.dart';
import 'reset_dialog.dart';
import 'search_dialog.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.message, required this.xAxis, required this.yAxis}) : super(key: key);

  final int xAxis;
  final int yAxis;
  final String message;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? search;

  List<List<String>> convertTo2D() {
    List<List<String>> grid = [];
    for (var i = 0; i < widget.message.length; i += widget.xAxis) {
      grid.add(widget.message.getList.sublist(i, i + widget.xAxis > widget.message.length ? widget.message.length : i + widget.xAxis));
    }
    return grid;
  }

  static List<int> x = [-1, -1, -1, 0, 0, 1, 1, 1];
  static List<int> y = [-1, 0, 1, -1, 1, -1, 0, 1];
  searchDirection(List<List<String>> grid, String word, int row, int col) {
    // If first character of word
    // doesn't match with
    // given starting point in grid.
    if (grid[row][col] != word[0]) {
      return;
    }
    int len = word.length;
    // Search word in all 8 directions
    // starting from (row, col)
    List points = [];
    points.add('$row,$col');
    for (int dir = 0; dir < 8; dir++) {
      log("TIMES ${dir + 1}");
      if (!searchForAllDirections) {
        if (dir == 0 || dir == 1 || dir == 2 || dir == 3 || dir == 5) {
          continue;
        }
      }

      log("TIMES ${dir + 1}");
      // Initialize starting point
      // for current direction
      int k;
      int cd = col + y[dir];
      int rd = row + x[dir];

      // First character is already checked,
      // match remaining characters
      for (k = 1; k < len; k++) {
        // If out of bound break
        if (rd >= widget.yAxis || rd < 0 || cd >= widget.xAxis || cd < 0) {
          if (points.isNotEmpty) {
            var temp = points.first;
            log('$points', name: "CLEARED");
            points.clear();
            points.add(temp);
          }
          break;
        }

        // If not matched, break

        if (grid[rd][cd] != word[k]) {
          if (points.isNotEmpty) {
            var temp = points.first;
            points.clear();
            points.add(temp);
          }
          break;
        }

        // Moving in particular direction
        points.add('$rd,$cd');
        rd += x[dir];
        cd += y[dir];
      }

      // If all character matched,
      // then value of must
      // be equal to length of word
      if (k == len) {
        return points;
      }
    }
  }

  List points = [];

  searchWord(String word) {
    points.clear();
    List<List<String>> grid = convertTo2D();
    for (var element in grid) {
      log("$element", name: "${grid.indexOf(element)}");
    }

    for (int row = 0; row < widget.yAxis; row++) {
      for (int col = 0; col < widget.xAxis; col++) {
        if (grid[row][col] == word[0]) {
          log("$row $col");
          var data = searchDirection(grid, word, row, col);
          if (data != null) {
            points.add(data);
          }
        }
      }
    }

    log('$points', name: "points1");

    result.clear();
    for (var element in points) {
      for (var point in element) {
        get1dFrom2d(point);
      }
    }
    setState(() {});
    if (points.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$word Not Found")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$word Found ${points.length} times")));
    }
  }

  List result = [];
  get1dFrom2d(String point) {
    int x = int.parse(point.split(',').first);
    int y = int.parse(point.split(',').last);
    var i = x * widget.xAxis + y;
    result.add(i);
  }

  bool searchForAllDirections = false;

  @override
  Widget build(BuildContext context) {
    // log("${widget.xAxis} ${widget.yAxis}");
    return Scaffold(
      appBar: CustomAppBar(
        bgColor: Theme.of(context).primaryColor,
        title: "Mobigic Test",
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ResetDialog();
                },
              ).then((value) {
                if (value ?? false) {
                  Navigator.pushReplacement(context, getCustomRoute(child: const QuestionScreen()));
                }
              });
            },
            icon: const Icon(Icons.restart_alt),
            color: Colors.black,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const SearchDialog(),
          ).then(
            (value) {
              if (value != null) {
                search = value.toString().toLowerCase();
                searchWord(search!);
              }
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.search, size: 22),
        label: Text(
          "Search",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Column(
        children: [
          Text(
            "Grid Size ${widget.xAxis} x ${widget.yAxis}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          if (search != null)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                child: Text(
                  "$search",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          if (search == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: searchForAllDirections,
                    onChanged: (value) {
                      searchForAllDirections = value!;
                      setState(() {});
                    }),
                Text(
                  "Search in all directions ?",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                )
              ],
            ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: ColoredBox(
                  color: Colors.white /*Theme.of(context).primaryColor*/,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: (widget.xAxis * widget.yAxis),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.xAxis,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: getBoxColor(index),
                            border: Border.all(color: getBorderColor(index)),
                          ),
                          child: Center(
                            child: Text(
                              widget.message[index],
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: getFontSizeByxAxis(),
                                    fontWeight: FontWeight.w400,
                                    color: getTextColor(index),
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getFontSizeByxAxis() {
    if (widget.xAxis < 10) {
      return 20.0;
    } else if (widget.xAxis < 15) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  Color getTextColor(int index) {
    if (result.contains(index)) {
      return Colors.white;
    }
    return Colors.black;
  }

  Color getBorderColor(int index) {
    if (result.contains(index)) {
      return Colors.white;
    }
    return Colors.grey.shade300;
  }

  Color getBoxColor(int index) {
    if (result.contains(index)) {
      return Theme.of(context).primaryColor;
    }
    return Colors.white;
  }
}
