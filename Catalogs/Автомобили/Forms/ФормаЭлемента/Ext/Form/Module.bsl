﻿
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СобственныйПриИзменении(Элемент)
	Если Объект.Собственный Тогда
		Элементы.Водитель.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.Сотрудники");
		Элементы.ВладелецТранспорта.Доступность = Ложь;
		Элементы.ВладелецТранспорта.Видимость = Ложь;
		Элементы.НормаРасходаТопливаЛето.Доступность = Истина;
		Элементы.НормаРасходаТопливаЗима.Доступность = Истина;
		Элементы.НормаРасходаТопливаЛето.Видимость = Истина;
		Элементы.НормаРасходаТопливаЗима.Видимость = Истина;
	Иначе 
		Элементы.Водитель.ОграничениеТипа = Новый ОписаниеТипов("Строка");
		Элементы.ВладелецТранспорта.Доступность = Истина;
		Элементы.ВладелецТранспорта.Видимость = Истина;
		Элементы.НормаРасходаТопливаЛето.Доступность = Ложь;
		Элементы.НормаРасходаТопливаЗима.Доступность = Ложь;
		Элементы.НормаРасходаТопливаЛето.Видимость = Ложь;
		Элементы.НормаРасходаТопливаЗима.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПрицепПриИзменении(Элемент)
	Если Объект.Прицеп Тогда
		Элементы.МаркаПрицепа.Доступность = Истина;
		Элементы.МаркаПрицепа.Видимость = Истина;
		Элементы.ГосЗнакПрицепа.Доступность = Истина;
		Элементы.ГосЗнакПрицепа.Видимость = Истина;
	Иначе 
		Элементы.МаркаПрицепа.Доступность = Ложь;
		Элементы.МаркаПрицепа.Видимость = Ложь;
		Элементы.ГосЗнакПрицепа.Доступность = Ложь;
		Элементы.ГосЗнакПрицепа.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Объект.Собственный Тогда
		Элементы.Водитель.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.Сотрудники");
		Элементы.ВладелецТранспорта.Доступность = Ложь;
		Элементы.ВладелецТранспорта.Видимость = Ложь;
		Элементы.НормаРасходаТопливаЛето.Доступность = Истина;
		Элементы.НормаРасходаТопливаЗима.Доступность = Истина;
		Элементы.НормаРасходаТопливаЛето.Видимость = Истина;
		Элементы.НормаРасходаТопливаЗима.Видимость = Истина;
	Иначе 
		Элементы.Водитель.ОграничениеТипа = Новый ОписаниеТипов("Строка");
		Элементы.ВладелецТранспорта.Доступность = Истина;
		Элементы.ВладелецТранспорта.Видимость = Истина;
		Элементы.НормаРасходаТопливаЛето.Доступность = Ложь;
		Элементы.НормаРасходаТопливаЗима.Доступность = Ложь;
		Элементы.НормаРасходаТопливаЛето.Видимость = Ложь;
		Элементы.НормаРасходаТопливаЗима.Видимость = Ложь;
	КонецЕсли;
	Если Объект.Прицеп Тогда
		Элементы.МаркаПрицепа.Доступность = Истина;
		Элементы.МаркаПрицепа.Видимость = Истина;
		Элементы.ГосЗнакПрицепа.Доступность = Истина;
		Элементы.ГосЗнакПрицепа.Видимость = Истина;
	Иначе 
		Элементы.МаркаПрицепа.Доступность = Ложь;
		Элементы.МаркаПрицепа.Видимость = Ложь;
		Элементы.ГосЗнакПрицепа.Доступность = Ложь;
		Элементы.ГосЗнакПрицепа.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти


