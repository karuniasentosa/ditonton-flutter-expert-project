import 'package:dartz/dartz.dart';
import 'package:core/failure.dart';
import 'package:tv_series/usecases.dart' show GetTvSeriesDetail;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

import 'mockhelper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTvSeriesDetail getTvSeriesDetail;

  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvSeriesDetail = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  test('should return a data when no error occured', () async {
    // ararnge
    when(mockTvSeriesRepository.getTvSeriesDetail(id: 2))
        .thenAnswer((_) async => Right(tTvSeriesDetail));

    // act
    final result = getTvSeriesDetail.execute(2);

    // assert
    expect(await result, Right(tTvSeriesDetail));
  });

  test('should return left when an error occured', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(id: 2))
        .thenAnswer((_) async => Left(ServerFailure('')));

    // act
    final result = getTvSeriesDetail.execute(2);

    // assert
    expect(await result, Left(ServerFailure('')));
  });
}