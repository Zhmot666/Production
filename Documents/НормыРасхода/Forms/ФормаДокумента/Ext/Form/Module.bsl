﻿
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаСервере
Функция ПродукцияПриИзмененииНаСервере(ДатаДок, ПродДок)
	Запрос = Новый Запрос;
	
	Запрос.Текст = 	"ВЫБРАТЬ
	|	НормыРасходаСрезПоследних.Продукция КАК Продукция,
	|	НормыРасходаСрезПоследних.Материал КАК Материал,
	|	НормыРасходаСрезПоследних.Количество КАК Количество
	|ИЗ
	|	РегистрСведений.НормыРасхода.СрезПоследних(&ДатаДок) КАК НормыРасходаСрезПоследних
	|ГДЕ
	|	НормыРасходаСрезПоследних.Продукция = &ПродДок
	|СГРУППИРОВАТЬ ПО
	|	НормыРасходаСрезПоследних.Продукция,
	|	НормыРасходаСрезПоследних.Материал,
	|	НормыРасходаСрезПоследних.Количество";
	
	Запрос.УстановитьПараметр("ПродДок", ПродДок);
	Запрос.УстановитьПараметр("ДатаДок", ДатаДок);
	МассивВозврата = Новый Массив;
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		
		СтруктураВозврата=Новый Структура;
		СтруктураВозврата.Вставить("Материал", Выборка.Материал);
		СтруктураВозврата.Вставить("Количество",Выборка.Количество);
		
		МассивВозврата.Добавить(СтруктураВозврата);
	КонецЦикла;
	
	Возврат МассивВозврата;
	
КонецФункции

&НаКлиенте
Процедура ПродукцияПриИзменении(Элемент)
	Объект.Материалы.Очистить();
	НС = ПродукцияПриИзмененииНаСервере(Объект.Дата, Объект.Продукция);
	Для Каждого ЭлементМассива Из НС Цикл 
		Если ЭлементМассива.Количество <> 0 Тогда
			СтрМат = Объект.Материалы.Добавить();
			СтрМат.СтароеКоличество = ЭлементМассива.Количество;
			СтрМат.НовоеКоличество = ЭлементМассива.Количество;
			СтрМат.Материал = ЭлементМассива.Материал;		
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

