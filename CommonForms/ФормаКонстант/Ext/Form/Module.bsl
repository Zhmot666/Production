﻿
#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПутьКБазе1С77НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	Диалог.Заголовок = НСтр("ru='Выберите каталог базы 1с 7.7'");
	ОповещениеЗавершения = Новый ОписаниеОповещения("ВыборФайлаЗавершение", ЭтотОбъект);
	Диалог.Показать(ОповещениеЗавершения);
КонецПроцедуры

&НаКлиенте
Процедура ВыборФайлаЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	Если ВыбранныеФайлы <> Неопределено Тогда
		НаборКонстант.ПутьКБазе1С77 = ВыбранныеФайлы[0];
	КонецЕсли;
КонецПроцедуры

#КонецОбласти 


