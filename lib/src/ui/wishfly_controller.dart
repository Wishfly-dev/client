import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:wishfly/src/core/ext/list_wish_response.dart';
import 'package:wishfly/src/core/result.dart';
import 'package:wishfly/src/io/managers/voted_wish_manager.dart';
import 'package:wishfly/src/io/models/project_plan_model.dart';
import 'package:wishfly_api_client/wishfly_api_client.dart';
import 'package:wishfly_shared/wishfly_shared.dart' hide Result;

class WishflyController extends ChangeNotifier {
  final WishflyApiClient _apiClient;
  final VotedWishManager _votedWishManager;

  /// Project ID to identify key with project
  final int _projectId;

  /// Represents the plan user is current on [ProjectPlan]
  ProjectPlan userCurrentPlan = ProjectPlan.unknown;

  /// Result of fetching wishes
  Result<Exception, List<WishResponseDto>> fetchWishResult = Result.loading();

  /// Result of creating a new wish
  Result<Exception, Unit> newWishResult = Result.loading();

  /// Result of voting on a wish
  Result<Exception, Unit> voteResult = Result.loading();

  WishflyController({
    WishflyApiClient? apiClient,
    VotedWishManager? votedWishManager,
    required String apiKey,
    required int projectId,
  })  : _apiClient = apiClient ?? WishflyApiClient(apiKey: apiKey),
        _votedWishManager = votedWishManager ?? PrefVotedWishManager(),
        _projectId = projectId {
    fetchProjectInfo();
  }

  Future<void> refresh() async => _fetchProject();

  Future<void> fetchProjectInfo() async => Future.wait([
        _fetchProject(),
        _fetchProjectDetail(),
      ]);

  Future<void> _fetchProject() async {
    try {
      final project = await _apiClient.getProject(id: _projectId);
      final wishes = project.wishes.filterOnlyApproved;
      fetchWishResult = Result.success(wishes);
    } on Exception catch (e) {
      debugPrint(e.toString());

      fetchWishResult = Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchProjectDetail() async {
    try {
      final projectDetail = await _apiClient.getProjectPlan(id: _projectId);
      userCurrentPlan = projectDetail.currentPlan.toProjectPlan;
    } on Exception catch (e) {
      debugPrint(e.toString());
      userCurrentPlan = ProjectPlan.free;
    } finally {
      notifyListeners();
    }
  }

  Future<void> createNewWish(String title, String description) async {
    try {
      await _apiClient.createWish(
        request: WishRequestDto(
          title: title,
          description: description,
          projectId: _projectId,
        ),
      );
      newWishResult = Result.success(voidUnit);
      await refresh();
    } on Exception catch (e) {
      debugPrint(e.toString());
      newWishResult = Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleVote(WishResponseDto wish) async {
    final votedWishes = await _votedWishManager.getVotedWishes();
    if (votedWishes.contains("${wish.id}")) {
      await _removeVote(wish);
    } else {
      await _addVote(wish);
    }
  }

  Future<void> _addVote(WishResponseDto wish) async {
    try {
      await _apiClient.vote(wishId: wish.id);
      await _votedWishManager.addVotedWish(wish.id);
      voteResult = Result.success(voidUnit);
      await refresh();
    } on Exception catch (e) {
      debugPrint(e.toString());
      voteResult = Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> _removeVote(WishResponseDto wish) async {
    try {
      await _apiClient.removeVote(wishId: wish.id);
      await _votedWishManager.removeVotedWish(wish.id);
      voteResult = Result.success(voidUnit);
      await refresh();
    } on Exception catch (e) {
      debugPrint(e.toString());
      voteResult = Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
