from django.urls import path
from .views import parse_cv  # Importamos directamente la vista

urlpatterns = [
    path('parse/', parse_cv, name='parse_cv'),  # Ruta para procesar el CV
]

