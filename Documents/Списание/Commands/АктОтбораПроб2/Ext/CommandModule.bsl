﻿#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТабДок = Новый ТабличныйДокумент;
	АктОтбораПроб2(ТабДок, ПараметрКоманды);
	
	ТабДок.ОтображатьСетку = Ложь;
	ТабДок.Защита = Ложь;
	ТабДок.ТолькоПросмотр = Ложь;
	ТабДок.ОтображатьЗаголовки = Ложь;
	ТабДок.Показать();
КонецПроцедуры

&НаСервере
Процедура АктОтбораПроб2(ТабДок, ПараметрКоманды)
	Документы.Списание.АктОтбораПроб2(ТабДок, ПараметрКоманды);
КонецПроцедуры

#КонецОбласти

