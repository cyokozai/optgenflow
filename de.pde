float[][] bincrossover(float[] parent1, float[] parent2) {
    int point1 = int(random(dimensions));
    int point2 = int(random(dimensions));

    if (point1 > point2) {
        int temp = point1;
        point1 = point2;
        point2 = temp;
    }

    float[] child1 = new float[dimensions];
    float[] child2 = new float[dimensions];

    for (int i = 0; i < dimensions; i++) {
        if (i >= point1 && i <= point2) {
            child1[i] = parent2[i];
            child2[i] = parent1[i];
        } else {
            child1[i] = parent1[i];
            child2[i] = parent2[i];
        }
    }

    return new float[][] {child1, child2};
}

void differentialEvolution() {
    float[][] newPopulation = new float[N][dimensions];

    for (int i = 0; i < N; i++) {
        int r1, r2, r3;
        float[] mutant = new float[dimensions];
        float[] trial  = new float[dimensions];

        do {
            r1 = int(random(N));
            r2 = int(random(N));
            r3 = int(random(N));
        } while (r3 == i || r3 == r1 || r3 == r2);

        for (int j = 0; j < dimensions; j++) {
            mutant[j] = population[r1][j] + F * (population[r2][j] - population[r3][j]);
        }

        for (int j = 0; j < dimensions; j++) {
            if (random(1) < CR || j == int(random(dimensions))) {
                trial[j] = mutant[j];
            } else {
                trial[j] = population[i][j];
            }
        }

        if (evaluationFunction(objectiveFunction(trial, benchmark)) < evaluationFunction(objectiveFunction(population[i], benchmark))) {
            newPopulation[i] = trial;
        } else {
            newPopulation[i] = population[i];
        }

        if (best == null || evaluationFunction(objectiveFunction(newPopulation[i], benchmark)) > evaluationFunction(objectiveFunction(best, benchmark))) {
            best = newPopulation[i];
        }
    }
    
    population = newPopulation;
}