---
layout: post
title:  "2019, первая неделя января"
<!--date:   2018-01-01 21:57:21 +0300-->
categories: postgresql achievements-diary nginx django vuejs
---
1. <a href='#nginx'>Nginx ivp6, новый ssl-сертификат</a>
1. <a href='#django-salted-hmac'>Изучение django</a>
1. <a href='#vue-js-first-steps'>Первые 2 урока Vue.js</a>
1. <a href='#jekyll-markdown'>Jekyll и agusmakmuun шаблон</a>


### <a href='#django-salted-hmac' name='django-salted-hmac'>Изучение django</a>

**django.utils.encoding**: 

В модуле есть базовые функции `force_text` и `force_bytes`. Для каждой из них есть версия **smart**. Которая проверяет, не является ли объект на входе _Promise_ (специальный lazy объект, который не нужно вычислять об этом будет статья дальше `TODO: кросссылка на обзор django.utils.functional.lazy`)

| функция | Py2 | Python3 |
|-------|--------|---------|
| `force_text` | unicode | str(unicode py2) |
| `force_bytes` | str(bytes) | bytes |

Во внутренности не вдаюсь. Пока достаточно понимать.

```
s = 'hello народ'
unicode(s) # Падает с исключением 
force_text(s) # Работает
```

Где бывает нужен _unicode_? Например, чтобы вывести читаемое сообщение в sentry из Exception объекта, а не байтовое представление типа _hello \u043d\u0430\u0440\u043e\u0434_

> TODO: `django.utils.crypto.salted_hmac`, `hmac.compare_digest`: 
 
 хранится и передается `hash(data):data` для проверки, не было ли заменено содержимое, если будет заменено, хэш изменится.
 
> TODO: `django.utils.strconv`; `django.utils.datastructs` (`ImmutableList`, `MultiDict`, `OrderedSet`)


### <a href='#nginx'>новый ssl-сертификат pokovru.ru,letsencrypt,ошибка, Nginx ivp6</a>
Столкнулся с проблемой, что для сайта pokovru.ru не мог собрать сертификат через certbot докер.
- как я понимаю, nginx не может ответить на запрос ipv6, потому что сборка nginx в этом docker обрзаке не поддерживает ipv6 [::]:80(443)
- Кроме этой проблемы заметил в логах, что на pokovru.ru есть 301 редиректы с legality.ru. Для чего так делают? Почему так могло случиться?

```
Failed authorization procedure. www.pokovru.ru (http-01): urn:ietf:params:acme:error:connection :: The server could not connect to the client to verify the domain :: Fetching http://www.pokovru.ru/.well-known/acme-challenge/lnkZTB1JAsiZHtiHgstq_W4_YNZAh8ixQQ1kJAi7tSw: Timeout during connect (likely firewall problem)

IMPORTANT NOTES:
 - The following errors were reported by the server:

   Domain: www.pokovru.ru
   Type:   connection
   Detail: Fetching
   http://www.pokovru.ru/.well-known/acme-challenge/lnkZTB1JAsiZHtiHgstq_W4_YNZAh8ixQQ1kJAi7tSw:
   Timeout during connect (likely firewall problem)

   To fix these errors, please make sure that your domain name was
   entered correctly and the DNS A/AAAA record(s) for that domain
   contain(s) the right IP address. Additionally, please check that
   your computer has a publicly routable IP address and that no
   firewalls are preventing the server from communicating with the
   client. If you're using the webroot plugin, you should also verify
   that you are serving files from the webroot path you provided.
```
Проблема должна быть распространенной, но рецепта решения не нашел. Зато нашел способ проще, у регистратора reg.ru есть опция получить сертификат для домена на год, чем я и воспользовался.


### <a href="#vue-js-first-steps" name='vue-js-first-steps'>Первые шаги vue.js</a>
Прохожу хороший [курс](http://js.dmitrylavrik.ru/vue/?utm=site-footer), где Дмитрий Лаврик без академичности и лишней раскачки показывает возможности vue.js

**Плюсы курса**

- простая, не академичная подача
- он имеет опыт в react и может сравнить vue и react
- есть ДЗ
- скачал на комп, можно ускорять, есть исходники

**Что я усвоил:**

 * можно использовать без SPA
 * поля объектов не реактивны, нужно вручную ставить set
 * watch/methods; v-if/v-show; 
 * нужно пользоваться cheatsheet, много полезных фич.
 
**_Прошел пока 2 урока_**

Программа курса:

```
урок 1
Подключение Vue
Идеи реактивности данных
Простой пример с переменной и v-model
Вывод данных в теги и в атрибуты
Упрощённая структура экземпляра Vue
el, data, computed, methods, watch
Основные директивы

урок 2
Жизненный цикл экземпляра Vue и его события
Служебные свойства с $
Шаблоны и свойство template
Работа с классами и стилями
Директива v-for
Подробный разбор событийной модели
Модификаторы событий

урок 3
Переход к компонентному подходу
Глобальная и локальная регистрация компонентов
Передача входных параметров
Композиция компонентов
Неудобства при описании свойства template
Переход к нормальной системе с webPack
Расположение компонентов в отдельных файлах

урок 4
Общение компонентов друг с другом
Однонаправленный поток данных
Отслеживание и порождение событий
Хранение данных в одном объекте
Передача контента слотами
Переключение компонентов
Component и Keep-alive

урок 5
Создание своих директив
Глобальные и локальные директивы
Фильтры, создание своих фильтров
Миксины: глобальные и локальные
Transition и transition-group
Жизненный цикл анимации

урок 6
Управление состоянием приложения
Осознание Flux-архитектуры
Один объект, описывающий состояние
Обновление состояния
Асинхронные действия
Vuex - паттерн управления состоянием

урок 7
Добавление асинхронности в приложение
Vue Resourse
Single Page Application
Анализ серверной части приложения
Vue Router
Роутинг с API History

урок 8
Обобщение изученного материала
Разбор финальных проектов учеников
Сборка кода в production
Vue и валидность кода
Vue в Single Page Application
Vue при встраивании в многостраничный сайт
```


    
### <a href="#jekyll-markdown">Jekyll Markdown</a>
Начал пользоваться markdown для ведения этого блога. Непонятно с семействами пока. 


 - [jekyll](https://jekyllrb.com/docs/configuration/markdown/) по умолчанию используется [kramdown](https://kramdown.gettalong.org/quickref.html) 
 
 - _\[deprecated: больше не пользуюсь\]_ в проекте [agusmakmun](https://github.com/agusmakmun/agusmakmun.github.io) тоже, но с некоторым добавлением css.
 
> TODO: научиться добавлять кастомизацию например `max-height` окно, с кнопкой `Раскрыть` 
