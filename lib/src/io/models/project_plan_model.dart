enum ProjectPlan {
  unknown,
  free,
  paid;
}

extension ProjectPlanExt on String {
  ProjectPlan get toProjectPlan {
    switch (this) {
      case 'free':
        return ProjectPlan.free;
      case 'pay':
        return ProjectPlan.paid;
      default:
        throw Exception('Unknown project plan: $this');
    }
  }
}
