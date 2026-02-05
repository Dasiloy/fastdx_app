import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';

final reviewsProvider =
    FutureProvider.family<List<AppReview>, ListReviewsParams>((
      ref,
      params,
    ) async {
      return ReviewApi.list(params);
    });

final reviewAggregateProvider =
    FutureProvider.family<ReviewAggregate, ReviewAggregateParams>((
      ref,
      params,
    ) async {
      return ReviewApi.getAggregate(params);
    });
