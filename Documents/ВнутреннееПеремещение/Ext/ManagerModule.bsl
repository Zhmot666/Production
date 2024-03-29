﻿
#Область СлужебныйПрограммныйИнтерфейс

Процедура Накладная(ТабДок, Ссылка) Экспорт
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		Макет = Документы.ВнутреннееПеремещение.ПолучитьМакет("Накладная");
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ВнутреннееПеремещение.Автор КАК Автор,
		|	ВнутреннееПеремещение.Дата КАК Дата,
		|	ВнутреннееПеремещение.Номер КАК Номер,
		|	ВнутреннееПеремещение.СкладОтправитель КАК СкладОтправитель,
		|	ВнутреннееПеремещение.СкладПолучатель КАК СкладПолучатель,
		|	ВнутреннееПеремещение.ПродукцияИСырье.(
		|		НомерСтроки КАК НомерСтроки,
		|		Номенклатура КАК Номенклатура,
		|		Количество КАК Количество,
		|		Номенклатура.ЕдиницыИзмерения.Наименование КАК ЕдиницыИзмерения
		|	) КАК Номенклатура,
		|	ВнутреннееПеремещение.ОснованиеОтпуска КАК ОснованиеОтпуска
		|ИЗ
		|	Документ.ВнутреннееПеремещение КАК ВнутреннееПеремещение
		|ГДЕ
		|	ВнутреннееПеремещение.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);
		Выборка = Запрос.Выполнить().Выбрать();
		
		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		Шапка = Макет.ПолучитьОбласть("Шапка");
		ОбластьНоменклатураШапка = Макет.ПолучитьОбласть("НоменклатураШапка");
		ОбластьНоменклатура = Макет.ПолучитьОбласть("Номенклатура");
		Подвал = Макет.ПолучитьОбласть("Подвал");
		
		ТабДок.Очистить();
		
		ВставлятьРазделительСтраниц = Ложь;
		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;
			
			ОбластьЗаголовок.Параметры.Заполнить(Выборка);
			ОбластьЗаголовок.Параметры.НаименованиеОрганизации = ОбщегоНазначенияСервер.ПолучитьНаименованиеОрганизации();
			ОбластьЗаголовок.Параметры.УНПОрганизации = Константы.УНП.Получить();
			ТабДок.Вывести(ОбластьЗаголовок);
			
			Шапка.Параметры.Заполнить(Выборка);
			Шапка.Параметры.ФорматированнаяДата = Формат(Выборка.Дата, "ДЛФ=ДД");
			Шапка.Параметры.Кому = Выборка.СкладПолучатель.ВладелецСклада.Наименование;
			Шапка.Параметры.ОтКого = Выборка.СкладОтправитель.ВладелецСклада.Наименование;
			Шапка.Параметры.Куда = Выборка.СкладПолучатель.ОбъектПроизводства.Наименование;
			Шапка.Параметры.Откуда = Выборка.СкладОтправитель.ОбъектПроизводства.Наименование;
			
			
			ТабДок.Вывести(Шапка, Выборка.Уровень());
			
			ТабДок.Вывести(ОбластьНоменклатураШапка);
			ВыборкаНоменклатура = Выборка.Номенклатура.Выбрать();
			Пока ВыборкаНоменклатура.Следующий() Цикл
				ОбластьНоменклатура.Параметры.Заполнить(ВыборкаНоменклатура);
				ТабДок.Вывести(ОбластьНоменклатура, ВыборкаНоменклатура.Уровень());
				КоличествоСтрок = ВыборкаНоменклатура.НомерСтроки;
			КонецЦикла;
			
			Подвал.Параметры.Заполнить(Выборка);
			Подвал.Параметры.Строки = КоличествоСтрок;
			Подвал.Параметры.ОтпускРазрешилДолжность = Константы.НачальникПроизводства.Получить().Должность.Наименование;
			Подвал.Параметры.ОтпускРазрешилФИО = Константы.НачальникПроизводства.Получить().Наименование;
			Подвал.Параметры.ОтпустилДолжность = Выборка.СкладОтправитель.ВладелецСклада.Должность.Наименование;
			Подвал.Параметры.ОтпустилФИО = Выборка.СкладОтправитель.ВладелецСклада.Наименование;
			Подвал.Параметры.ПолучилДолжность = Выборка.СкладПолучатель.ВладелецСклада.Должность.Наименование;
			Подвал.Параметры.ПолучилФИО = Выборка.СкладПолучатель.ВладелецСклада.Наименование;
			
			ТабДок.Вывести(Подвал);
			
			ВставлятьРазделительСтраниц = Истина;
		КонецЦикла;
	#Иначе
		ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
	#КонецЕсли
КонецПроцедуры
#КонецОбласти
