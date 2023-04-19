const String BASE_URL = "http://192.168.1.102:8000/api/";
const String LOGIN_URL = "${BASE_URL}login";
const String REGISTER_URL = "${BASE_URL}register";
const String LOGOUT_URL = "${BASE_URL}logout";
const String CATEGORIES_URL = "${BASE_URL}categories";
String productsByCategoryUrl(int categoryId) =>
    "${BASE_URL}categories/$categoryId/products";
const String CART_URL = "${BASE_URL}carts";
const String USER_URL = "${BASE_URL}users";
const String PROFILE_URL = "${BASE_URL}profile";
const String PRODUCTS_URL = "${BASE_URL}products";
const String SHIPPING_ADDRESS_URL = "${BASE_URL}shipping-address";

const Map<String, String> HEADERS = {'Accept': 'application/json'};
