import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import joblib

data_loader = load_iris()

X_data = data_loader.data
X_columns = data_loader.feature_names
x = pd.DataFrame(X_data, columns=X_columns)

y_data = data_loader.target
y = pd.Series(y_data, name='target')

x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.2, random_state=42)

rf = RandomForestClassifier()
rf.fit(x_train, y_train)
pred = rf.predict(x_test)
score = accuracy_score(pred, y_test)

print(score)

joblib.dump(rf, 'trained_models/iris.pkl')