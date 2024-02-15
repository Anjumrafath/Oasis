import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_cleanarchitecture/features/domain/entity/reply/replyentity.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/replay/createreplayusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/replay/deletereplayusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/replay/likereplayusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/replay/readreplayusecase.dart';
import 'package:insta_cleanarchitecture/features/domain/usecases/replay/updatereplayusecase.dart';
import 'package:insta_cleanarchitecture/features/presentation/cubit/replay/replaystate.dart';

class ReplayCubit extends Cubit<ReplayState> {
  final CreateReplayUseCase createReplayUseCase;
  final DeleteReplayUseCase deleteReplayUseCase;
  final LikeReplayUseCase likeReplayUseCase;
  final ReadReplaysUseCase readReplaysUseCase;
  final UpdateReplayUseCase updateReplayUseCase;
  ReplayCubit(
      {required this.createReplayUseCase,
      required this.updateReplayUseCase,
      required this.readReplaysUseCase,
      required this.likeReplayUseCase,
      required this.deleteReplayUseCase})
      : super(ReplayInitial());

  Future<void> getReplays({required ReplayEntity replay}) async {
    emit(ReplayLoading());
    try {
      // Calling the readReplaysUseCase to fetch replays
      final streamResponse = readReplaysUseCase.call(replay);
      // Listening to the stream response
      streamResponse.listen((replays) {
        // Emitting a state with the received replays when they are available
        emit(ReplayLoaded(replays: replays));
      });
    } on SocketException catch (_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> likeReplay({required ReplayEntity replay}) async {
    try {
      // Call the likeReplayUseCase to like the replay
      await likeReplayUseCase.call(replay);
    } on SocketException catch (_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> createReplay({required ReplayEntity replay}) async {
    try {
      // Call the createReplayUseCase to create the replay
      await createReplayUseCase.call(replay);
    } on SocketException catch (_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> deleteReplay({required ReplayEntity replay}) async {
    try {
      // Call the deleteReplayUseCase to delete the replay
      await deleteReplayUseCase.call(replay);
    } on SocketException catch (_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> updateReplay({required ReplayEntity replay}) async {
    try {
      // Call the updateReplayUseCase to update the replay
      await updateReplayUseCase.call(replay);
    } on SocketException catch (_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }
}
