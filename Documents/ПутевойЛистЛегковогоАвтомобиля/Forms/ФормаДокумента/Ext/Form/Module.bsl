﻿
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДатаСПриИзменении(Элемент)
	Объект.ДатаС = НачалоДня(Дата(Элемент.ТекстРедактирования + " 01:01:01"));
КонецПроцедуры

&НаКлиенте
Процедура ДатаПоПриИзменении(Элемент)
	Объект.ДатаПо = КонецДня(Дата(Элемент.ТекстРедактирования + " 01:01:01"));
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПутевойЛист

&НаКлиенте
Процедура ПутевойЛистВремяВыездаПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистВремяВозвращенияПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистСпидометрПриВыездеПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистСпидометрПриВозвращенииПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистОстатокТопливаПриВыездеПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистРасходТопливаПоФактуПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	КоличествоСтрокПЛ = Объект.Выезды.Количество();
	Если КоличествоСтрокПЛ > 1 И Элемент.ТекущиеДанные.НомерСтроки = КоличествоСтрокПЛ Тогда
		Элемент.ТекущиеДанные.СпидометрПриВыезде = Объект.Выезды[КоличествоСтрокПЛ-2].СпидометрПриВозвращении;
		Элемент.ТекущиеДанные.Число = Объект.Выезды[КоличествоСтрокПЛ-2].Число + ОбщегоНазначенияСервер.ПолучитьКонстантуССекундами();
		Элемент.ТекущиеДанные.ОстатокТопливаПриВыезде = Объект.Выезды[КоличествоСтрокПЛ-2].ОстатокТопливаПриВозвращении;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПутевойЛистЗимаЛетоПриИзменении(Элемент)
	ПересчетСтрокиПЛ();
КонецПроцедуры

&НаКлиенте
Процедура ПересчетСтрокиПЛ()
	СтрокаПЛ =  Элементы.ПутевойЛист.ТекущиеДанные;
	СтрокаПЛ.ВНаряде = СтрокаПЛ.Число + (СтрокаПЛ.ВремяВозвращения - СтрокаПЛ.ВремяВыезда);
	СтрокаПЛ.Пробег = СтрокаПЛ.СпидометрПриВозвращении - СтрокаПЛ.СпидометрПриВыезде;
	а = ?(СтрокаПЛ.ЗимаЛето, "Зима", "Лето");
	СтрокаПЛ.РасходТопливаПоНорме = ПолучитьРасходТоплива(а)/100*СтрокаПЛ.Пробег;
	СтрокаПЛ.ЭкономияПерерасход = СтрокаПЛ.РасходТопливаПоНорме - СтрокаПЛ.РасходТопливаПоФакту;
	СтрокаПЛ.ОстатокТопливаПриВозвращении = СтрокаПЛ.ОстатокТопливаПриВыезде - СтрокаПЛ.РасходТопливаПоФакту + СтрокаПЛ.ЗаправленоТоплива;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьРасходТоплива(ЗимаЛето)
	Если ЗимаЛето = "Зима" Тогда
		Возврат Объект.Автомобиль.НормаРасходаТопливаЗима;
	Иначе 
		Возврат Объект.Автомобиль.НормаРасходаТопливаЛето;
	КонецЕсли;
КонецФункции

#КонецОбласти

