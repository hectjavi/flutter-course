class ApiConstants {
  // URL cuando tengas el backend
  static const String baseUrl = 'https://api/v1';
  
  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  
  // Dashboard
  static const String accountSummary = '/account/summary';
  static const String transactions = '/transactions';
  static const String transfer = '/transfer';
  
  // Configuración
  static const String userProfile = '/user/profile';
  static const String settings = '/user/settings';
}
