# pinkipie

- При першому відкриті програми слід отримати дані про ріст та вагу користувача. Тут слід реалізувати два сценарія: отримання даних зі "Здоров'я"(дозвіл користувача на отримання даних - HealthKit) чи користувач самостійно вводить свої дані.
- Можливість перегляду статистики  спожитих калорій за місяць - Core Graphics, CoreData
-  Сповіщення/нагадування про сніданок/обід/вечерю (потрібно отримати дозвіл від користувача на відправлення сповіщеннь) - NotificationCenter
- Можливість запису прийому їжі (вибір продукту та граммів) (реалізувати єдину БД з їжею - CoreData/SQLite)
- на головній сторінці буде знаходитись: 
добова норма калорій та скільки залишилось;
рекомендації по кількості калорій на сніданок/обід/вечерю;
відображення спожитих поживних цінностей;


https://developer.edamam.com/ - АПІшка для бази з їжею, кількість калорій до кожного продукту, також є рекомендації по дієтам та аллергіям і т.д.

## Development

- Install Pods `sudo gem install cocoapods` (requires gem)
- Run `pod install`
