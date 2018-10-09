#Использовать asserts

Функция СообщениеСоответствуетПаттернам(СообщениеКоммита, Паттерны)

	Результат = Ложь;

	Для Каждого КлючевоеСлово из Паттерны Цикл

		Если СтрНачинаетсяС(СообщениеКоммита, КлючевоеСлово.СловоОпределение) Тогда

			Результат = Истина;
			Прервать;

		КонецЕсли;

	КонецЦикла;

	Возврат Результат;

КонецФункции

Процедура ДобавитьКГруппе(ОбъектГруппировки, Сообщение, Блок)

	Группа = ОбъектГруппировки.Строки.Найти(Блок, "Блок");
	НоваяСтрока = Группа.Строки.Добавить();
	НоваяСтрока.Сообщение = Сообщение;

КонецПроцедуры

Функция ИнициализироватьДеревоРезультат(СтруктураЛога)

	Результат = Новый ДеревоЗначений;

	Результат.Колонки.Добавить("Блок",		Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("Сообщение", Новый ОписаниеТипов("Строка"));

	Для Каждого ОписаниеБлоков из СтруктураЛога.Строки Цикл

		Строка = Результат.Строки.Добавить();
		Строка.Блок = ОписаниеБлоков.Блок;

	КонецЦикла;

	Возврат Результат;

КонецФункции

Функция РазложитьИсториюПоДереву(ИсторияКоммитов, СтруктураЛога)

	Результат = ИнициализироватьДеревоРезультат(СтруктураЛога);

	Для Каждого СообщениеКоммита из ИсторияКоммитов Цикл

		Для Каждого Паттерн из СтруктураЛога.Строки Цикл

			Если СообщениеСоответствуетПаттернам(СообщениеКоммита, Паттерн.Строки) Тогда

				ДобавитьКГруппе(Результат, СообщениеКоммита, Паттерн.Блок);
				Прервать;
			
			КонецЕсли

		КонецЦикла;

	КонецЦикла;

	Возврат Результат;

КонецФункции

//Интерфейс модуля

// Возвращает текстовое представление лога изменений
//
// Параметры:
//  ИсторияКоммитов		- Массив			- полученная история коммитов
//  СтруктураЛога		- ДеревоЗначений	- описание структуры к выводу
//
// Возвращаемое значение:
//   Строка   - разобранная история
//
Функция СформироватьТекстовоеПредставлениеИсторииКоммитов(ИсторияКоммитов, СтруктураЛога) Экспорт

	Результат	= "";

	Разбор = РазложитьИсториюПоДереву(ИсторияКоммитов, СтруктураЛога);

	Для Каждого Раздел Из Разбор.Строки Цикл

		Если Раздел.Строки.Количество() = 0 Тогда

			Продолжить;

		КонецЕсли;

		Результат = Результат + "## " + Раздел.Блок;
		ПереносСтроки(Результат);
		ПереносСтроки(Результат);

		Для Каждого СообщениеКоммита Из Раздел.Строки Цикл

			Результат = Результат + "* " + СообщениеКоммита.Сообщение;
			ПереносСтроки(Результат);

		КонецЦикла;

	КонецЦикла;

	Сообщить(Результат);

	Возврат Результат;
	
КонецФункции

Процедура ПереносСтроки(Текст)

	Текст = Текст + Символы.ПС + Символы.ВК;

КонецПроцедуры