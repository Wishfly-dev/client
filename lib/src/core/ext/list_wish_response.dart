import 'package:wishfly_shared/wishfly_shared.dart';

extension ListWishResponse on List<WishResponseDto> {
  List<WishResponseDto> get filterOnlyApproved =>
      where((item) => item.state == "APPROVED" || item.state == "TODO")
          .toList();
}
