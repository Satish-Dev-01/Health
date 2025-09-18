import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final steps = 0.obs;
  final kCalories = 0.0.obs;
  final isFetching = false.obs;
  final errorMessage = ''.obs;
  final stepsGoal = 100.obs;
  final kcalGoal = 2000.obs;

  final Health _health = Health();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initFlow();
    });
  }

  Future<void> _initFlow() async {
    final granted = await _askPermissions();
    if (granted) {
      await fetchTodayHealth();
    } else {
      errorMessage.value = 'Permissions required to fetch health data';
    }
  }

  Future<bool> _askPermissions() async {
    final status = await Permission.activityRecognition.request();
    if (!status.isGranted) return false;

    final types = <HealthDataType>[
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final permissions = types.map((t) => HealthDataAccess.READ).toList();

    final authorized = await _health.requestAuthorization(
      types,
      permissions: permissions,
    );
    return authorized;
  }

  Future<void> refreshPage() async {
    fetchTodayHealth();
    fetchTodayHealth();
  }

  Future<void> fetchTodayHealth() async {
    isFetching.value = true;
    errorMessage.value = '';

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    try {
      int totalSteps =
          await _health.getTotalStepsInInterval(midnight, now) ?? 0;

      final energy = await _health.getHealthDataFromTypes(
        startTime: midnight,
        endTime: now,
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      );

      double kcal = 0.0;
      for (final d in energy) {
        if (d.value is double) kcal += d.value as double;
      }

      steps.value = totalSteps;
      kCalories.value = kcal;
    } catch (e) {
      errorMessage.value = 'Failed to fetch health data: $e';
    } finally {
      isFetching.value = false;
    }
  }
}
