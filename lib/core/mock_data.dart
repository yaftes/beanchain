import 'package:beanchain/features/coffee/data/models/product.dart';
import 'package:beanchain/features/coffee/data/models/stage.dart';

final mockProduct = Product(
  id: 'prod001',
  name: 'Ethiopian Yirgacheffe',
  origin: 'Yirgacheffe, Ethiopia',
  description: 'A bright and floral coffee with citrus notes.',
  altitude: 1900,
  bean_type: 'Arabica',
  harvest_year: 2024,

  journey: [
    Stage(
      stage: 'Farming',
      company: 'GreenField Farms',
      location: 'Yirgacheffe',
      date_completed: DateTime(2024, 3, 15),
      status: 'Harvested and sorted',
      price_after_stage: 2.8,
    ),

    Stage(
      stage: 'Processing',
      company: 'Blue Nile Processing Co.',
      location: 'Sidama',
      date_completed: DateTime(2024, 4, 2),
      status: 'Washed and dried',
      price_after_stage: 4.20,
    ),

    Stage(
      stage: 'Export',
      company: 'Ethio Exporters Ltd.',
      location: 'Addis Ababa',
      date_completed: DateTime(2024, 4, 25),
      status: 'Packaged and shipped',
      price_after_stage: 7.80,
    ),
  ],
);
