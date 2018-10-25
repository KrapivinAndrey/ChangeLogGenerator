# ChangeLogGenerator

Генератор changelog.md на OScript

Водохновение ["readmegen на php"](https://github.com/fojuth/readmegen)

## Вам ведь тоже лень вести лог изменений

Все уже указали в коммитах? Зачем еще раз писать?
Обновляет лог изменений, разбивая описания коммитов по группам. Ориентируется на первое слово.

Структуру можно использовать по-умолчанию [keepchangelog](https://keepachangelog.com/ru/1.0.0/) или задать через [yaml файл](.\settings.yml)

Для обновления файла надо указать sha коммитов. Удобно испльзовать как CustomActions в SourceTree

## Примеры команд

### Обновить файл CHANGELOG.md по типовой структуре от коммита xxx до HEAD

``` bat
changelog-generate xxx
```

### Обновить указанный файл по настройкам из файла от коммита xxx до коммита yyy

``` bat
changelog-generate xxx yyy --settings setting.yml --filename README.md
```
