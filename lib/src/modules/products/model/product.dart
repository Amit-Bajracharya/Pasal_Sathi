/// How a [Product]'s stock level should be presented.
enum ProductStockStatus { normal, lowStock, outOfStock }

/// A single row in the Products & Inventory list.
class Product {
  const Product({
    required this.name,
    required this.category,
    required this.unitLabel,
    required this.tagLabel,
    required this.sellingPrice,
    required this.costPrice,
    required this.stockLabel,
    required this.status,
  });

  final String name;
  final String category;
  final String unitLabel;

  /// Secondary tag shown next to the category chip, e.g. "Barcode: 890123"
  /// or "Fast Mover" — purely informational, not status-related.
  final String tagLabel;

  final double sellingPrice;
  final double costPrice;

  /// e.g. "80 packets in stock" or "Only 4 pouches left!".
  final String stockLabel;

  final ProductStockStatus status;

  double get margin => sellingPrice - costPrice;

  double get marginPercent => costPrice == 0 ? 0 : (margin / costPrice) * 100;
}
