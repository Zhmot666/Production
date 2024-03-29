﻿
#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПроведения(Отказ, Режим)
		Движения.Прейскурант.Записывать = Истина;
		Для Каждого ТекСтрокаЦены Из Цены Цикл
			Движение = Движения.Прейскурант.Добавить();
			Движение.Период = Дата;
			Движение.Номенклатура = ТекСтрокаЦены.Номенклатура;
			Движение.НДС = ТекСтрокаЦены.НДС;
			Движение.Цена = ТекСтрокаЦены.НоваяЦена;
			Движение.НеВключатьВПрайс = ТекСтрокаЦены.НеВключатьВПрайс;
			Движение.НомерСтрокиВПрейскуранте = ТекСтрокаЦены.НомерСтроки;
			Движение.Комментарий = Комментарий;
		КонецЦикла;
	КонецПроцедуры
#Иначе
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли

#КонецОбласти
