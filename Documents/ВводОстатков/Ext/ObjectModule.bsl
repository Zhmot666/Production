﻿
#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПроведения(Отказ, Режим)
		// регистр Остатки Приход
		Движения.Остатки.Записывать = Истина;
		Для Каждого ТекущаяСтрокаНоменклатуры Из ПродукцияИМатериалы Цикл
			Движение = Движения.Остатки.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
			Движение.Период = Дата;
			Движение.Номенклатура = ТекущаяСтрокаНоменклатуры.Номенклатура;
			Движение.Склад = Склад;
			Движение.НомерПартии = ТекущаяСтрокаНоменклатуры.НомерПартии;
			Движение.ДатаВыпуска = ТекущаяСтрокаНоменклатуры.ДатаВыпуска;
			Движение.Количество = ТекущаяСтрокаНоменклатуры.Количество;
		КонецЦикла;
	КонецПроцедуры
#Иначе
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли

#КонецОбласти
