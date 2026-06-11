import '../models/product.dart';

final dummyData = [
  Product(
    id: 'p1',
    name: 'Hambúrguer Especial',
    description: 'Hambúrguer artesanal com queijo e bacon.',
    price: 3500,
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
    category: 'Alimentos',
  ),
  Product(
    id: 'p2',
    name: 'Salada de Escarola',
    description: 'Salada de Escarola com Bacon e Molho de Mostarda.',
    price: 5500,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2NTdyoN8TYRYog-UhfEDi6inLA_-pE9KkwQ&s',
    category: 'Alimentos',
  ),
  Product(
    id: 'p3',
    name: 'Coca-Cola',
    description: 'A melhor Coca-Cola de sempre.',
    price: 4000,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ43-THA2jUbBLyZRZjv_bf1GJHw4vAHqRhvc0mDOn1xg&s',
    category: 'Refrigerantes',
  ),
  Product(
    id: 'p4',
    name: 'Tequila Ouro',
    description: 'Tequila Ouro Jose Cuervo 750.',
    price: 8500,
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
    category: 'Refrigerantes',
  ),
];
