﻿
#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПроведения(Отказ, Режим)
		// регистр Остатки Приход
		Движения.Остатки.Записывать = Истина;
		Для Каждого ТекСтрокаНоменклатура Из ПродукцияИСырье Цикл
			Движение = Движения.Остатки.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
			Движение.Период = Дата;
			Движение.Номенклатура = ТекСтрокаНоменклатура.Номенклатура;
			Движение.НомерПартии = ТекСтрокаНоменклатура.НомерПартии;
			Движение.ДатаВыпуска = ТекСтрокаНоменклатура.ДатаПартии;
			Движение.Склад = СкладПолучатель;
			Движение.Количество = ТекСтрокаНоменклатура.Количество;
		КонецЦикла;
		
		// регистр Остатки Расход
		Движения.Остатки.Записывать = Истина;
		Для Каждого ТекСтрокаНоменклатура Из ПродукцияИСырье Цикл
			Движение = Движения.Остатки.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Номенклатура = ТекСтрокаНоменклатура.Номенклатура;
			Движение.НомерПартии = ТекСтрокаНоменклатура.НомерПартии;
			Движение.ДатаВыпуска = ТекСтрокаНоменклатура.ДатаПартии;
			Движение.Склад = СкладОтправитель;
			Движение.Количество = ТекСтрокаНоменклатура.Количество;
		КонецЦикла;
	КонецПроцедуры
	
#Иначе
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли

#КонецОбласти

