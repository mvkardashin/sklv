abstract class MonthService {
  static String converter(int id) {
    switch (id % 12) {
      case 1:
        return 'Январь';
      case 2:
        return 'Февраль';
      case 3:
        return 'Март';
      case 4:
        return 'Апрель';
      case 5:
        return 'Май';
      case 6:
        return 'Июнь';
      case 7:
        return 'Июль';
      case 8:
        return 'Август';
      case 9:
        return 'Сентябрь';
      case 10:
        return 'Октябрь';
      case 11:
        return 'Ноябрь';
      case 0:
        return 'Декабрь';
      default:
        return 'Декабрь';
    }
  }

  static DateTime plusMonths(int months) {
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month);
    DateTime newDate;
    if (now.month + months > 12) {
      print(now.month + months);
      newDate = DateTime(now.year + 1, now.month + months - 12);
    } else {
      newDate = DateTime(now.year, now.month + months);
    }

    return newDate;
  }
}
