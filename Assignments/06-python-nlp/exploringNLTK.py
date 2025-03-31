import nltk
from nltk.probability import FreqDist
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from urllib.request import urlopen

# Ensure NLTK resources are downloaded
nltk.download('punkt')
nltk.download('stopwords')

# Function to read a text file (local or online)
def read_text(file_path_or_url):
    try:
        if file_path_or_url.startswith('http'):  # If source is a URL
            with urlopen(file_path_or_url) as f:
                text = f.read().decode('utf-8')
        else:  # Local file
            with open(file_path_or_url, 'r', encoding='utf-8') as f:
                text = f.read()
        return text
    except Exception as e:
        print(f"Error reading file: {e}")
        return None

# Function to tokenize text while removing stopwords
def preprocess_text(text):
    tokens = word_tokenize(text.lower())  # Tokenize and lowercase
    stop_words = set(stopwords.words('english'))  # Use NLTK stopwords
    filtered_tokens = [word for word in tokens if
                       word.isalnum() and word not in stop_words]  # Filter punctuation and stopwords
    return filtered_tokens

# Function to calculate lexical diversity
def lexical_diversity(tokens):
    return len(set(tokens)) / len(tokens)

# Analyze and compare texts
def analyze_texts(file1, file2):
    # Read and preprocess both texts
    text1 = read_text(file1)
    text2 = read_text(file2)
    if text1 is None or text2 is None:
        return

    tokens1 = preprocess_text(text1)
    tokens2 = preprocess_text(text2)

    # 1. Compare lexical diversity
    diversity1 = lexical_diversity(tokens1)
    diversity2 = lexical_diversity(tokens2)
    print(f"Lexical diversity of text 1: {diversity1:.4f}")
    print(f"Lexical diversity of text 2: {diversity2:.4f}")

    # 2. Most common words in each text
    freq1 = FreqDist(tokens1)
    freq2 = FreqDist(tokens2)
    print("\nMost common words in text 1:")
    print(freq1.most_common(10))
    print("\nMost common words in text 2:")
    print(freq2.most_common(10))

# Change these file paths or URLs to your local files or online text sources
text_file1 = "https://www.gutenberg.org/files/10/10-0.txt"  # Replace with your path or URL
text_file2 = "https://www.gutenberg.org/files/11/11-0.txt"  # Example URL: Alice's Adventures in Wonderland

analyze_texts(text_file1, text_file2)