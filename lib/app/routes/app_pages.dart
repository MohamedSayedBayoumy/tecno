import 'package:customer/app/modules/bottom_sheet_screen.dart';
import 'package:customer/app/modules/brands/bindings/brands_binding.dart';
import 'package:customer/app/modules/brands/controller/brands_controller.dart';
import 'package:customer/app/modules/edit_profile.dart/bindings/edit_profile_binding.dart';
import 'package:customer/app/modules/edit_profile.dart/views/edit_profile_screen.dart';
import 'package:customer/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:customer/app/modules/forgot_password/views/otp_view.dart';
import 'package:customer/app/modules/invoice/invoice_details_screen.dart';
import 'package:customer/app/modules/item_details/views/comments_screen.dart';
import 'package:customer/app/modules/page/bindings/page_binding.dart';
import 'package:customer/app/modules/reviews/bindings/reviews_binding.dart';
import 'package:customer/app/modules/reviews/views/reviews_view.dart';
import 'package:customer/app/modules/splash_screen.dart';
import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/addresses/bindings/addresses_binding.dart';
import '../modules/addresses/views/add_addresses_view.dart';
import '../modules/addresses/views/address_list.dart';
import '../modules/addresses/views/google_map_view.dart';
import '../modules/auth_module/Register/bindings/register_binding.dart';
import '../modules/auth_module/Register/views/register_view.dart';
import '../modules/auth_module/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth_module/sign_in/views/sign_in_view.dart';
import '../modules/brands/views/brands_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/checkOut/bindings/check_out_binding.dart';
import '../modules/checkOut/views/check_out_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/passwords_fields.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/order_module/order_details/views/cancel_order_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/item_details/bindings/item_details_binding.dart';
import '../modules/item_details/views/item_details_view.dart';
import '../modules/item_filters/bindings/item_filters_binding.dart';
import '../modules/item_filters/views/item_filters_view.dart';
import '../modules/offers/bindings/offers_binding.dart';
import '../modules/offers/views/offers_view.dart';
import '../modules/order_module/order_details/bindings/order_details_binding.dart';
import '../modules/order_module/order_details/views/order_details_view.dart';
import '../modules/order_module/orders/bindings/orders_binding.dart';
import '../modules/order_module/orders/views/orders_view.dart';
import '../modules/page/views/page_view.dart';
import '../modules/payments/bindings/payment_binding.dart';
import '../modules/payments/views/payment_details_screen.dart';
import '../modules/payments/views/payment_view.dart';
import '../modules/policies/bindings/policies_binding.dart';
import '../modules/policies/views/policies_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/filter_screen.dart';
import '../modules/search/views/search_view.dart';
import '../modules/vendor_details/views/vendor_details_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';
import '../modules/contact/views/contact_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static routes() => [
        GetPage(
          name: _Paths.splash,
          page: () {
            return const SplashScreen();
          },
        ),
        GetPage(
          name: _Paths.brands,
          page: () {
            return const BrandsView();
          },
          bindings: [
            BrandsBinding(),
            SearchBinding(),
          ],
        ),
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: _Paths.CART,
          page: () => CartView(),
          bindings: [CartBinding(), HomeBinding(), CheckOutBinding()],
        ),
        GetPage(
          name: _Paths.CATEGORIES,
          page: () => const CategoriesView(),
          binding: CategoriesBinding(),
        ),
        GetPage(
          name: _Paths.OFFERS,
          page: () => const OffersView(),
        ),
        GetPage(
          name: _Paths.ACCOUNT,
          page: () => const AccountView(),
          binding: AccountBinding(),
        ),
        GetPage(
          name: _Paths.ITEM_DETAILS,
          page: () => const ItemDetailsView(),
          bindings: [
            HomeBinding(),
            InvoiceBinding(),
            CheckOutBinding(),
            CartBinding(),
            ItemDetailsBinding()
          ],
        ),
        GetPage(
          name: _Paths.Comments,
          page: () => const CommentsScreen(),
        ),
        GetPage(
          name: _Paths.ITEM_FILTERS,
          page: () => const ItemFiltersView(),
          binding: ItemFiltersBinding(),
        ),
        GetPage(
          name: _Paths.filter,
          page: () => const FilterScreen(),
          bindings: [
            BrandsBinding(),
            SearchBinding(),
          ],
        ),
        GetPage(
          name: _Paths.SEARCH,
          page: () => const SearchView(),
          bindings: [
            BrandsBinding(),
            SearchBinding(),
          ],
        ),
        GetPage(
          name: _Paths.SIGN_IN,
          page: () => const SignInView(),
          binding: SignInBinding(),
        ),
        GetPage(
          name: _Paths.PAYMENTS,
          page: () => const PaymentViewScreen(),
          binding: PaymentsBinding(),
        ),
        GetPage(
          name: _Paths.PAYMENTSDETAILS,
          page: () => const PaymentDetailsScreen(),
          binding: PaymentsBinding(),
        ),
        GetPage(
          name: _Paths.RESETPASSWORD,
          page: () => const ResetPasswordView(),
          binding: ResetPasswordBinding(),
        ),
        GetPage(
          name: _Paths.FORGOTPASSWORD,
          page: () => const ForgotPasswordView(),
          binding: ForgotPasswordBinding(),
        ),
        GetPage(
          name: _Paths.OTP,
          page: () => const OtpView(),
          binding: ForgotPasswordBinding(),
        ),
        GetPage(
          name: _Paths.fieldsPasswords,
          page: () => const PasswordsFieldsScreen(),
          binding: ResetPasswordBinding(),
        ),
        GetPage(
          name: _Paths.REGISTER,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: _Paths.CHECK_OUT,
          page: () => const CheckOutView(),
          bindings: [CheckOutBinding()],
        ),
        GetPage(
          name: _Paths.cancelOrder,
          page: () => const CancelOrderView(),
          binding: OrderDetailsBinding(),
        ),
        GetPage(
          name: _Paths.ADDADDRESSES,
          page: () => const AddressListScreen(),
          binding: AddressesBinding(),
        ),
        GetPage(
          name: _Paths.address,
          page: () => const AddAddressesView(),
          binding: AddressesBinding(),
        ),
        GetPage(
          name: _Paths.reviews,
          page: () => const ReviewScreen(),
          binding: ReviewsBinding(initValues: true),
        ),
        GetPage(
          name: _Paths.ORDERS,
          page: () => const OrdersView(),
          bindings: [
            OrdersBinding(),
            ReviewsBinding(initValues: false),
          ],
        ),
        GetPage(
          name: _Paths.ORDER_DETAILS,
          page: () => const OrderDetailsView(),
          bindings: [
            HomeBinding(),
            CheckOutBinding(),
            CartBinding(),
            OrderDetailsBinding()
          ],
        ),
        GetPage(
          name: _Paths.WISHLIST,
          page: () => const WishlistView(),
          binding: WishlistBinding(),
        ),
        GetPage(
          name: _Paths.POLICIES,
          page: () => const PoliciesView(),
          binding: PoliciesBinding(),
        ),
        GetPage(
          name: _Paths.EditProfile,
          page: () => const EditProfileScreen(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: _Paths.VENDOR_DETAILS,
          page: () => const VendorDetailsView(),
        ),
        GetPage(
          name: _Paths.PAGE,
          page: () => const PageView(),
          binding: PageBinding(),
        ),
        GetPage(
          name: _Paths.notification,
          page: () => const NotificationView(),
          binding: NotificationBinding(),
        ),
        GetPage(
          name: _Paths.SIGNIN,
          page: () => const SignInView(),
          binding: SignInBinding(),
        ),
        GetPage(
          name: _Paths.SIGNUP,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: _Paths.googleMapView,
          page: () => const GoogleMapView(isFullView: true),
        ),
        GetPage(
          name: _Paths.invoiceDetails,
          page: () => const InvoiceDetailsScreen(),
          binding: InvoiceBinding(),
        ),
        GetPage(
          name: _Paths.BOTTOMSHEET,
          page: () => const BottomSheetScreen(),
          bindings: [
            HomeBinding(),
            InvoiceBinding(),
            OrdersBinding(),
            CartBinding(),
            // OffersBinding(),
            CategoriesBinding(),
            AccountBinding(),
          ],
        ),
        GetPage(
          name: _Paths.CONTACT,
          page: () => const ContactView(),
        ),
      ];
}
