import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../utils/utils.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox.shrink(),
          ),
        ),
      ),
      body: Obx(() {
        final steps = controller.steps.value;
        final kcal = controller.kCalories.value;
        final stepsGoal = controller.stepsGoal.value;
        final kcalGoal = controller.kcalGoal.value;
        return RefreshIndicator(
          onRefresh: controller.refreshPage,//controller.fetchTodayHealth()
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 40),
                _progressCard(
                  context: context,
                  title: 'Steps',
                  valueText: formatNumber(steps).toString(),
                  progress: (steps / stepsGoal).clamp(0, 1).toDouble(),
                  leadingMinText: '${(steps / stepsGoal).clamp(0, 100).toDouble()}',
                  trailingGoalText: 'Goal ${formatNumber(stepsGoal).toString()}',
                  trailingIcon: isDark
                      ? Image.asset(
                          'assets/images/footsteps_dark.png',
                          width: 180,
                        )
                      : Image.asset(
                          'assets/images/footsteps_light.png',
                          width: 180,
                        ),
                ),
                const SizedBox(height: 32),
                _progressCard(
                  context: context,
                  title: 'Calories Burned',
                  valueText: formatNumber(kcal).toString(),
                  progress: (kcal / kcalGoal).clamp(0, 1).toDouble(),
                  leadingMinText: '${(kcal / kcalGoal).clamp(0, 100).toDouble()}',
                  trailingGoalText: 'Goal ${formatNumber(kcalGoal)}',
                  trailingIcon: isDark
                      ? Image.asset('assets/images/kcal_dark.png', width: 180)
                      : Image.asset('assets/images/kcal_light.png', width: 180),
                ),
                if (controller.errorMessage.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }


  Widget _progressCard({
    required String title,
    required String valueText,
    required double progress,
    required String leadingMinText,
    required String trailingGoalText,
    required Image trailingIcon,
    required BuildContext context,
  }) {
    print(progress);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      decoration: BoxDecoration(
        color: isDark ? Color(0xff323232) : Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title:  $valueText',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                // width: MediaQuery.of(context).size.width * 0.68,
                child: LinearPercentIndicator(
                  backgroundColor: isDark
                      ? Color(0xff8A8A8A)
                      : Color(0xffC4C4C4),
                  width: MediaQuery.of(context).size.width * 0.66,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 3000,
                  percent: progress == 0.0 ? 0.0001 : progress,
                  animateFromLastPercent: true,
                  barRadius: Radius.circular(13),
                  // center: Text("50.0%"),
                  progressColor: !isDark ? Colors.black : Colors.white,
                  widgetIndicator: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(Icons.airplanemode_active, size: 50),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      leadingMinText,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),

                    Text(
                      trailingGoalText,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 52, height: 52, child: trailingIcon),
        ],
      ),
    );
  }
}
