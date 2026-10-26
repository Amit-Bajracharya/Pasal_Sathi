/// The unit a product is stocked and sold in.
enum ProductUnit {
  kg,
  packet,
  litre,
  piece;

  String get label => switch (this) {
    ProductUnit.kg => 'kg',
    ProductUnit.packet => 'packet',
    ProductUnit.litre => 'litre',
    ProductUnit.piece => 'piece',
  };

  /// Used for the "Opening stock (…)" label, e.g. "packets", "pieces".
  String get pluralLabel => this == ProductUnit.piece ? 'pieces' : '${label}s';
}
