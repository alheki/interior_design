import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';

part 'notifications_state.dart';

class NotificationModel extends Equatable {
  final String title;
  final String body;
  final DateTime timestamp;

  const NotificationModel({
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] as String,
      body: json['body'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  List<Object?> get props => [title, body, timestamp];
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsLoading());
    try {
      final jsonString = await rootBundle.loadString('assets/data/notifications.json');
      final jsonData = json.decode(jsonString);
      final notifications = (jsonData['notifications'] as List)
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();
      
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError('Failed to load notifications: $e'));
    }
  }
}