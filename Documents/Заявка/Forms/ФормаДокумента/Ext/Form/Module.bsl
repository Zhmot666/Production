﻿#Область ОбработчикиСобытийЭлементовТаблицыФормыНоменклатура

&НаКлиенте
Процедура НоменклатураНоменклатураОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Элементы.Номенклатура.ТекущиеДанные.Зарезервировано = Резерв(ВыбранноеЗначение);
	Элементы.Номенклатура.ТекущиеДанные.ОстаткиНаСкладах = ОстатокНаСкладах(ВыбранноеЗначение);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция Резерв(Номенклатура)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаявкаОстатки.Номенклатура КАК Номенклатура,
		|	ЗаявкаОстатки.ЗаказаноОстаток КАК ЗаказаноОстаток
		|ИЗ
		|	РегистрНакопления.Заявка.Остатки КАК ЗаявкаОстатки
		|ГДЕ
		|	ЗаявкаОстатки.Номенклатура = &Номенклатура";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Если ВыборкаДетальныеЗаписи.ЗаказаноОстаток = Null Тогда
			Возврат 0;
		Иначе 
			Возврат ВыборкаДетальныеЗаписи.ЗаказаноОстаток;
		КонецЕсли;
	КонецЦикла;
	
КонецФункции // Резерв()

&НаСервере
Функция  ОстатокНаСкладах(Номенклатура)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОстаткиОстатки.Номенклатура КАК Номенклатура,
		|	ОстаткиОстатки.КоличествоОстаток КАК КоличествоОстаток
		|ИЗ
		|	РегистрНакопления.Остатки.Остатки КАК ОстаткиОстатки
		|ГДЕ
		|	ОстаткиОстатки.Номенклатура = &Номенклатура";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Если ВыборкаДетальныеЗаписи.КоличествоОстаток = Null Тогда
			Возврат 0;
		Иначе 
			Возврат ВыборкаДетальныеЗаписи.КоличествоОстаток;
		КонецЕсли;
	КонецЦикла;
	
КонецФункции // ОстатокНаСкладах()

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустая() Тогда
		Объект.СпособПодбораПартии = ПредопределенноеЗначение("Перечисление.СпособПодбора.СДелением");
	КонецЕсли
КонецПроцедуры

#КонецОбласти

