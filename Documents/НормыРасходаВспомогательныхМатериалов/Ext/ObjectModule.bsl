﻿
#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПроведения(Отказ, Режим)
		// регистр НормыРасходВспомогательныхСредств
		Движения.НормыРасходВспомогательныхСредств.Записывать = Истина;
		Для Каждого ТекСтрокаНоменклатура Из Номенклатура Цикл
			Движение = Движения.НормыРасходВспомогательныхСредств.Добавить();
			Движение.Период = Дата;
			Движение.Склад = Склад;
			Движение.КатегорияМатериалов = ТекСтрокаНоменклатура.КатегорияМатериалов;
			Движение.Количество = ТекСтрокаНоменклатура.Количество;
			Движение.ПериодИспользования = ТекСтрокаНоменклатура.ПериодИспользования;
		КонецЦикла;
	КонецПроцедуры
#Иначе
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли

#КонецОбласти
