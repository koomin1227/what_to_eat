import 'package:flutter_test/flutter_test.dart';
import 'package:what_to_eat/models/restaurant.dart';

void main() {
  group("Restaurant.fromJson test", () {
    test('식당의 json이 Restaurant 객체로 바뀌어야한다.', () {
      final json = {
        "name": "롯데리아",
        "thumbnail": "http://www.sdffff.bgrr/123t653",
        "tags": [
          {"name": "양식", "category": "음식 종류"}
        ],
        "restaurantId": "qwe1245"
      };
      final restaurant = Restaurant.fromJson(json);
      expect(restaurant.name, "롯데리아");
      expect(restaurant.restaurantId, "qwe1245");
      expect(restaurant.thumbnail, "http://www.sdffff.bgrr/123t653");
      expect(restaurant.tags.length, 1);
    });

    test('식당의 json이 잘못되면 error를 던진다.', () {
      final json = {
        "name": "롯데리아",
        "thumbnail": "http://www.sdffff.bgrr/123t653",
        "tags": [
          {"name": "양식", "category": "음식 종류"}
        ],
      };
      expect(() => Restaurant.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
