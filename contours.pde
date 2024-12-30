float max(float[][] array) {
    float maxValue = -Float.MAX_VALUE;

    for (int i = 0; i < array.length; i++) {
        for (int j = 0; j < array[i].length; j++) {
            if (array[i][j] > maxValue) {
                maxValue = array[i][j];
            }
        }
    }

    return maxValue;
}

void drawBenchmarkContours(String benchmarkType, float xMin, float xMax, float yMin, float yMax, int gridX, int gridY) {
    float[][] values = new float[gridX][gridY];
    float dx = (xMax - xMin) / (gridX - 1);
    float dy = (yMax - yMin) / (gridY - 1);
    
    for (int i = 0; i < gridX; i++) {
        for (int j = 0; j < gridY; j++) {
            float x = xMin + i * dx;
            float y = yMin + j * dy;

            values[i][j] = evaluationFunction(objectiveFunction(new float[] {x, y}, benchmarkType));
        }
    }
    
    float maxValue = max(values);

    noStroke();

    for (int i = 0; i < gridX - 1; i++) {
        for (int j = 0; j < gridY - 1; j++) {
            float value = values[i][j];
            float normalizedValue = map(value, 0, maxValue, 0, 1);

            fill(lerpColor(color(0, 0, 255), color(255, 0, 0), normalizedValue));
            rect(map(i, 0, gridX, 0, width), map(j, 0, gridY, height, 0), dx * width / (xMax - xMin), dy * height / (yMax - yMin));
        }
    }
}