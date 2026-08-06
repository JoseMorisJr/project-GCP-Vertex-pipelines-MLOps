"""Transformador serializable para el pipeline de entrenamiento e inferencia."""

import numpy as np
from sklearn.base import BaseEstimator, TransformerMixin


class MetadataFeatureTransformer(BaseEstimator, TransformerMixin):
    """Aplica las reglas de preprocessing_metadata_lowercase.json."""

    QUALITY_MAPPING = {'Po': 1, 'Fa': 2, 'TA': 3, 'Gd': 4, 'Ex': 5, 'Missing': 0, 'NA': 0}
    FINISH_MAPPING = {'Missing': 0, 'NA': 0, 'Unf': 1, 'LwQ': 2, 'Rec': 3, 'BLQ': 4, 'ALQ': 5, 'GLQ': 6}
    STRING_COLUMNS = ['mssubclass', 'mszoning', 'neighborhood', 'centralair', 'garagetype']
    LOG_COLUMNS = ['lotfrontage', 'firstflrsf', 'grlivarea']
    ADDITIONAL_IMPUTATION = {
        'bsmtfinsf_principal': 0,
        'totalbsmtsf': 0,
        'kitchenqual': 'Missing',
        'garagecars': 0,
        'garagearea': 0,
    }

    def __init__(self, metadata):
        self.metadata = metadata

    def fit(self, X, y=None):
        self.feature_order_ = list(self.metadata['minmax_scaler']['feature_order'])
        return self

    def transform(self, X):
        required = set(self.feature_order_) | {'yrsold'}
        required.discard('lotfrontage_na')
        missing = sorted(required - set(X.columns))
        if missing:
            raise ValueError(f'Faltan columnas para transformar: {missing}')

        transformed = X.copy()
        transformed['lotfrontage_na'] = transformed['lotfrontage'].isna().astype(int)

        for column, value in self.metadata['frequent_imputation'].items():
            transformed[column] = transformed[column].fillna(value)
        for column, value in self.metadata['numeric_imputation'].items():
            transformed[column] = transformed[column].fillna(value)
        transformed['fireplacequ'] = transformed['fireplacequ'].fillna('Missing')
        for column, value in self.ADDITIONAL_IMPUTATION.items():
            transformed[column] = transformed[column].fillna(value)

        transformed['garagetype'] = transformed['garagetype'].where(
            transformed['garagetype'].notna(), 'nan'
        )
        transformed[self.STRING_COLUMNS] = transformed[self.STRING_COLUMNS].astype(str)

        transformed['yearremodadd'] = transformed['yrsold'] - transformed['yearremodadd']
        transformed = transformed.drop(columns=['yrsold'])

        for column in self.LOG_COLUMNS:
            if (transformed[column] <= 0).any():
                raise ValueError(f'{column} contiene valores no positivos; no se puede aplicar np.log.')
            transformed[column] = np.log(transformed[column])

        for column in ['bsmtqual', 'kitchenqual', 'fireplacequ']:
            transformed[column] = transformed[column].map(self.QUALITY_MAPPING)
        transformed['bsmtfintype_principal'] = transformed['bsmtfintype_principal'].map(
            self.FINISH_MAPPING
        )

        for column, frequent_labels in self.metadata['rare_labels'].items():
            transformed[column] = transformed[column].where(
                transformed[column].isin(frequent_labels), 'Rare'
            )
        for column, encoding in self.metadata['ordinal_encoding'].items():
            transformed[column] = transformed[column].map(encoding)

        result = transformed.reindex(columns=self.feature_order_)
        if result.isnull().any().any():
            columns_with_nulls = result.columns[result.isnull().any()].tolist()
            raise ValueError(f'Quedaron nulos tras transformar: {columns_with_nulls}')
        return result.astype(float)

    def get_feature_names_out(self, input_features=None):
        return np.asarray(self.feature_order_, dtype=object)
