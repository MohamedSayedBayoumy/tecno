class EndPoints {
  String categories = '/categories';
  String subCategories = '/sub-categories';
  String subCategoryProducts = '/category-products';
  String itemDetails = '/item-details';
  String offers = '/offers';
  String pages = '/pages';
  String page({required int page}) {
    return '/pages/$page';
  }

  String home = '/home';
  String featuredCategories = '/featured-categories';
  String vendorDetails = '/vendor-details';
  String language = '/get-languages';

  // auth
  String login = '/login';
  String forgotPassword = '/forgot-password';
  String reSendOTP = '/resend-otp';
  String verifyOtp = '/verify-otp';
  String resetPassword = '/reset-password';
  String register = '/register';
  String profile = '/profile';
  String updateProfile = '/profile/update';
  String addresses = '/addresses';
  String brands = '/brands';

  String setAddressDefault(id) => '/addresses/$id/set-default';
  // /addresses/2/set-default
  String governorates = '/governorates';
  String countries = '/countries';
  String addAddress = '/add-address';
  String updateAddress = '/update-address';
  String deleteAccount = '/delete-account';
  String updateShipAddress = '/profile/update-ship-address';
  String updateBillAddress = '/profile/update-bill-address';
  // cart
  String addToCart = '/add-to-cart';
  String getCart = '/get-cart';
  String deleteCartItem = '/delete-cart-item';
  String updateCartItem = '/update-cart';
  // order
  String placeOrder = '/place-order';
  String orders = '/orders';
  String rateOrder = "/rate-order";
  String rateItem = "/rate-item";
  String orderDetails = '/order-details';
  String cancelOrder = '/cancel-order';
  String paymentMethods = '/get-payment-methods';
  // wishlist
  String addToWishList = '/add-wishlist';
  String notifications = '/notification/user-notifications';
  String comments = '/item-reviews';
  String wishList = '/wishlist';
}
