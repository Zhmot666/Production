﻿
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДокументОтгрузкиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтрокиЗаполнения  = ДокументОтгрузкиОбработкаВыбораНаСервере(ВыбранноеЗначение, Объект.Контрагент);
	
	Для Каждого СтрЗап Из СтрокиЗаполнения Цикл
		СтрДоб = Объект.ВозвратныеТовары.Добавить();
		СтрДоб.Товар = СтрЗап.Номенклатура;
		СтрДоб.Количество = СтрЗап.Количество;
		СтрДоб.ДатаВыпуска = СтрЗап.ДатаВыпуска;
		СтрДоб.Партия = СтрЗап.НомерПартии;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ДокументОтгрузкиОбработкаВыбораНаСервере(ВыбранноеЗначение, Контрагент)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОтгрузкаОтгрузки.Контрагент КАК Контрагент,
		|	ОтгрузкаОтгрузки.Номенклатура КАК Номенклатура,
		|	ОтгрузкаОтгрузки.НомерПартии КАК НомерПартии,
		|	ОтгрузкаОтгрузки.Количество КАК Количество,
		|	ОтгрузкаОтгрузки.Ссылка КАК Ссылка,
		|	ОтгрузкаОтгрузки.ДатаВыпуска КАК ДатаВыпуска
		|ИЗ
		|	Документ.Отгрузка.Отгрузки КАК ОтгрузкаОтгрузки
		|ГДЕ
		|	ОтгрузкаОтгрузки.Контрагент = &Контрагент
		|	И ОтгрузкаОтгрузки.Ссылка = &ВыбранноеЗначение";
	
	Запрос.УстановитьПараметр("ВыбранноеЗначение", ВыбранноеЗначение);
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	
	ТЗ = Новый ТаблицаЗначений;
	ТЗ = РезультатЗапроса.Выгрузить();
	
	Массив = Новый Массив();
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

#КонецОбласти

