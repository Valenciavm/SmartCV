
import spacy
# Cargar el modelo en español
nlp = spacy.load("es_core_news_sm")

# Probar con una frase
doc = nlp("Juan Pérez nació en Bogotá y trabaja en una empresa de software.")

# Mostrar entidades detectadas
for ent in doc.ents:
    print(ent.text, ent.label_)
