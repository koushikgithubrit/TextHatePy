import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb
from sklearn.model_selection import train_test_split

# Text Pre-processing libraries
import nltk
import string
import warnings
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from wordcloud import WordCloud

# Tensorflow imports to build the model.
import tensorflow as tf
from tensorflow import keras
from keras import layers
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

nltk.download('stopwords')
nltk.download('omw-1.4')
nltk.download('wordnet')
warnings.filterwarnings('ignore')

# DATA SET
df = pd.read_csv('../train.csv/hate_speech.csv')
df.head()

df.shape

df.info()


plt.pie(df['class'].value_counts().values,
        labels = df['class'].value_counts().index,
        autopct='%1.1f%%')
plt.show()


# Lower case all the words of the tweet before any preprocessing
df['tweet'] = df['tweet'].str.lower()
 
# Removing punctuations present in the text
punctuations_list = string.punctuation
def remove_punctuations(text):
    temp = str.maketrans('', '', punctuations_list)
    return text.translate(temp)
 
df['tweet']= df['tweet'].apply(lambda x: remove_punctuations(x))
df.head()


def remove_stopwords(text):
    stop_words = stopwords.words('english')
 
    imp_words = []
 
    for word in str(text).split():
 
        if word not in stop_words:
 
            lemmatizer = WordNetLemmatizer()
            lemmatizer.lemmatize(word)
 
            imp_words.append(word)
 
    output = " ".join(imp_words)
 
    return output
 
 
df['tweet'] = df['tweet'].apply(lambda text: remove_stopwords(text))
df.head()


class_2 = df[df['class'] == 2]
class_1 = df[df['class'] == 1].sample(n=3500)
class_0 = df[df['class'] == 0]
 
balanced_df = pd.concat([class_0, class_0, class_0, class_1, class_2], axis=0)


plt.pie(balanced_df['class'].value_counts().values,
        labels=balanced_df['class'].value_counts().index,
        autopct='%1.1f%%')
plt.show()


features = balanced_df['tweet']
target = balanced_df['class']
 
X_train, X_val, Y_train, Y_val = train_test_split(features,
                                                  target,
                                                  test_size=0.2,
                                                  random_state=22)
X_train.shape, X_val.shape


Y_train = pd.get_dummies(Y_train)
Y_val = pd.get_dummies(Y_val)
Y_train.shape, Y_val.shape


max_words = 5000
max_len = 100
 
token = Tokenizer(num_words=max_words,
                  lower=True,
                  split=' ')
 
token.fit_on_texts(X_train)


max_words = 5000
token = Tokenizer(num_words=max_words,
                  lower=True,
                  split=' ')
token.fit_on_texts(X_train)
 
Training_seq = token.texts_to_sequences(X_train)
Training_pad = pad_sequences(Training_seq,
                             maxlen=50,
                             padding='post',
                             truncating='post')
 
Testing_seq = token.texts_to_sequences(X_val)
Testing_pad = pad_sequences(Testing_seq,
                            maxlen=50,
                            padding='post',
                            truncating='post')

# model = keras.models.Sequential([
#     layers.Embedding(max_words, 32, input_length=max_len),
#     layers.Conv1D(128, 5, activation='relu'),
#     layers.GlobalMaxPooling1D(),
#     layers.Dense(512, activation='relu'),
#     layers.Dropout(0.3),
#     layers.Dense(3, activation='softmax')
# ])
model = keras.models.Sequential([
    layers.Embedding(max_words, 32, input_shape=(max_len,)),
    layers.Conv1D(128, 5, activation='relu'),
    layers.GlobalMaxPooling1D(),
    layers.Dense(512, activation='relu'),
    layers.Dropout(0.3),
    layers.Dense(3, activation='softmax')
])

 
model.compile(loss='categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])
 
model.summary()


from keras.callbacks import EarlyStopping, ReduceLROnPlateau
 
es = EarlyStopping(patience=3,
                   monitor = 'val_accuracy',
                   restore_best_weights = True)
 
lr = ReduceLROnPlateau(patience = 2,
                       monitor = 'val_loss',
                       factor = 0.5,
                       verbose = 0)


# history = model.fit(Training_pad, Y_train,
#                     validation_data=(Testing_pad, Y_val),
#                     epochs=50,
#                     verbose=1,
#                     batch_size=32,
#                     callbacks=[lr, es])
history = model.fit(Training_pad, Y_train,
                    validation_data=(Testing_pad, Y_val),
                    epochs=50,
                    verbose=1,
                    batch_size=32,
                    callbacks=[lr, es])

# Save the model
model.save('model.h5')

history_df = pd.DataFrame(history.history)
history_df.loc[:, ['loss', 'val_loss']].plot()
history_df.loc[:, ['accuracy', 'val_accuracy']].plot()
plt.show()


# Function to preprocess user input
def preprocess_input(text):
    text = text.lower()
    text = remove_punctuations(text)
    text = remove_stopwords(text)
    return text

# Function to predict hate speech
def predict_hate_speech(text):
    text = preprocess_input(text)
    sequence = token.texts_to_sequences([text])
    padded_sequence = pad_sequences(sequence, maxlen=50, padding='post', truncating='post')
    prediction = model.predict(padded_sequence)
    return prediction

# Interactive user input
while True:
    user_input = input("Enter a sentence to check for hate speech (type 'quit' to exit): ")
    if user_input.lower() == 'quit':
        break
    else:
        prediction = predict_hate_speech(user_input)
        if np.argmax(prediction) == 1:
            print("The input is classified as hate speech.")
        else:
            print("The input is not classified as hate speech.")
