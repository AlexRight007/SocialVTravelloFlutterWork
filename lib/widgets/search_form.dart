import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/models/tourvisor/departure_model.dart';
import 'package:socialv/models/tourvisor/hotel_lists.dart';
import 'package:socialv/models/tourvisor/hotel_type.dart';
import 'dart:developer';

import 'package:socialv/services/tourvisorService.dart';
import 'package:socialv/utils/colors.dart';
import 'package:socialv/utils/constants.dart';

class SearchFormWidget extends StatefulWidget {
  final void Function()? onPressed;

  SearchFormWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  State<SearchFormWidget> createState() {
    return _SearchFormWidgetState();
  }
}

class _SearchFormWidgetState extends State<SearchFormWidget> {
  final tourvisorService = TourvisorService();
  late List<Departure> departures = [];
  late List<Departure> countries = [];
  late List<HotelType> hotelsType = [];
  late HotelListDepartureModel hotelListDepartureModel;
  late DateTimeRange selectedDateRange;
  RangeValues selectedNightRange =
      RangeValues(globalNightsFrom, globalNightsTo);

  bool _showAdditionalSettings = false;

  late TextEditingController minBudgetController;
  late TextEditingController maxBudgetController;

  @override
  void initState() {
    super.initState();
    selectedDateRange = DateTimeRange(
      start: globalDepartureDateFrom,
      end: globalDepartureDateTo,
    );
    _loadDepartures();
    minBudgetController =
        TextEditingController(text: globalMinBudget.toString());
    maxBudgetController =
        TextEditingController(text: globalMaxBudget.toString());
  }

  Map<int, String> mealTypesMap = {
    0: "Любое",
    3: "BB - Только завтрак",
    4: "HB - Завтрак и ужин",
    5: "FB - Завтрак, обед и ужин",
    7: "AI - Все включено",
    9: "UAI - Ультра все включено",
    // Добавьте другие значения при необходимости
  };

  Map<int, String> ratingTypesMap = {
    0: "Любое",
    2: "3,0 и более",
    3: "3,5 и более",
    4: "4,0 и более",
    5: "4,5 и более",
    // Добавьте другие значения при необходимости
  };

  Future<void> _loadDepartures() async {
    try {
      departures = await tourvisorService.getDepartures();
      countries = await tourvisorService.getCountries();

      _loadHotelsType();
      _loadHotelsList();
      setState(() {});
    } catch (e) {
      log('Error loading departures: $e');
    }
  }

  Future<void> _loadHotelsType() async {
    hotelsType = await tourvisorService.getHotelTypes();
  }

  Future<void> _loadHotelsList() async {
    hotelListDepartureModel = await tourvisorService.getHotelLists();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(10, 10),
            blurRadius: 16,
          ),
        ],
        color: context.accentColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDropdown(
              'Откуда',
              globalSelectedCityFrom,
              departures,
              (dynamic newValue) {
                setState(() {
                  globalSelectedCityFrom = newValue!;
                });
              },
            ),
            _buildDropdown(
              'Куда',
              globalSelectedCityTo,
              countries,
              (dynamic newValue) {
                setState(() {
                  globalSelectedCityTo = newValue!;
                });
                _loadHotelsType();
              },
            ),
            _buildNightRangeSlider(),
            _buildDateRangePicker('Даты отправки'),
            if (_showAdditionalSettings)
              _buildCounter(
                'Взрослых',
                globalAdultsCount,
                10,
                (int newValue) {
                  setState(() {
                    globalAdultsCount = newValue;
                  });
                },
                1,
              ),
            if (_showAdditionalSettings)
              _buildCounter(
                'Детей',
                globalChildrenCount,
                5,
                (int newValue) {
                  setState(() {
                    globalChildrenCount = newValue;
                  });
                },
                0,
              ),
            if (_showAdditionalSettings)
              DropdownButtonFormField<int>(
                iconEnabledColor: Colors.white,
                value: globalMealType,
                dropdownColor: context.primaryColor,
                onChanged: (int? newValue) {
                  setState(() {
                    globalMealType = newValue!;
                  });
                },
                items: mealTypesMap.keys.map((int key) {
                  return DropdownMenuItem<int>(
                    value: key,
                    child: Text(
                      mealTypesMap[key]!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Выберите питание от',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            if (_showAdditionalSettings)
              DropdownButtonFormField<int>(
                iconEnabledColor: Colors.white,
                dropdownColor: context.primaryColor,
                value: globalRatingType,
                onChanged: (int? newValue) {
                  setState(() {
                    globalRatingType = newValue!;
                  });
                },
                items: ratingTypesMap.keys.map((int key) {
                  return DropdownMenuItem<int>(
                    value: key,
                    child: Text(
                      ratingTypesMap[key]!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Рейтинг отеля от',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            if (_showAdditionalSettings)
              _buildBudgetInput('Мин. бюджет', minBudgetController, (value) {
                globalMinBudget = value;
              }),
            if (_showAdditionalSettings)
              _buildBudgetInput('Макс. бюджет', maxBudgetController, (value) {
                globalMaxBudget = value;
              }),
            if (_showAdditionalSettings)
              _buildMultiDropdown(
                'Тип отеля',
                globalHotelTypes,
                hotelsType,
                (isChecked, id) {
                  setState(() {
                    if (isChecked!) {
                      globalHotelTypes.add(id);
                    } else {
                      globalHotelTypes.remove(id);
                    }
                  });
                },
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showAdditionalSettings = !_showAdditionalSettings;
                });
              },
              child: Text(
                _showAdditionalSettings
                    ? 'Скрыть настройки'
                    : 'Больше настроек',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                }
                // Действие при нажатии на кнопку поиска
                // Доступ к значениям минимального и максимального бюджета:
                final minBudget = minBudgetController.text;
                final maxBudget = maxBudgetController.text;
                // Дальнейшая обработка значений бюджета
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blueTickColor,
              ),
              child: Text(
                'Искать',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNightRangeSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ночей ',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        Row(
          children: [
            Text(
              '${selectedNightRange.start.round()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
            RangeSlider(
              values: selectedNightRange,
              activeColor: blueTickColor,
              min: 1,
              max: 30,
              onChanged: (RangeValues values) {
                setState(() {
                  selectedNightRange = values;
                  globalNightsFrom = values.start;
                  globalNightsTo = values.end;
                });
              },
              labels: RangeLabels(
                selectedNightRange.start.round().toString(),
                selectedNightRange.end.round().toString(),
              ),
            ),
            Text(
              '${selectedNightRange.end.round()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    dynamic value,
    List<Departure> items,
    void Function(dynamic) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        DropdownButton(
          value: value,
          onChanged: onChanged,
          dropdownColor: context.primaryColor,
          iconEnabledColor: Colors.white,
          items: items.map<DropdownMenuItem>((item) {
            return DropdownMenuItem(
              value: item.id,
              child: Text(
                item.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCounter(
    String label,
    int value,
    int max,
    void Function(int) onChanged,
    int min,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (min < value) {
                  onChanged(value - 1);
                }
              },
              icon: Icon(Icons.remove),
              color: Colors.white,
            ),
            Text(
              value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                onChanged(value + 1);
              },
              icon: Icon(Icons.add),
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBudgetInput(
      String label, TextEditingController controller, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        SizedBox(
          width: 150,
          child: TextFormField(
            controller: controller,
            onChanged: (value) {
              onChanged(int.parse(value == '' ? '0' : value));
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Введите сумму',
            ),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangePicker(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(blueTickColor)),
          onPressed: () async {
            DateTimeRange? pickedDateRange = await showDateRangePicker(
                context: context,
                initialDateRange: selectedDateRange,
                firstDate: DateTime.now().add(Duration(days: 1)),
                lastDate: DateTime(2101),
                locale: const Locale('ru', 'RU'),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.light(
                        primary: blueTickColor,
                        onPrimary: Colors.white,
                        surface: blueTickColor,
                        onSurface: Colors.black,
                      ),
                      dialogBackgroundColor: blueTickColor,
                      datePickerTheme: DatePickerThemeData(
                          headerBackgroundColor: blueTickColor,
                          headerHeadlineStyle:
                              TextStyle(backgroundColor: blueTickColor)),
                    ),
                    child: child!,
                  );
                });
            if (pickedDateRange != null) {
              setState(() {
                selectedDateRange = pickedDateRange;
                globalDepartureDateFrom = pickedDateRange.start;
                globalDepartureDateTo = pickedDateRange.end;
              });
            }
          },
          child: Text(
            selectedDateRange != null
                ? '${DateFormat('dd.MM.yyyy').format(selectedDateRange.start)} - ${DateFormat('dd.MM.yyyy').format(selectedDateRange!.end)}'
                : 'Выберите диапазон',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildMultiDropdown(
    String label,
    dynamic value,
    List<HotelType> items,
    void Function(dynamic, int) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        Wrap(
          children: items.map((item) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero, // Уменьшаем отступы
              title: Text(
                item.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              value: globalHotelTypes.contains(item.id),
              checkColor: Colors.white,
              onChanged: (bool? isChecked) {
                onChanged(isChecked, item.id!);
                // setState(() {
                //   if (isChecked!) {
                //     globalHotelTypes.add(item.id!);
                //   } else {
                //     globalHotelTypes.remove(item.id);
                //   }
                // });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
