﻿#Область ПрограммныйИнтерфейс

Функция ПолучитьКонстантуССекундами() Экспорт
	Возврат Константы.ЧислоСекундВСутках.Получить();
КонецФункции

Функция РазностьДат(Дата1, Дата2) Экспорт
	Возврат (НачалоДня(Дата2) - НачалоДня(Дата1))/ПолучитьКонстантуССекундами();
КонецФункции

// Возвращает наименование организации из константы
// Возвращаемое значение:
//   Текст   - Наименование организации
//
Функция ПолучитьНаименованиеОрганизации() Экспорт
	Возврат Константы.НаименованиеОрганизации.Получить();
КонецФункции

// Инициализирует подключение к базе данных 1С 7.7
//
// Параметры:
//  База  - ОЛЕОбъект.БазаДанных - объект подключения к БД 1с 7.7
//  РезультатПодключения  - Булево
//
Процедура ПодключениеК1С77(База, РезультатПодключения) Экспорт 
	#Если НЕ МобильныйКлиент И НЕ МобильноеПриложениеСервер Тогда
		Перем ЗапускБезЗаставки, МонопольныйРежимOLE, Пароль, Пользователь, ПутьКБазе, СтрокаПодключения;
		
		ПутьКБазе = Константы.ПутьКБазе1С77.Получить();
		Пользователь = Константы.Пользователь1С77.Получить();
		Пароль = Константы.Пароль1С77.Получить();
		МонопольныйРежимOLE = "";
		ЗапускБезЗаставки = 1;
		База = Новый COMОбъект("V1CEnterprise.Application");
		СтрокаПодключения = "/D"""+СокрЛП(ПутьКБазе)+""" /N"""+СокрЛП(Пользователь)+""" /P"""+СокрЛП(Пароль)+"""";
		РезультатПодключения=База.Initialize(База.RMTrade,СтрокаПодключения,?(ЗапускБезЗаставки = 1,"NO_SPLASH_SHOW",""));
	#Иначе
		РезультатПодключения = Ложь;
	#КонецЕсли
КонецПроцедуры

// Преобразует любую таблицу значений в массив
//
// Параметры:
//  ТЗ  - ТаблицаЗначений
//
// Возвращаемое значение:
//   Массив   - Массив
//
Функция ТЗВМассив (ТЗ) Экспорт
	Массив = Новый Массив;
	СтруктураСтрокой = "";
	НужнаЗапятая = Ложь;
	Для Каждого Колонка Из ТЗ.Колонки Цикл
		Если НужнаЗапятая Тогда
			СтруктураСтрокой = СтруктураСтрокой + ",";
		КонецЕсли;
		СтруктураСтрокой = СтруктураСтрокой + Колонка.Имя;
		НужнаЗапятая = Истина;
	КонецЦикла;
	Для Каждого Строка Из ТЗ Цикл
		НоваяСтрока = Новый Структура(СтруктураСтрокой);
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
		Массив.Добавить(НоваяСтрока);
	КонецЦикла;
	Возврат Массив;
КонецФункции

// ПРоверка прав на редактирование документа
//
// Параметры:
//  Документ  - Документ
//
// Возвращаемое значение:
//   Булево   - разрешение на редактирование документа
//
Функция ПроверкаПраваНаРедактированиеДокумента(Документ) Экспорт 
	Если Документ.Автор <> ПараметрыСеанса.ТекущийПользователь И Не РольДоступна("ПолныеПрава") Тогда 
		Возврат Истина;
	Иначе 
		Возврат Ложь;
	КонецЕсли;
КонецФункции

Функция ОпредлениеСтатусаИсследований(Арбитраж, Органолептика, Протокол) Экспорт
	Если Арбитраж + Органолептика + Протокол = 3 Тогда
		Возврат Перечисления.СтатусИспытаний.ВыполненоВПолномОбъеме;
	ИначеЕсли Арбитраж + Органолептика + Протокол = 0 Тогда
		Возврат Перечисления.СтатусИспытаний.НеПроводились;
	ИначеЕсли Арбитраж + Органолептика + Протокол = 2 или Арбитраж + Органолептика + Протокол = 1 Тогда
		Возврат Перечисления.СтатусИспытаний.ВыполненоЧастично;
	КонецЕсли;
КонецФункции
#КонецОбласти
