﻿
#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьПользователя()
	
	Возврат ПараметрыСеанса.ТекущийПользователь;
	
КонецФункции

&НаСервере
Функция Можно()
	
	Если РольДоступна("ПолныеПрава") ИЛИ РольДоступна("ПодсистемаМенеджер") ИЛИ РольДоступна("ПодсистемаБухгалтерия") Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция ФильтрДок()
	
	Возврат Константы.ФильтрацияПроизводства.Получить();
	
КонецФункции 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Можно() ИЛИ Не ФильтрДок() Тогда
	Иначе
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Автор");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.Использование = Истина;
		ЭлементОтбора.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
		ЭлементОтбора.ПравоеЗначение = ПолучитьПользователя();
		Элементы.Автор.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();     
	ПолеОформления = ЭлементОформления.Поля.Элементы.Добавить();	
    ПолеОформления.Поле = Новый ПолеКомпоновкиДанных("Список"); 
    ПолеОформления.Использование = Истина;
	ГруппаОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаОтбора.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;
	ЭлементОтбора = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("Список.Проведен");
	ЭлементОтбора.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;    
	ЭлементОтбора.ПравоеЗначение = Истина;
    ЭлементОтбора.Использование  = Истина;
	ЭлементОтбора = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("Список.Статус");
	ЭлементОтбора.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = ПредопределенноеЗначение("Перечисление.СтатусПроизводства.Окончено");
    ЭлементОтбора.Использование  = Истина;
    ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.ЗеленыйЛес);
	
КонецПроцедуры

#КонецОбласти

