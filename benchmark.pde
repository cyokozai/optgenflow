// Sphere
float sphere(float[] position) {
    float sum = 0;

    for (int i = 0; i < position.length; i++) {
        sum += sq(position[i]);
    }
    
    return sum;
}

// Rosenbrock
float rosenbrock(float[] position) {
    float sum = 0;

    for (int i = 0; i < position.length - 1; i++) {
        float xi = position[i];
        float xNext = position[i + 1];

        sum += 100 * sq(xNext - sq(xi)) + sq(xi - 1);
    }

    return sum;
}

// Rastrigin
float rastrigin(float[] position) {
    float sum = 0;

    for (int i = 0; i < position.length; i++) {
        sum += sq(position[i]) - 10 * cos(2 * PI * position[i]);
    }

    return 10 * position.length + sum;
}

// 目的関数
float objectiveFunction(float[] position, String benchmarkType) {
    if (benchmarkType.equals("SPHERE")) {
        return sphere(position);
    } else if (benchmarkType.equals("ROSENBROCK")) {
        return rosenbrock(position);
    } else if (benchmarkType.equals("RASTRIGIN")) {
        return rastrigin(position);
    } else {
        println("Unknown benchmark type: " + benchmarkType);
        return Float.MAX_VALUE;
    }
}

// 評価関数
float evaluationFunction(float sum) {
    return sum > 0 ? 1.0 / (1.0 + sum) : 1.0 + abs(sum);
}

// 勾配を計算する関数
float[] computeGradient(float[] position, String benchmarkType) {
    float[] gradient = new float[position.length];
    float h = 1e-5;
    
    for (int i = 0; i < position.length; i++) {
        float[] posPlusH = position.clone();
        posPlusH[i] += h;
        float f1 = objectiveFunction(posPlusH, benchmarkType);
        
        float[] posMinusH = position.clone();
        posMinusH[i] -= h;
        float f2 = objectiveFunction(posMinusH, benchmarkType);
        
        gradient[i] = (f1 - f2) / (2 * h);
    }
    
    return gradient;
}