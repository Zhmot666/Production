﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сформировать(Команда)
	Отчет.ТаблицаРасхожденияОборотов = ЗаполнитьНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Отчет.ДатаМесяцаСверкиОборотов = Параметры.ДанныеНоменклатуры.ДатаСверки;
	Отчет.НоменклатураВ77 = Параметры.ДанныеНоменклатуры.Наименование;
	Отчет.СкладВ77 = Параметры.ДанныеНоменклатуры.Склад77;
КонецПроцедуры

&НаСервере
Функция ЗаполнитьНаСервере()
	База = Неопределено;
	РезультатПодключения = Неопределено;
	ОбщегоНазначенияСервер.ПодключениеК1С77(База, РезультатПодключения);
	Если НЕ РезультатПодключения Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "НЕ ПОДКЛЮЧИЛИСЬ К 1С 7.7";
		Сообщение.Сообщить(); 
		Возврат 0;
	КонецЕсли;
	
	ТЗОстаткиИОбороты7 = Новый ТаблицаЗначений;
	ТЗОстаткиИОбороты7.Колонки.Добавить("ДатаДокумента7");
	ТЗОстаткиИОбороты7.Колонки.Добавить("Документ7");
	ТЗОстаткиИОбороты7.Колонки.Добавить("Приход7");
	ТЗОстаткиИОбороты7.Колонки.Добавить("Расход7");
	ТЗОстаткиИОбороты7.Колонки.Добавить("Признак7");
	
	БИ = База.CreateObject("БухгалтерскиеИтоги");
	
	
	СубконтоМХ = База.ВидыСубконто.МестаХранения;
	СпрМХ = База.CreateObject("Справочник.МестаХранения");
	СпрМХ.НайтиПоКоду(СокрЛП(Отчет.СкладВ77));
	
	
	СчетОборотов = "10.1";
	СубконтоМатериалов = База.ВидыСубконто.Материалы;
	Спр = База.CreateObject("Справочник.Материалы");
	ВыборкаОборотовИз77(База, Спр, СпрМХ, СубконтоМатериалов, СубконтоМХ, СчетОборотов, ТЗОстаткиИОбороты7);
	
	СчетОборотов = "21";
	СубконтоМатериалов = База.ВидыСубконто.Материалы;
	Спр = База.CreateObject("Справочник.Материалы");
	ВыборкаОборотовИз77(База, Спр, СпрМХ, СубконтоМатериалов, СубконтоМХ, СчетОборотов, ТЗОстаткиИОбороты7);
	
	СчетОборотов = "43";
	СубконтоМатериалов  = База.ВидыСубконто.Номенклатура;
	Спр = База.CreateObject("Справочник.Номенклатура");
	ВыборкаОборотовИз77(База, Спр, СпрМХ, СубконтоМатериалов, СубконтоМХ, СчетОборотов, ТЗОстаткиИОбороты7);
	
	
	База = NULL;
	
	ТЗОстаткиИОбороты7.Сортировать("ДатаДокумента7");
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОстаткиОбороты.Регистратор КАК Документ8,
	|	ОстаткиОбороты.Период КАК ДатаДокумента8,
	|	ОстаткиОбороты.КоличествоПриход КАК Приход8,
	|	ОстаткиОбороты.КоличествоРасход КАК Расход8
	|ИЗ
	|	РегистрНакопления.Остатки.Обороты(&НачалоМесяца, &КонецМесяца, Регистратор, ) КАК ОстаткиОбороты
	|ГДЕ
	|	ОстаткиОбороты.Номенклатура = &Номенклатура
	|	И ОстаткиОбороты.Склад = &Склад
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДатаДокумента8";
	
	Запрос.УстановитьПараметр("НачалоМесяца", НачалоМесяца(Отчет.ДатаМесяцаСверкиОборотов));
	Запрос.УстановитьПараметр("КонецМесяца", КонецМесяца(Отчет.ДатаМесяцаСверкиОборотов));
	Запрос.УстановитьПараметр("Номенклатура", Отчет.НоменклатураВ83);
	Запрос.УстановитьПараметр("Склад", Отчет.СкладВ83);
	
	ТЗОборотов83 = Запрос.Выполнить().Выгрузить();
	ТЗОборотов83.Сортировать("ДатаДокумента8");
	
	ТЗОстаткиИОбороты8 = Запрос.Выполнить().Выгрузить();
	
	ОграничительСчетчика = Макс(ТЗОстаткиИОбороты7.Количество(), ТЗОстаткиИОбороты8.Количество());
	
	ТабДок = Новый ТабличныйДокумент;
	Макет = Отчеты.СверкаОстатков.ПолучитьМакет("РасхождениеОборотов");
	ОбластьШапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
	ОбластьПустая7 = Макет.ПолучитьОбласть("СтрокаПустая7");
	ОбластьПустая8 = Макет.ПолучитьОбласть("СтрокаПустая8");
	ТабДок.Вывести(ОбластьШапка);
	
	// попробовать разбивку по датам
	Для Счетчик=1 По ОграничительСчетчика Цикл
		Если ТЗОстаткиИОбороты7.Количество() >= Счетчик И ТЗОстаткиИОбороты8.Количество() >= Счетчик Тогда
			ОбластьСтрока.Параметры.Заполнить(ТЗОстаткиИОбороты7[Счетчик-1]);
			ОбластьСтрока.Параметры.Заполнить(ТЗОстаткиИОбороты8[Счетчик-1]);
			ТабДок.Вывести(ОбластьСтрока);
		ИначеЕсли ТЗОстаткиИОбороты7.Количество() < Счетчик И ТЗОстаткиИОбороты8.Количество() >= Счетчик Тогда
			ОбластьПустая7.Параметры.Заполнить(ТЗОстаткиИОбороты8[Счетчик-1]);
			ТабДок.Вывести(ОбластьПустая7);
		ИначеЕсли ТЗОстаткиИОбороты7.Количество() >= Счетчик И ТЗОстаткиИОбороты8.Количество() < Счетчик Тогда
			ОбластьПустая8.Параметры.Заполнить(ТЗОстаткиИОбороты7[Счетчик-1]);
			ТабДок.Вывести(ОбластьПустая8);
		КонецЕсли; 
	КонецЦикла; 
	
	Возврат ТабДок;
КонецФункции

&НаСервере
Процедура ВыборкаОборотовИз77(Знач База, Знач Спр, Знач СпрМХ, СубконтоМатериалов, СубконтоМХ, СчетОборотов, Знач ТЗОстаткиИОбороты7)
	
	Перем БИ, СТрокаТЗОстаткиИОбороты7;
	
	//////////////////////////////////////////////////////////////////////
	
	
	Спр.ВыбратьЭлементы(0);
	Пока Спр.ПолучитьЭлемент() = 1 Цикл
		Если Спр.Наименование = СокрЛП(Отчет.НоменклатураВ77) Тогда
			БИ = База.CreateObject("БухгалтерскиеИтоги");
			БИ.ИспользоватьСубконто(СубконтоМХ, СпрМХ.ТекущийЭлемент(), 2);
			БИ.ИспользоватьСубконто(СубконтоМатериалов, Спр.ТекущийЭлемент(), 2);
			БИ.ВыполнитьЗапрос(НачалоМесяца(Отчет.ДатаМесяцаСверкиОборотов),КонецМесяца(Отчет.ДатаМесяцаСверкиОборотов), СчетОборотов,"","","","Проводка","К");
			БИ.ВыбратьПериоды();
			Пока БИ.ПолучитьПериод() = 1 Цикл
				Если (БИ.Операция.Дебет.Счет.Количественный = 1) Или (БИ.Операция.Кредит.Счет.Количественный = 1) Тогда
					СТрокаТЗОстаткиИОбороты7 = ТЗОстаткиИОбороты7.Добавить();
					СТрокаТЗОстаткиИОбороты7.ДатаДокумента7 = БИ.НачДата;
					СТрокаТЗОстаткиИОбороты7.Документ7 = БИ.Операция.Документ.ПредставлениеВида()+" №"+БИ.Операция.Документ.НомерДок +" от "+БИ.Операция.Документ.ДатаДок ;
					СТрокаТЗОстаткиИОбороты7.Приход7 = ?(БИ.ВыбранаПоДт()=1,БИ.Операция.Количество,0);
					СТрокаТЗОстаткиИОбороты7.Расход7 = ?(БИ.ВыбранаПоКт()=1,БИ.Операция.Количество,0);
				КонецЕсли;
			КонецЦикла;			
		КонецЕсли;
	КонецЦикла;
	ТЗОстаткиИОбороты7.Сортировать("ДатаДокумента7");
	
	
	//////////////////////////////////////////////////////////////////////
	
КонецПроцедуры

#КонецОбласти


