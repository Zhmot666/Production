﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТабДок = Новый ТабличныйДокумент;
	Краткий(ТабДок, ПараметрКоманды);

	ТабДок.ОтображатьСетку = Ложь;
	ТабДок.Защита = Ложь;
	ТабДок.ТолькоПросмотр = Ложь;
	ТабДок.ОтображатьЗаголовки = Ложь;
	ТабДок.Показать();
КонецПроцедуры

&НаСервере
Процедура Краткий(ТабДок, ПараметрКоманды)
	Документы.УчетТрудозатрат.Краткий(ТабДок, ПараметрКоманды);
КонецПроцедуры

#КонецОбласти

