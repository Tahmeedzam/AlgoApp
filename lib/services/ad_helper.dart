import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

class AdHelper {
  static RewardedInterstitialAd? _rewardedInterstitialAd;

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return dotenv.env['homeScreenBanner_UnitId'] ?? ' '; // fallback test ad
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return dotenv.env['onCardClick_UnitId'] ?? ''; // fallback test ad
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  static Future<void> handleAlgoClickWithAd(Function onAdClosed) async {
    print('🟡 Algo Card Clicked');
    print(dotenv.env['onCardClick_UnitId']);

    final docRef = FirebaseFirestore.instance
        .collection('adCounter')
        .doc('onAlgoClickCounter');

    try {
      final doc = await docRef.get();

      if (!doc.exists || !doc.data()!.containsKey('count')) {
        await docRef.set({'count': 6});
      }

      int count = doc.data()?['count'] ?? 6;
      print('🔢 Current count: $count');

      if (count > 1) {
        await docRef.update({'count': count - 1});
        onAdClosed(); // No ad yet
      } else {
        await docRef.update({'count': 6});
        _showRewardedInterstitialAd(onAdClosed);
      }
    } catch (e) {
      print('🔥 Error handling ad counter: $e');
      onAdClosed(); // fallback
    }
  }

  static void _showRewardedInterstitialAd(Function onAdClosed) {
    final unitId = rewardedAdUnitId;

    RewardedInterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          _rewardedInterstitialAd = ad;
          print('✅ Rewarded interstitial loaded');

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('📴 Ad dismissed');
              ad.dispose();
              onAdClosed();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              print('❌ Failed to show ad: $error');
              ad.dispose();
              onAdClosed();
            },
          );

          ad.show(
            onUserEarnedReward: (_, reward) {
              print('🎁 User earned reward: ${reward.amount}');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('❌ Failed to load ad: $error');
          onAdClosed(); // fallback
        },
      ),
    );
  }
}
