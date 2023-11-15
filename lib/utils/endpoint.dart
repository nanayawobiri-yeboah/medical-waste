class ApiEndpoints {
  
  static const loginUserUrl = "/login";

  static const resetPasswordUrl = "/reset-password";

//Profile

  static const updateProfileUrl = "/profile";
  static const getUserProfileUrl = "/profile";
  static const changePasswordUrl = "/profile/password";

//Get Dropdown Settings

  static const getRegionsUrl = "/regions-districts";
  static const getCustomerTypesUrl = "/customer-types";
  static const getWasteTypesUrl = "/waste-types";
  static const getVehicleUrl = "/vehicles";

  //Registration

  static const customerRegUrl = "/regions-districts";
  static const fetchCustomerTypesUrl = "/customer-types/show";
  static const fetchCustomerInvoiceUrl = "/customer/invoice";
  static const wastePickupUrl = "/pickup";
  static const fuelPurchasedUrl = "/fuel-purchased";

  //Payments
  static const cashPaymentUrl = "/payment";
  static const monoPaymentUrl = "/cms/pay";


}
