import 'package:country_picker/country_picker.dart';

/// App Name
const APP_NAME = "Travello";

/// App Icon src
const APP_ICON = "assets/app_icon.png";

/// Splash screen image src
const SPLASH_SCREEN_IMAGE = 'assets/images/splash_image.png';

/// OneSignal Notification App Id
const ONESIGNAL_APP_ID = "07823ab7-e2f0-4a73-bce5-b3e26f8841a1";
const ONESIGNAL_REST_API = 'ZWU4Y2E3NTYtOTNkZC00ZTIxLWJmOTEtYjc0ZTFiNDRiZTg0';

/// NOTE: Do not add slash (/) or (https://) or (http://) at the end of your domain.
const WEB_SOCKET_DOMAIN = "travello.kz";

/// NOTE: Do not add slash (/) at the end of your domain.
const DOMAIN_URL = "https://travello.kz";
const BASE_URL = '$DOMAIN_URL/wp-json/';

/// AppStore Url
const IOS_APP_LINK = '';

/// Terms and Conditions URL
const TERMS_AND_CONDITIONS_URL = '$DOMAIN_URL/terms-condition/';

/// Privacy Policy URL
const PRIVACY_POLICY_URL = '$DOMAIN_URL/privacy-policy-2/';

/// Support URL
const SUPPORT_URL = '';

/// AdMod Id
// Android
const mAdMobAppId = '';
const mAdMobBannerId = '';

// iOS
const mAdMobAppIdIOS = '';
const mAdMobBannerIdIOS = '';

const mTestAdMobBannerId = '';

/// Woo Commerce keys

// live
const CONSUMER_KEY = '';
const CONSUMER_SECRET = '';

/// STRIPE PAYMENT DETAIL
const STRIPE_MERCHANT_COUNTRY_CODE = 'RU';
const STRIPE_CURRENCY_CODE = 'RUS';

/// RAZORPAY PAYMENT DETAIL
const RAZORPAY_CURRENCY_CODE = 'RUS';

/// AGORA
const AGORA_APP_ID = '';

Country defaultCountry() {
  return Country(
    phoneCode: '7',
    countryCode: 'RU',
    e164Sc: 7,
    geographic: true,
    level: 1,
    name: 'Kazakhstan',
    example: '7077777777',
    displayName: 'Kazakhstan (KZ) [+7]',
    displayNameNoCountryCode: 'Kazakhstan (KZ)',
    e164Key: '7-KZ-0',
    fullExampleWithPlusSign: '+77077777777',
  );
}
