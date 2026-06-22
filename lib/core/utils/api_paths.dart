class ApiPaths {
  static String user(String userId) => "users/$userId";
  static String admin(String adminId) => "admins/$adminId";
  static String properties([String? propertyId]) =>
      propertyId != null ? "properties/$propertyId" : "properties";

  // ⭐ مفضلة المستخدم
  static String favoritePropertiesUser(String userId) =>
      "users/$userId/favorites";

  static String favoritePropertyUser(String userId, String propertyId) =>
      "users/$userId/favorites/$propertyId";

  // ⭐ مفضلة الأدمن
  static String favoritePropertiesAdmin(String adminId) =>
      "admins/$adminId/favorites";

  static String favoritePropertyAdmin(String adminId, String propertyId) =>
      "admins/$adminId/favorites/$propertyId";
}
