﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТабДок = Новый ТабличныйДокумент;
	ОбъемПроизводства(ТабДок, ПараметрКоманды);

	ТабДок.ОтображатьСетку = Ложь;
	ТабДок.Защита = Истина;
	ТабДок.ТолькоПросмотр = Ложь;
	ТабДок.ОтображатьЗаголовки = Ложь;
	ТабДок.Показать();
КонецПроцедуры

&НаСервере
Процедура ОбъемПроизводства(ТабДок, ПараметрКоманды)
	Документы.Производство.ОбъемПроизводства(ТабДок, ПараметрКоманды);
КонецПроцедуры

#КонецОбласти

