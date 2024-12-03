
import 'package:Checkmate/utils/resources.dart';
import 'package:Checkmate/utils/themes/dimensions.dart';
import 'package:Checkmate/utils/themes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../utils/themes/themes.dart';
import '../viewmodels/animation_view_model.dart';
import '../viewmodels/task_view_model.dart';
import '../viewmodels/task_view_model_local.dart';
import '../widgets/animation.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String searchQuery = ''; // storing the searchQuery of the user
  String selectedFilter = "Incomplete"; // default filter option

  @override
  Widget build(BuildContext context) {
    // Fetches the list of tasks stored locally using the `taskListProvider`.
    final localTasks = ref.watch(taskListProvider);

// Fetches the list of tasks from the server using the `taskViewModelProvider`.
    final serverTasks = ref.watch(taskViewModelProvider);

// Watches the theme settings (like dark or light mode) using the `themeNotifierProvider`.
    final themeNotifier = ref.watch(themeNotifierProvider);

// Checks whether the tasks from the server are still being loaded using the `taskViewModelProvider` notifier.
    final isLoading = ref.watch(taskViewModelProvider.notifier).isLoading;

// Combines the locally stored tasks and the server tasks into a single list.
// Then, it sorts the tasks by their `dueDate` in ascending order.
    final totalTasks = [...localTasks, ...serverTasks]..sort((a, b) => a.dueDate.compareTo(b.dueDate));

// Filters the tasks from the combined list based on the search query and selected filter.
    List<Task> tasks = totalTasks.where((task) {
      // Checks if the task title matches the search query (case-insensitive).
      final matchesSearch = task.taskTitle.toLowerCase().contains(searchQuery.toLowerCase());

      // Checks if the task matches the selected filter.
      // - If "All" is selected, include all tasks.
      // - If "Completed" is selected, include only completed tasks.
      // - If "Incomplete" is selected, include only incomplete tasks.
      final matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Completed" && task.isCompleted == true) ||
          (selectedFilter == "Incomplete" && task.isCompleted == false);

      // Only include tasks that match both the search query and the filter.
      return matchesSearch && matchesFilter;
    }).toList();
    return Stack(
      children: [Scaffold(
        appBar: AppBar(
          actions: [

            Switch(
              value: themeNotifier.currentTheme == AppTheme.darkTheme,
              onChanged: (bool value) {
                // Toggling the theme
                ref.read(themeNotifierProvider).toggleTheme();
              },
            ),


          ],

          title: const Text("Your Tasks"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.barrierHeight),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.safePadding),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: ColorResources.lightTextColor),
                      cursorColor: Colors.white,
                      onChanged: (query){
                        setState(() {
                          searchQuery = query;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search task ...",
                        prefixIcon: const Icon(Icons.search,color: Colors.white,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(width: Dimensions.safePadding),
                  // Filter Dropdown
                  DropdownButton<String>(
                    isDense: true,
                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    underline: const SizedBox(),
                    dropdownColor: ColorResources.secondaryColor,
                    value: selectedFilter,
                    style: const TextStyle(color: Colors.white70),
                    onChanged: (String? value) {
                      setState(() {
                        selectedFilter = value.toString();
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: "All",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.all_inclusive, color: Colors.white70),
                            SizedBox(width: Dimensions.safePadding),
                            Text("All"),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Completed",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, color: Colors.white70),
                            SizedBox(width: Dimensions.safePadding),
                            Text("Completed"),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Incomplete",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.cancel, color: Colors.white70),
                            SizedBox(width: Dimensions.safePadding),
                            Text("Incomplete"),
                          ],
                        ),
                      ),
                    ],


                  ),


                ],
              ),
            ),
          ),
        ),
        body:ListView.builder(
          itemCount: tasks.length + (isLoading ? 1 : 0), // Add 1 for the loading indicator if server tasks are still loading
          itemBuilder: (context, index) {
            if (index < tasks.length) {
              // Render tasks
              final task = tasks[index];
              return Card(

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),

                child: ListTile(
                  leading: task.api == true ? const Icon(Icons.cloud_outlined) : const Icon(Icons.cloud_off),
                  title: Text(
                    task.taskTitle,
                    style: TextStyle(
                      decoration: task.isCompleted == true ? TextDecoration.lineThrough : null,
                      color: task.isCompleted == true ? Colors.blue : null,
                    ),
                  ),
                  subtitle: Text((task.dueDate).split('T')[0]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete,color: Colors.red.shade400,),
                    onPressed: () async{
                     bool delete =  await _showDialog(context,"Want to delete this task ?");

                     if(delete){
                       ref.read(animationViewModelProvider.notifier).playAnimation();
                       if (task.api == true) {
                         ref.read(taskViewModelProvider.notifier).deleteTask(task.taskTitle);
                       } else {
                         ref.read(taskListProvider.notifier).deleteTask(task.taskTitle);
                       }
                     }

                    },
                  ),
                  onTap: () async{
                    if(task.isCompleted == false){
                      bool completed = await _showDialog(context,"Task completed ?");
                      if(completed){
                        ref.read(animationViewModelProvider.notifier).playAnimation();
                        if (task.api == true) {
                          ref.read(taskViewModelProvider.notifier).toggleTaskCompletion(task.taskTitle);
                        } else {
                          ref.read(taskListProvider.notifier).toggleTaskCompletion(task.taskTitle);
                        }
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task already completed')),
                      );
                    }
                  },
                ),
              );
            } else {
              // Render loading indicator at the end of the list
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.safePadding),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTaskDialog(context, ref);
          },
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Icon(Icons.add,color: Colors.white,),
          ),
        ),
      ),
        const AnimationWidget(),
      ]
    );
  }
}

Future<bool> _showDialog(BuildContext context, String title) async {
  return (await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Yes"),
        ),
      ],
    ),
  )) ?? false;
}


// toggle widget when user want to add task
void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
  final titleController = TextEditingController();
  bool api = false;
  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context, Function setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Task'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Task Title Input
                TextField(
                  style: const TextStyle(color: ColorResources.lightTextColor),
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Enter task title'),
                ),
                const SizedBox(height: Dimensions.safePadding),

                // Select Date Button
                TextButton(
                  onPressed: () => selectDate(context, setState),
                  child: Text(selectedDate == null ? 'Select Due Date' : 'Change Date'),
                ),

                // Display selected date
                if (selectedDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.safePadding),
                    child: Text('${selectedDate!.toLocal()}'.split(' ')[0]),
                  ),

                const SizedBox(height: Dimensions.safePadding),

                // API toggle button
                TextButton(
                  onPressed: () {
                    setState(() {
                      api = !api; // api flag check whether to store data locally or on the github db.json file
                    });
                  },
                  child: Text(
                    api == false ? "Location - Local 🔃" : "Location - GitHub 🔃",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),

          // Add Button
          TextButton(
            onPressed: () {
              if (selectedDate != null && titleController.text.isNotEmpty) {
                // Add task using the correct method based on the `api` flag
                if (!api) {
                  ref.read(taskListProvider.notifier).addTask(
                    titleController.text,
                    selectedDate!.toIso8601String(),
                    api,
                  );
                } else {
                  ref.read(taskViewModelProvider.notifier).addTask(
                    titleController.text,
                    selectedDate!.toIso8601String(),
                    api,
                  );
                }
                Navigator.pop(context);
              } else {
                // Show validation message if input is missing
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a title and select a date')),
                );
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}




