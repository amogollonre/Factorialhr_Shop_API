# db/seeds.rb

# Crear categorías
mountain_bikes = Category.create!(
  name: 'Mountain Bikes',
  description: 'Bicicletas diseñadas para terreno montañoso',
  active: true
)

road_bikes = Category.create!(
  name: 'Road Bikes',
  description: 'Bicicletas para carretera y competición',
  active: true
)

# Crear características para Mountain Bikes
frame = mountain_bikes.characteristics.create!(
  name: 'Cuadro',
  description: 'Tipo de cuadro de la bicicleta',
  required: true,
  active: true
)

suspension = mountain_bikes.characteristics.create!(
  name: 'Suspensión',
  description: 'Sistema de suspensión',
  required: true,
  active: true
)

# Crear opciones para las características
frame_options = [
  { name: 'Aluminio', description: 'Ligero y económico', price_adjustment: 0 },
  { name: 'Carbono', description: 'Ultra ligero y premium', price_adjustment: 500 }
].each do |option|
  frame.characteristic_options.create!(option)
end

suspension_options = [
  { name: 'Rígida', description: 'Sin suspensión', price_adjustment: -200 },
  { name: 'Delantera', description: 'Suspensión frontal', price_adjustment: 0 },
  { name: 'Doble', description: 'Suspensión delantera y trasera', price_adjustment: 300 }
].each do |option|
  suspension.characteristic_options.create!(option)
end

# Crear productos
[
  {
    name: 'Trail Beast',
    description: 'Bicicleta todo terreno para principiantes',
    base_price: 999.99,
    category: mountain_bikes
  },
  {
    name: 'Mountain Pro',
    description: 'Bicicleta profesional para competición',
    base_price: 1999.99,
    category: mountain_bikes
  }
].each do |product|
  item = Item.create!(product)
  item.item_images.create!(
    url: "https://example.com/images/#{item.name.parameterize}.jpg",
    alt_text: item.name,
    is_main: true
  )
end

# Crear restricciones
rigid_suspension = suspension.characteristic_options.find_by(name: 'Rígida')
carbon_frame = frame.characteristic_options.find_by(name: 'Carbono')

CategoryOptionRestriction.create!(
  category: mountain_bikes,
  if_characteristic_option: rigid_suspension,
  then_characteristic_option: carbon_frame,
  restriction_type: 'block',
  active: true
)