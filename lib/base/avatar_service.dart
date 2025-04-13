import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:supabase_flutter/supabase_flutter.dart';

class AvatarService {
  static final _supabase = Supabase.instance.client;

  static Future<String?> uploadAvatar(File imageFile) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${user.id}.$fileExt'; // Persistent filename

      await _supabase.storage
          .from('avatars')
          .upload(
            fileName,
            imageFile,
            fileOptions: FileOptions(
              contentType: 'image/$fileExt',
              cacheControl: '3600', // 1-hour cache
            ),
          );

      return _supabase.storage
          .from('avatars')
          .getPublicUrl(fileName);
    } catch (e) {
      debugPrint('Avatar upload error: $e');
      return null;
    }
  }

  static Future<void> deleteOldAvatar(String url) async {
    try {
      final fileName = url.split('/').last;
      await _supabase.storage
          .from('avatars')
          .remove([fileName]);
    } catch (e) {
      debugPrint('Avatar deletion error: $e');
    }
  }
}