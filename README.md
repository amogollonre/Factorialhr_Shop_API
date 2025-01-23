<<<<<<< HEAD
# Factorialhr Shop API

Una API RESTful para una tienda en línea de productos personalizables, inicialmente enfocada en bicicletas pero diseñada para escalar a otros artículos deportivos.

## 🚀 Características

- Gestión completa de productos personalizables
- Sistema de categorías con características y opciones dinámicas
- Manejo de restricciones entre opciones de productos
- Carrito de compras con validaciones de configuración
- Gestión de imágenes para productos y opciones
- API RESTful documentada con Swagger

## 🛠️ Tecnologías

- Ruby 3.2.2
- Rails 8.0.1
- PostgreSQL 15
- Docker & Docker Compose
- RSpec para testing
- Swagger para documentación de API

## 📋 Requisitos Previos

- Docker Desktop
- Docker Compose
- Git

## 🔧 Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/amogollonre/Factorialhr_Shop_API
cd factorial-shop-api
```

2. Configurar variables de entorno:
```bash
cp .env.example .env
```

3. Construir y levantar los contenedores:
```bash
docker-compose up -d
```

4. Crear y configurar la base de datos:
```bash
docker-compose exec api rails db:create db:migrate db:seed
```

El servidor estará disponible en `http://localhost:3000`

## 🗄️ Estructura del Proyecto

```
app/
├── controllers/          # Controladores de la API
├── models/              # Modelos y lógica de negocio
├── services/           # Servicios para lógica compleja
├── serializers/        # Serializadores JSON
└── validators/         # Validadores personalizados

spec/
├── requests/           # Pruebas de integración
├── models/            # Pruebas unitarias de modelos
└── factories/         # Factories para testing

config/
└── routes.rb          # Definición de rutas API
```

## 📚 Modelos Principales

- **Category**: Categorías de productos (ej: Mountain Bikes, Road Bikes)
- **Item**: Productos base
- **Characteristic**: Características configurables (ej: tamaño de cuadro, tipo de suspensión)
- **CharacteristicOption**: Opciones disponibles para cada característica
- **CategoryOptionRestriction**: Restricciones entre opciones
- **Cart/CartItem**: Gestión de carritos de compra

## 🔑 Endpoints Principales

### Categorías
- `GET /categories` - Listar categorías
- `POST /categories` - Crear categoría
- `GET /categories/:id` - Obtener categoría
- `PATCH /categories/:id` - Actualizar categoría
- `DELETE /categories/:id` - Eliminar categoría

### Productos
- `GET /items` - Listar productos (paginado)
- `POST /items` - Crear producto
- `GET /items/:id` - Obtener producto
- `PATCH /items/:id` - Actualizar producto
- `DELETE /items/:id` - Eliminar producto

### Carrito
- `GET /carts` - Listar carritos
- `POST /carts` - Crear carrito
- `GET /carts/:id` - Obtener carrito
- `POST /cart_items` - Añadir item al carrito
- `PATCH /cart_items/:id` - Actualizar item del carrito

Consulta la documentación completa de la API en `/api-docs`

## 🧪 Testing

Ejecutar las pruebas:
```bash
docker-compose exec api bundle exec rspec
```

## 📈 Mejoras Futuras

- Implementación de autenticación y autorización
- Sistema de caché para optimizar consultas frecuentes
- Integración con sistema de procesamiento de imágenes
- Implementación de webhooks para eventos importantes
- Sistema de notificaciones en tiempo real

## 🤝 Contribución

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## 🔬 Validaciones, Asociaciones y Consideraciones Técnicas

### Modelo de Datos y Asociaciones

1. **Categorías y Productos**
   - Las categorías son la base para organizar productos (ej: Mountain Bikes, Road Bikes)
   - Cada producto pertenece a una categoría y hereda sus características configurables
   - Los productos tienen un precio base que se ajusta según las opciones seleccionadas

2. **Características y Opciones**
   - Las características están vinculadas a categorías (ej: tipo de cuadro, suspensión)
   - Cada característica puede tener múltiples opciones con ajustes de precio
   - Las opciones pueden tener imágenes asociadas y estado de stock

3. **Restricciones**
   - Sistema flexible de restricciones entre opciones dentro de una categoría
   - Las restricciones pueden ser de tipo "bloqueo" o "forzado"
   - Validación automática de combinaciones al configurar productos

4. **Carritos y Elementos**
   - Los carritos mantienen estado (pending, completed, cancelled)
   - Cada elemento del carrito guarda la configuración completa del producto
   - El precio final se calcula considerando producto base + ajustes de opciones

### Datos Semilla Incluidos

1. **Categorías Predefinidas**
   - Mountain Bikes: Bicicletas para terreno montañoso
   - Road Bikes: Bicicletas para carretera y competición

2. **Características Ejemplo (Mountain Bikes)**
   - Cuadro: Opciones de Aluminio (base) y Carbono (+$500)
   - Suspensión: Rígida (-$200), Delantera (base), Doble (+$300)

3. **Productos Muestra**
   - Trail Beast: Bicicleta todo terreno para principiantes ($999.99)
   - Mountain Pro: Bicicleta profesional para competición ($1999.99)

4. **Restricción Ejemplo**
   - No se permite combinar cuadro de carbono con suspensión rígida

### Consideraciones y Limitaciones Actuales

1. **Autenticación y Autorización**
   - La aplicación no implementa sistema de usuarios
   - No hay roles ni permisos diferenciados
   - Todas las operaciones están disponibles públicamente

2. **Gestión de Datos**
   - Las imágenes se manejan por URL, no hay upload local
   - Los precios se calculan en tiempo real
   - No hay sistema de caché implementado

3. **Validaciones**
   - Validaciones a nivel de modelo para integridad de datos
   - Validaciones de negocio para restricciones entre opciones
   - Manejo de errores centralizado en BaseController

### Testing

Para ejecutar las pruebas automatizadas:

```bash
docker-compose exec api bundle exec rspec --format documentation
```

### Mejoras Propuestas

1. **Seguridad y Usuarios**
   - Implementar sistema de autenticación
   - Añadir roles (admin, vendedor, cliente)
   - Permisos granulares para operaciones

2. **Optimización**
   - Implementar sistema de caché
   - Optimizar queries de productos con características
   - Mejorar manejo de imágenes

3. **Funcionalidades**
   - Sistema de variantes de productos
   - Gestión de inventario
   - Historial de cambios en productos
   - Sistema de notificaciones

4. **Infraestructura**
   - Implementar workers para tareas asíncronas
   - Mejorar logging y monitoreo
   - Sistema de backup automático

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🔍 Soporte

Para soporte, enviar un email a [amogollonr@unal.edu.co]
=======
# Factorialhr_Shop_API
>>>>>>> a34fb5c027a353f15e2659ce427c68a436446839
