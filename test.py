from langdetect import detect
from googletrans import Translator
import numpy as np
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences

# Load the trained model
model = load_model("model.h5")

# Function to detect language


def detect_language(text):
    try:
        return detect(text)
    except:
        return None

# Function to translate text to English


def translate_to_english(text):
    translator = Translator()
    translated_text = translator.translate(text, dest='en')
    return translated_text.text

# Function to preprocess input text


def preprocess_input(text):
    text = text.lower()
    text = remove_punctuations(text)
    text = remove_stopwords(text)
    return text

# Function to predict hate speech


def predict_hate_speech(text):
    language = detect_language(text)
    if language != 'en':  # If language is not English, translate it to English
        text = translate_to_english(text)
    text = preprocess_input(text)
    sequence = token.texts_to_sequences([text])
    padded_sequence = pad_sequences(
        sequence, maxlen=50, padding='post', truncating='post')
    prediction = model.predict(padded_sequence)
    return prediction


# Interactive user input
while True:
    user_input = input(
        "Enter a sentence to check for hate speech (type 'quit' to exit): ")
    if user_input.lower() == 'quit':
        break
    else:
        prediction = predict_hate_speech(user_input)
        if np.argmax(prediction) == 1:
            print("The input is classified as hate speech.")
        else:
            print("The input is not classified as hate speech.")
