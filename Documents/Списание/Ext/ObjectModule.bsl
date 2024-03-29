﻿
#Область ОбработчикиСобытий

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПроведения(Отказ, Режим)
		
		// регистр Остатки Расход
		Движения.Остатки.Записывать = Истина;
		Для Каждого ТекСтрокаПробы Из Пробы Цикл
			Если ТекСтрокаПробы.ДатаРозлива = Дата(1, 1, 1) Тогда
				ДатаПартии = ТекСтрокаПробы.ДатаИзготовления;
			Иначе 
				ДатаПартии = ТекСтрокаПробы.ДатаРозлива;
			КонецЕсли;  
			РеальныйОстаток = ВозвратОстатковВызовСервера.ОстаткиНоменклатуры(Дата, Склад, ТекСтрокаПробы.НаименованиеПроб);
			Движение = Движения.Остатки.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Номенклатура = ТекСтрокаПробы.НаименованиеПроб;
			Движение.Склад = Склад;
			Движение.НомерПартии = ТекСтрокаПробы.НомерПартии;
			Движение.Количество = ТекСтрокаПробы.ВесПробы;
			Движение.ДатаВыпуска = ДатаПартии;
			Если ТекСтрокаПробы.ЦельИсследования = Справочники.ЦелиИсследований.Арбитраж Тогда
				Движение = Движения.Остатки.Добавить();
				Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
				Движение.Период = Дата;
				Движение.Номенклатура = ТекСтрокаПробы.НаименованиеПроб;
				Движение.Склад = Справочники.Склад.Арбитраж;
				Движение.НомерПартии = ТекСтрокаПробы.НомерПартии;
				Движение.Количество = ТекСтрокаПробы.ВесПробы;
				Движение.ДатаВыпуска = ДатаПартии;
			КонецЕсли;
			
			// регистр СведенияОИсследованиях
			Если ТекСтрокаПробы.ЦельИсследования = Справочники.ЦелиИсследований.Арбитраж Тогда
				Набор = РегистрыСведений.СведенияОИсследованиях.СоздатьНаборЗаписей();
				Набор.Отбор.Регистратор.Установить(ВыпускПродукции);
				Набор.Прочитать();
				Для Каждого Запись Из Набор Цикл 
					Запись.Арбитраж = Истина;
					Запись.АрбитражСсылка = Ссылка;
					Запись.СтсатусИспытаний = ОбщегоНазначенияСервер.ОпредлениеСтатусаИсследований(Запись.Арбитраж, Запись.Органолептика, Запись.ПротоколИспытаний);
					Если Набор.Модифицированность() Тогда
						Набор.Записать();
					КонецЕсли;
				КонецЦикла;
			ИначеЕсли СтрНайти(ТекСтрокаПробы.ЦельИсследования.Наименование, "Органолептические показатели") <> 0 Тогда
				Набор = РегистрыСведений.СведенияОИсследованиях.СоздатьНаборЗаписей();
				Набор.Отбор.Регистратор.Установить(ВыпускПродукции);
				Набор.Прочитать();
				Для Каждого Запись Из Набор Цикл 
					Запись.Органолептика = Истина;
					Запись.ОрганолептикаСсылка = Ссылка;
					Запись.СтсатусИспытаний = ОбщегоНазначенияСервер.ОпредлениеСтатусаИсследований(Запись.Арбитраж, Запись.Органолептика, Запись.ПротоколИспытаний);
					Если Набор.Модифицированность() Тогда
						Набор.Записать();
					КонецЕсли;
				КонецЦикла;
			КонецЕсли
			
		КонецЦикла;
	КонецПроцедуры
	
	Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
		Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Производство") Тогда
			Дата = ДанныеЗаполнения.Дата+60;
			Склад = ДанныеЗаполнения.СкладПоступленияПродукции;
			ВыпускПродукции = ДанныеЗаполнения.Ссылка;
			Запрос = Новый Запрос;
			Запрос.Текст = 
			"ВЫБРАТЬ
			|	НормыСписанияПродукцииСрезПоследних.Продукция КАК Продукция,
			|	НормыСписанияПродукцииСрезПоследних.НижнийПредел КАК НижнийПредел,
			|	НормыСписанияПродукцииСрезПоследних.ВерхнийПредел КАК ВерхнийПредел,
			|	НормыСписанияПродукцииСрезПоследних.ПричинаСписания КАК ПричинаСписания,
			|	НормыСписанияПродукцииСрезПоследних.КоличествоСписания КАК КоличествоСписания
			|ИЗ
			|	РегистрСведений.НормыСписанияПродукции.СрезПоследних(&ДатаСпсиания, ) КАК НормыСписанияПродукцииСрезПоследних
			|ГДЕ
			|	НормыСписанияПродукцииСрезПоследних.Продукция = &Продукция
			|	И НормыСписанияПродукцииСрезПоследних.НижнийПредел <= &ВеличинаПартии
			|	И НормыСписанияПродукцииСрезПоследних.ВерхнийПредел >= &ВеличинаПартии";
			
			Запрос.УстановитьПараметр("ДатаСпсиания", Дата);
			Запрос.УстановитьПараметр("Продукция", ДанныеЗаполнения.ВидПродукции);
			Запрос.УстановитьПараметр("ВеличинаПартии", ДанныеЗаполнения.ПланируемоеКоличество);
			РезультатЗапроса = Запрос.Выполнить();
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			КоличествоЗначащихСтрок = 0;
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				КоличествоЗначащихСтрок = КоличествоЗначащихСтрок + 1;
			КонецЦикла;
			
			Если КоличествоЗначащихСтрок > 0 Тогда
				ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
				Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
					НоваяСтрокаТЧ = Пробы.Добавить();
					НоваяСтрокаТЧ.НаименованиеПроб = ВыборкаДетальныеЗаписи.Продукция;
					Если ДанныеЗаполнения.ДляМасла Тогда
						НоваяСтрокаТЧ.ДатаРозлива = ДанныеЗаполнения.ДатаРозлива;
						НоваяСтрокаТЧ.ДатаИзготовления = ДанныеЗаполнения.ДатаИзготовления;
					Иначе
						НоваяСтрокаТЧ.ДатаИзготовления = ДанныеЗаполнения.Дата;
					КонецЕсли;
					НоваяСтрокаТЧ.ВесПробы = ВыборкаДетальныеЗаписи.КоличествоСписания;
					НоваяСтрокаТЧ.ЦельИсследования = ВыборкаДетальныеЗаписи.ПричинаСписания;
					НоваяСтрокаТЧ.НомерПартии = ДанныеЗаполнения.НомерПартии;
					НоваяСтрокаТЧ.ВеличинаПартии = ДанныеЗаполнения.ПланируемоеКоличество;
				КонецЦикла;
			Иначе 
				НоваяСтрокаТЧ = Пробы.Добавить();
				НоваяСтрокаТЧ.НаименованиеПроб = ДанныеЗаполнения.ВидПродукции;
				Если ДанныеЗаполнения.ДляМасла Тогда
					НоваяСтрокаТЧ.ДатаРозлива = ДанныеЗаполнения.ДатаРозлива;
					НоваяСтрокаТЧ.ДатаИзготовления = ДанныеЗаполнения.ДатаИзготовления;
				Иначе
					НоваяСтрокаТЧ.ДатаИзготовления = ДанныеЗаполнения.Дата;
				КонецЕсли;
				НоваяСтрокаТЧ.НомерПартии = ДанныеЗаполнения.НомерПартии;
				НоваяСтрокаТЧ.ВеличинаПартии = ДанныеЗаполнения.ПланируемоеКоличество;
			КонецЕсли;
		КонецЕсли;
	КонецПроцедуры
	
#Иначе
	ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли

#КонецОбласти


