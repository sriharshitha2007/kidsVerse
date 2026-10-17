class Habit {
  final String id;
  final String title;
  final String icon;
  final String description;
  final List<String> steps;
  final String importance;

  Habit({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.steps,
    required this.importance,
  });
}

final List<Habit> habitsList = [
  Habit(
    id: '1',
    title: 'Wash Hands Before Eating',
    icon: '🧼',
    description: 'Keep your hands clean and healthy',
    steps: [
      'Wet your hands with clean water',
      'Apply soap and make bubbles',
      'Rub your palms and back of hands',
      'Clean between your fingers',
      'Wash your wrists',
      'Rinse well with clean water',
      'Dry your hands with a clean towel',
    ],
    importance: 'Washing hands removes germs and keeps you healthy!',
  ),
  Habit(
    id: '2',
    title: 'Brush Teeth Daily',
    icon: '🪥',
    description: 'Keep your teeth strong and white',
    steps: [
      'Wet your toothbrush with water',
      'Apply toothpaste to the brush',
      'Brush the outer surfaces of your teeth',
      'Brush the inner surfaces of your teeth',
      'Brush the top surfaces where you chew',
      'Gently brush your tongue',
      'Rinse your mouth with water',
    ],
    importance: 'Brushing twice a day keeps your teeth healthy and your smile bright!',
  ),
  Habit(
    id: '3',
    title: 'Keep Toys Neatly',
    icon: '🧹',
    description: 'Organize your toys properly',
    steps: [
      'Put toys in a toy box after playing',
      'Keep similar toys together',
      'Avoid leaving toys on the floor',
      'Take care of your things',
      'Help keep your room clean',
    ],
    importance: 'Keeping things neat helps you stay safe and find your toys easily!',
  ),
  Habit(
    id: '4',
    title: 'Say Please and Thank You',
    icon: '🙏',
    description: 'Be polite and respectful',
    steps: [
      'Ask politely for what you want',
      'Say "Please" when asking for something',
      'Say "Thank you" after receiving help',
      'Smile when you say it',
      'Be kind to everyone',
    ],
    importance: 'Using polite words makes people happy and shows you are kind!',
  ),
  Habit(
    id: '5',
    title: 'Throw Waste in Dustbin',
    icon: '🗑️',
    description: 'Keep your environment clean',
    steps: [
      'Look for a dustbin near you',
      'Pick up the waste or rubbish',
      'Put it in the dustbin',
      'Do not leave things on the ground',
      'Help keep your school and home clean',
    ],
    importance: 'Keeping places clean makes everyone healthy and happy!',
  ),
  Habit(
    id: '6',
    title: 'Eat Healthy Food',
    icon: '🍎',
    description: 'Choose nutritious food for your body',
    steps: [
      'Eat fruits every day',
      'Eat vegetables with meals',
      'Drink milk for strong bones',
      'Eat whole grains like oats',
      'Limit sugary snacks and drinks',
    ],
    importance: 'Healthy food helps you grow tall, strong, and smart!',
  ),
  Habit(
    id: '7',
    title: 'Respect Parents and Teachers',
    icon: '👋',
    description: 'Show respect to elders',
    steps: [
      'Listen when adults speak',
      'Obey their instructions',
      'Be polite in your words and actions',
      'Never talk back rudely',
      'Ask permission before doing things',
    ],
    importance: 'Respecting elders makes them proud of you!',
  ),
  Habit(
    id: '8',
    title: 'Make Your Bed',
    icon: '🛏️',
    description: 'Start your day with a clean space',
    steps: [
      'Pull the blanket up to the pillow',
      'Straighten the sheets',
      'Arrange your pillows neatly',
      'Make sure everything is tidy',
      'Do this every morning after waking up',
    ],
    importance: 'A clean bed welcomes you after a tiring day!',
  ),
];
