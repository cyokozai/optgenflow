float[][] crossover(float[] parent1, float[] parent2) {
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

float[][] selection(float[][] population, int eliteCount) {
    float[][] elite = new float[eliteCount][dimensions];
    float[] fitness = new float[N];

    for (int i = 0; i < N; i++) {
        fitness[i] = evaluationFunction(objectiveFunction(population[i], benchmark));
    }

    for (int i = 0; i < eliteCount; i++) {
        int bestIndex = 0;

        for (int j = 1; j < N; j++) {
            if (fitness[j] > fitness[bestIndex]) {
                bestIndex = j;
            }
        }

        elite[i] = population[bestIndex].clone();
        fitness[bestIndex] = -Float.MAX_VALUE;
    }

    return elite;
}

void mutate(float[] individual) {
    for (int i = 0; i < dimensions; i++) {
        if (random(1) < MUTATION_RATE) {
            individual[i] = random(LOW, UPP);
        }
    }
}

void geneticAlgorithm() {
    int eliteCount = int(ELITE_RATE * N);
    float[][] newPopulation = new float[N][dimensions];

    // エリート選択
    float[][] elite = selection(population, eliteCount);

    for (int i = 0; i < eliteCount; i++) {
        newPopulation[i] = elite[i];
    }

    // 交叉と突然変異
    for (int i = eliteCount; i < N; i += 2) {
        int parent1Index = 0;
        int parent2Index = 0;

        while (parent1Index == parent2Index) {
            parent1Index = int(random(N));
            parent2Index = int(random(N));
        }
        
        float[][] children = crossover(population[parent1Index], population[parent2Index]);

        mutate(children[0]);
        mutate(children[1]);

        if (evaluationFunction(objectiveFunction(children[0], benchmark)) > evaluationFunction(objectiveFunction(population[i], benchmark))) {
            newPopulation[i] = children[0];
        } else {
            newPopulation[i] = population[i];
        }
        
        if (i + 1 < N) {
            if (evaluationFunction(objectiveFunction(children[1], benchmark)) > evaluationFunction(objectiveFunction(population[i + 1], benchmark))) {
                newPopulation[i + 1] = children[1];
            } else {
                newPopulation[i + 1] = population[i + 1];
            }
        }

        if (best == null || evaluationFunction(objectiveFunction(newPopulation[i], benchmark)) > evaluationFunction(objectiveFunction(best, benchmark))) {
            best = newPopulation[i];
        }
    }
    
    population = newPopulation;
}
