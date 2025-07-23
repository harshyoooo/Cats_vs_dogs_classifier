from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializer import ImageUploadSerializer
import tensorflow as tf
import numpy as np
from PIL import Image
import io
from tensorflow.keras.models import load_model

model = load_model("classifier/models/cat_dog_classifier.h5")

class PredictView(APIView):
    def post(self, request):
        serializer = ImageUploadSerializer(data=request.data)
        if serializer.is_valid():
            image = serializer.validated_data['image']
            img = Image.open(image).resize((150, 150)).convert('RGB')
            img_array = np.expand_dims(np.array(img) / 255.0, axis=0)

            prediction = model.predict(img_array)[0][0]
            result = "Dog 🐶" if prediction > 0.7 else "Cat 🐱"
            confidence = float(prediction) if prediction > 0.7 else 1 - float(prediction)
            
            return Response({
                'prediction': result,
                'confidence': round(confidence * 100, 2)
            })
        return Response(serializer.errors, status=400)
