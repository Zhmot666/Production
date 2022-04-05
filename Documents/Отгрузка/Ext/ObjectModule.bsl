﻿
#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПроведения(Отказ, Режим)
		
		Движения.Остатки.Записывать = Истина;
		Для Каждого ТекСтрокаОтгрузки Из Отгрузки Цикл
			Движение = Движения.Остатки.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Номенклатура = ТекСтрокаОтгрузки.Номенклатура;
			Движение.Склад = ТекСтрокаОтгрузки.Склад;
			Движение.Количество = ТекСтрокаОтгрузки.Количество;
			Движение.НомерПартии = ТекСтрокаОтгрузки.НомерПартии;
			Движение.ДатаВыпуска = ТекСтрокаОтгрузки.ДатаВыпуска;
		КонецЦикла;
		
		Движения.Заявка.Записывать = Истина;
		Для Каждого ТекСтрокаОтгрузки Из Отгрузки Цикл
			Движение = Движения.Заявка.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ПунктыРазгрузки = ТекСтрокаОтгрузки.ПунктРазгрузки;
			Движение.Контрагенты = ТекСтрокаОтгрузки.Контрагент;
			Движение.Номенклатура = ТекСтрокаОтгрузки.Номенклатура;
			Движение.ДокументЗаявки = ТекСтрокаОтгрузки.ДокументЗаявки;
			Движение.Заказано = ТекСтрокаОтгрузки.Количество;
		КонецЦикла;
		
	КонецПроцедуры
#Иначе
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли

#КонецОбласти



