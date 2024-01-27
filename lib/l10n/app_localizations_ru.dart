import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get languages => 'Языки';

  @override
  String get chooseLanguage => 'Выберите язык';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get firstName => 'Имя';

  @override
  String get enterFirstName => 'Введите ваше имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get enterLastName => 'Введите свою фамилию';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get password => 'Пароль';

  @override
  String get enterPassword => 'Введите ваш пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get enterConfirmPassword => 'Введите пароль для подтверждения';

  @override
  String get save => 'Сохранять';

  @override
  String get newAds => 'Новые объявления';

  @override
  String get title => 'Заголовок';

  @override
  String get enterProductTitle => 'Введите название продукта';

  @override
  String get description => 'Описание';

  @override
  String get enterDescription => 'Введите описание';

  @override
  String get changeLocation => 'Изменить местоположение';

  @override
  String get addressByLocation => 'Адрес по местоположению';

  @override
  String get enterAddress => 'Введите адрес карты';

  @override
  // TODO: implement enter
  String get enter => 'Авторизоваться';

  @override
  // TODO: implement signIn
  String get signIn => 'вход';

  @override
  // TODO: implement created
  String get created => "Созданный";

  @override
  // TODO: implement noCreated
  String get noCreated => "Не создано";
}
