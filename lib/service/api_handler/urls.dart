

//#region service
import 'package:home_services_app/service/environment/environment_config.dart';

final String offersUrl = '${apiBaseUrl()}assets/data/home.json';
final String servicesUrl = '${apiBaseUrl()}assets/data/services.json';

//#endregion


//#region lookup
 final String recipientTypesUrl = '${apiBaseUrl()}assets/data/recipient_types.json';
 final String countriesUrl = '${apiBaseUrl()}assets/data/countries_list.json';

//#endregion


//#region User
 final String registerUrl = '${apiBaseUrl()}assets/data/register.json';
 final String loginUrl = '${apiBaseUrl()}assets/data/login.json';
 final String verifyOTPUrl = '${apiBaseUrl()}assets/data/login.json';
final String resendOTPUrl = '${apiBaseUrl()}assets/data/register.json';
final String forgetPasswordUrl = '${apiBaseUrl()}assets/data/register.json';
final String validateForgetPasswordOTPUrl = '${apiBaseUrl()}assets/data/normal_api.json';
final String resetPasswordUrl = '${apiBaseUrl()}assets/data/normal_api.json';

//#endregion


//#region category
final String serviceMainCategoriesUrl = '${apiBaseUrl()}assets/data/service_main_categories.json';
final String serviceSubCategoriesUrl = '${apiBaseUrl()}assets/data/service_sub_categories.json';

//#endregion

//#region Salon
final String salonsUrl = '${apiBaseUrl()}assets/data/salons.json';
final String salonsDetailsUrl = '${apiBaseUrl()}assets/data/salon_details.json';
final String favoritesSalonsUrl = '${apiBaseUrl()}assets/data/favorites_list.json';

//#endregion


//#region service
final String bookingServicesList = '${apiBaseUrl()}assets/data/booking_services_list.json';
final String serviceWaysUrl = '${apiBaseUrl()}assets/data/service_way_list.json';
final String serviceAvailableCalendar = '${apiBaseUrl()}assets/data/service_available_calendar.json';

//#endregion

//#region Payment and Invoice
final String paymentMethodsUrl = '${apiBaseUrl()}assets/data/payment_method.json';
final String serviceInvoiceUrl = '${apiBaseUrl()}assets/data/service_invoice.json';
final String savedPaymentCards = '${apiBaseUrl()}assets/data/saved_payment_cards.json';

//#endregion

//#region Booking
final String bookingsListUrl = '${apiBaseUrl()}assets/data/bookings_list.json';
final String bookingDetailsUrl = '${apiBaseUrl()}assets/data/booking_details.json';

//#endregion

