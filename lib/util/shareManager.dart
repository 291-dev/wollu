import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:social_share/social_share.dart';

class ShareManager {
  shareSMS() async {
    String? result = await FlutterSocialContentShare.shareOnSMS(
        recipients: ["xxxxxx"], text: "Text appears here");
    print(result);
  }

  shareOnTwitter() async {
    SocialShare.shareTwitter(
      "회사에서 나는 어떤 루팡일까?",
      hashtags: [
        "월루",
        "월급",
        "루팡",
        "사장님돈내꺼",
        "개꿀",
        "꽁돈"
      ],
      url: "https://wollu.me",
      trailingText: "월루 체험하기",
    ).then((data) {
      print(data);
    });
  }

  Future shareOnKakao() async {
    bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

    final FeedTemplate defaultFeed = FeedTemplate(
      content: Content(
        title: '월급루팡',
        description: '회사에서 나는 어떤 루팡일까?\n#월루 #월급 #루팡 #사장님돈내꺼 #개꿀 #꽁돈',
        imageUrl: Uri.parse(
            'https://wollu-img.s3.ap-northeast-2.amazonaws.com/wollu.png'),
        link: Link(
            webUrl: Uri.parse('https://wollu.me'),
            mobileWebUrl: Uri.parse('https://wollu.me')),
      ),
      social: Social(likeCount: 50000, commentCount: 542, sharedCount: 1436),
      buttons: [
        Button(
          title: '웹으로 보기',
          link: Link(
            webUrl: Uri.parse('https: //wollu.me'),
            mobileWebUrl: Uri.parse('https: //wollu.me'),
          ),
        ),
        Button(
          title: '앱으로보기',
          link: Link(
            androidExecutionParams: {'key1': 'value1', 'key2': 'value2'},
            iosExecutionParams: {'key1': 'value1', 'key2': 'value2'},
          ),
        ),
      ],
    );

    if (isKakaoTalkSharingAvailable) {
      try {
        Uri uri =
        await ShareClient.instance.shareDefault(template: defaultFeed);
        await ShareClient.instance.launchKakaoTalk(uri);
        print('카카오톡 공유 완료');
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    } else {
      try {
        Uri shareUrl = await WebSharerClient.instance
            .makeDefaultUrl(template: defaultFeed);
        await launchBrowserTab(shareUrl, popupOpen: true);
      } catch (error) {
        print('카카오톡 공유 실패 $error');
      }
    }
  }

  shareOnFacebook() async {
    String? result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://wollu.me",
        quote: "captions"
    );
    print(result);
  }

  Future<String?> shareOnInstagram() async {
    return await FlutterSocialContentShare.share(
        type: ShareType.instagramWithImageUrl,
        imageUrl:
        "https://wollu-img.s3.ap-northeast-2.amazonaws.com/wollu.png");
  }
}