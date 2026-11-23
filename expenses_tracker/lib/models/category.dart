enum Category {
  food('Սնունդ', '🍔'),
  transport('Տրանսպորտ', '🚗'),
  entertainment('Զվարճանք', '🎬'),
  other('Այլ', '📦');

  const Category(this.label, this.emoji);

  final String label;
  final String emoji;

  String get displayName => '$emoji $label';
}
