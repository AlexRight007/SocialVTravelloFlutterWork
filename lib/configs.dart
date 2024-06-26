import 'package:country_picker/country_picker.dart';

/// App Name
const APP_NAME = "Dami Tour";

/// App Icon src
const APP_ICON = "assets/app_icon.png";

/// Splash screen image src
const SPLASH_SCREEN_IMAGE = 'assets/images/splash_image.png';

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
const SUPPORT_URL = 'https://iqonic.desky.support';

/// AdMod Id
// Android
const mAdMobAppId = '';
const mAdMobBannerId = '';

// iOS
const mAdMobAppIdIOS = '';
const mAdMobBannerIdIOS = '';

//Todo : Always add this test key to manifest file after update
const mTestAdMobBannerId = 'ca-app-pub-7567158629149653~2821182377';

/// Woo Commerce keys

// live
const CONSUMER_KEY = '';
const CONSUMER_SECRET = '';

/// STRIPE PAYMENT DETAIL
const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';
const STRIPE_CURRENCY_CODE = 'INR';

/// RAZORPAY PAYMENT DETAIL
const RAZORPAY_CURRENCY_CODE = 'INR';

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
