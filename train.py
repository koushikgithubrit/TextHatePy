import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
import nltk
import string
import warnings
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
import tensorflow as tf

# Downloading NLTK resources
nltk.download('stopwords')
nltk.download('wordnet')

# Load dataset
df = pd.read_csv('./hate_speech.csv')

# Lowercase all words in the tweet column
df['tweet'] = df['tweet'].str.lower()

# Remove punctuations
df['tweet'] = df['tweet'].apply(lambda x: x.translate(
    str.maketrans('', '', string.punctuation)))

# Define function to remove stopwords and lemmatize words


def remove_stopwords_and_lemmatize(text):
    stop_words = set(stopwords.words('english'))
    lemmatizer = WordNetLemmatizer()
    words = text.split()
    cleaned_words = [lemmatizer.lemmatize(
        word) for word in words if word.lower() not in stop_words]
    return ' '.join(cleaned_words)


# Apply text preprocessing
df['tweet'] = df['tweet'].apply(remove_stopwords_and_lemmatize)

# Class balancing
class_2 = df[df['class'] == 2]
class_1 = df[df['class'] == 1].sample(n=3500)
class_0 = df[df['class'] == 0]
balanced_df = pd.concat([class_0, class_0, class_0, class_1, class_2], axis=0)

# Split features and target
features = balanced_df['tweet']
target = balanced_df['class']

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    features, target, test_size=0.2, random_state=22)

# Tokenization and padding
max_words = 5000
max_len = 100
tokenizer = Tokenizer(num_words=max_words, lower=True, split=' ')
tokenizer.fit_on_texts(X_train)
X_train = tokenizer.texts_to_sequences(X_train)
X_train = pad_sequences(X_train, maxlen=max_len)
X_test = tokenizer.texts_to_sequences(X_test)
X_test = pad_sequences(X_test, maxlen=max_len)

# Convert target labels to one-hot encoding
encoder = LabelEncoder()
encoder.fit(y_train)
y_train = encoder.transform(y_train)
y_test = encoder.transform(y_test)
y_train = keras.utils.to_categorical(y_train)
y_test = keras.utils.to_categorical(y_test)

# Model definition
model = keras.models.Sequential([
    layers.Embedding(max_words, 32, input_shape=(max_len,)),
    layers.Conv1D(128, 5, activation='relu'),
    layers.GlobalMaxPooling1D(),
    layers.Dense(512, activation='relu'),
    layers.Dropout(0.3),
    layers.Dense(3, activation='softmax')
])

model.compile(loss='categorical_crossentropy',
              optimizer='adam', metrics=['accuracy'])

# Define callback to print training progress


class PrintCallback(keras.callbacks.Callback):
    def on_epoch_end(self, epoch, logs=None):
        print(
            f'Epoch {epoch+1}/{epochs}, loss: {logs["loss"]:.4f}, accuracy: {logs["accuracy"]:.4f}, val_loss: {logs["val_loss"]:.4f}, val_accuracy: {logs["val_accuracy"]:.4f}')


# Train the model
epochs = 2000  # Adjust epochs as needed
history = model.fit(X_train, y_train, validation_data=(
    X_test, y_test), epochs=epochs, batch_size=32, callbacks=[PrintCallback()])

# Save Keras model
model.save("hate_speech_detection_model.h5")

# Convert Keras model to TFLite model
converter = keras.models.load_model("hate_speech_detection_model.h5")
converter = tf.lite.TFLiteConverter.from_keras_model(converter)
tflite_model = converter.convert()

# Save the TFLite model to disk
with open('hate_speech_detection_model.tflite', 'wb') as f:
    f.write(tflite_model)

# Save epochs logs to CSV file
history_df = pd.DataFrame(history.history)
history_df.to_csv('epochs_logs.csv', index=False)
