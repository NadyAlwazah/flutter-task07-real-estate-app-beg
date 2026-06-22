class ApiPaths {
  static String user(String userId) => "users/$userId";
  static String admin(String adminId) => "admins/$adminId";
  static String properties([String? propertyId]) =>
      propertyId != null ? "properties/$propertyId" : "properties";
}
