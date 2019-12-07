---
layout: post
title:  "2019, вторая неделя января"
categories: postgresql achievements-diary django vuejs
---

1. <a href='#django'>Django code: core.serializers; core.cache;</a>
2. <a href='#xor'>Заметки про xor</a>

### <a href="#django" name='django'>Django code: core.serializers; core.cache</a>

Главное использование функций этого модуля 
```python
authors = Author.objects.all()
books = Book.objects.all()
joined_qs = authors + books

data = serializers.serialize('json', joined_qs)
serializers.deserialize('json', data)
```
Формат который передается первой строкой может быть:
```python
BUILTIN_SERIALIZERS = {
    "xml": "django.core.serializers.xml_serializer",
    "python": "django.core.serializers.python",
    "json": "django.core.serializers.json",
    "yaml": "django.core.serializers.pyyaml",
}
```

Как известно, json.dumps не работает с некоторыми типами данных, даже примитивными, для всех них будет исключение TypeError ... is not JSON serializable
  - datetime.date
  - datetime.datetime
  - datetime.time
  - datetime.timedelta
  - uuid.UUID
  - decimal.Decimal
  
`django.core.serializers.json.DjangoJSONEncoder` добавляет эти типы данных

Делается это через расширение функции default.
```python
import json

some_not_serialized_obj = {} # with datetime obj
json.dumps(some_not_serialized_obj)  # Упадет с исключением TypeError ... is not JSON serializable
json.dumps(some_not_serialized_obj, default=lambda value: 'this not serialized')
```

Отмечу общий принцип организации кода: в *django/core/serializers/base.py* описывается базовый класс (частично реализованный, но большинство методов NotImplemented), исключения и некоторые утилиты.

В base.Serializer реализован метод serializer внутри которого start_obj/end_obj. Эти вызовы в цикле оборачивают работу с объектом.
Основной принцип, что start_obj - добавляет _\_current_ переменную в которой сохраняются все данные для item (все вспомогательные функции работают _\_current_), end_obj - записывает обнуляет её None.

В core.case.base есть `DEFAULT_TIMEOUT = object()` - используется для передачи по умолчанию и сравнения с ним. Называется stub класс - заглушка.
> TODO:  `django.utils:` strconv; datastructs (`ImmutableList, MultiDict, OrderedSet`); `cache` (Vary, add_headers, max_cache_time);

### <a name='xor'>Заметки про xor</a>
XOR - шифрование самое простое - побитовое сложение. Используют его для шифрования и дешифрования в простейшем случае посимвольно. Более усовершенствованные кейсы - бьют на блоки.

`a ^ key ^ key = a`

 Попытался сделать xor для ascii символов в python. **_Ошибка, так не делать_** ord('a') ^ ord('z') => 27 символ не читаемый.
```python
a = 'a' # ord(a) = 97
z = 'z' # ord(a) = 122
xor_a_z = 97 ^ 122 # = 27
chr(27)  # =  нечитаемый символ.
```
Нужно коды символов заключить только в читаемых кодах символов.
По сути делать словарь как ниже и работать ограничиваясь только кодами из него.
```python
alphabet = {
'a':1,
'b':2,
'z': 26,
}
```

Шифр очень просто взламывается.
