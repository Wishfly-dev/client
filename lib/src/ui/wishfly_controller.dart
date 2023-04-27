import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:wishfly/src/core/ext/list_wish_response.dart';
import 'package:wishfly/src/core/result.dart';
import 'package:wishfly/src/io/api/api.dart';
import 'package:wishfly/src/io/managers/voted_wish_manager.dart';
import 'package:wishfly_shared/wishfly_shared.dart' hide Result;

class WishflyController extends ChangeNotifier {
  final WishflyApiClient _apiClient;
  final VotedWishManager _votedWishManager;

  /// Project ID to identify key with project
  final int _projectId;

  Result<Exception, List<WishResponseDto>> fetchWishResult = Result.loading();
  Result<Exception, Unit> newWishResult = Result.loading();
  Result<Exception, Unit> voteResult = Result.loading();

  List<WishResponseDto> get wishes => fetchWishResult.getOrElse ?? [];

  WishflyController({
    WishflyApiClient? apiClient,
    VotedWishManager? votedWishManager,
    required String apiKey,
    required int projectId,
  })  : _apiClient = apiClient ?? WishflyApiClient(apiKey: apiKey),
        _votedWishManager = votedWishManager ?? PrefVotedWishManager(),
        _projectId = projectId;

  Future<void> refresh() async => fetchProject();

  Future<void> fetchProject() async {
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

  Future<void> vote(WishResponseDto wish) async {
    try {
      final votedWishes = await _votedWishManager.getVotedWishes();
      if (votedWishes.contains("${wish.id}")) return;

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
}
