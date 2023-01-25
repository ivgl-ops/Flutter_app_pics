# Тестовое задание для EvoSoft

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white) ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

# 📓Используемые библиотеки 
  - provider: ^6.0.5
  - flutter_dropdown_alert: ^1.0.7
  - shared_preferences: ^2.0.17
  - flutter_spinkit: ^5.1.0
  - google_fonts: ^3.0.1

# Задание 

## 📱Первый экран - авторизация. 

  - ✅ На экране должно быть поле ввода для номера телефона и кнопка "Запросить смс".
  - ✅ После нажатия кнопки, при корректно вводе номере, появляется поле для вводакода из смс (номер: +79998887766 код для входа: 1111).
  - ✅ В течении 60 сек. после запроса кода идет таймер, после которого смс можно запросить повторно.
  - ✅ Если пользователь ввел корректный код, то приложение переходит на экран сосписком.
  - ✅ Предусмотреть ошибки - некорректный номер телефона, некорректный код изсмс.
  - ✅ При повторном открытии приложения, если пользователь уже был авторизирован, сразу открывать экран со списком.
  - ✅ При запросе смс и вводе кода сделать задержку 2 сек. для имитации сетевого запроса.

## 📱Второй экран - список изображений 

  - ✅ Отображается список изображений, загруженных из сети (любые, просто по url)
  - ✅ За раз в списке отображается 10 картинок.
  - ✅ При прокрутке списка вниз, подгружаются новые картинки. (1-2 раза достаточно)
  - ✅ Для имитации сетевого запроса при подгрузке сделать задержку 2 сек. Перед добавлением новых картинок в список.
  - ✅ При нажатии на картинку, открывается экран для просмотра изображения
  - ✅ В тулбаре должна быть кнопка для выхода из аккаунта на экран авторизации.

## 📱Третий экран - просмотр изображения 

  - ✅ По центру экрана открытое изображение
  - ✅ В тулбаре кнопка для удаления изображения.
  - ✅ После удаления изображение так-же должно пропасть из списка
  - ✅ После удаления изображения не должно быть в списке при повторном открытииприложения.
  - ✅ При удалении изображения сделать задержку 2 сек. для имитации сетевого запроса.
  
# Как запустить проект?

Шаг 1: Склонируйте проект на свой компьютер 

```sh
git clone https://github.com/ivgl-ops/Flutter_app_pics.git

```

Шаг 2: Перейдите в проект и добавьте зависимости 

```sh
cd test_pic
flutter pub get

```

Шаг 3: Запустите проект

```sh
flutter run

```

# Демонстрация работы готового приложения 
В данном видеофайле представлена работа основного функционала приложения. 
Прошу обратить внимание, что видео ускоренное(X2).




https://user-images.githubusercontent.com/63240378/214326956-8a4de547-c3c7-4625-ba55-fc3e31fd83eb.mp4




