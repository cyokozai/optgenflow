int[] trialCounter;

int roulleteSelection(float[] cum_probs) {
    float r = random(1.0);
    int i = 0;
    
    while (i < cum_probs.length - 1 && r > cum_probs[i]) {
        i++;
    }
    
    return i;
}

float[][] employedBees(float[][] flowers) {
    float[][] newFlowers = new float[N][dimensions];
    float[]   newFlower  = new float[dimensions];
    int k = 0;
    
    for (int i = 0; i < N; i++) {
        newFlower = new float[dimensions];
        
        for (int j = 0; j < dimensions; j++) {      
            do {
                k = int(random(N));
            } while (k == i);
            
            newFlower[j] = flowers[i][j] + (flowers[i][j] - flowers[k][j]) * (random(1.0) * 2.0 - 1.0);
            
            if (evaluationFunction(objectiveFunction(newFlower, benchmark)) > evaluationFunction(objectiveFunction(flowers[i], benchmark))) {
                newFlowers[i] = newFlower;

                trialCounter[i] = 0;
            } else {
                newFlowers[i] = flowers[i];

                trialCounter[i]++;
            }
            
            if (best == null || evaluationFunction(objectiveFunction(newFlowers[i], benchmark)) > evaluationFunction(objectiveFunction(best, benchmark))) {
                best = newFlowers[i];
            }
        }
    }
    
    return newFlowers;
}

float[][] onlookerBees(float[][] flowers) {
    float[][] newFlowers = new float[N][dimensions];
    float[]   newFlower  = new float[dimensions];
    float[]   cumFlower  = new float[dimensions];
    float[]   cumP       = new float[N];
    float     sumFitness = 0;
    int k = 0;
    
    for (int i = 0; i < N; i++) {
        sumFitness += evaluationFunction(objectiveFunction(flowers[i], benchmark));
    }

    for (int i = 0; i < N; i++) {
        cumP[i] = evaluationFunction(objectiveFunction(flowers[i], benchmark)) / sumFitness;
        if (i > 0) {
            cumP[i] += cumP[i - 1];
        }
    }

    for (int i = 0; i < N; i++) {
        cumFlower = flowers[roulleteSelection(cumP)];
        newFlower = new float[dimensions];
        
        for (int j = 0; j < dimensions; j++) {
            do {
                k = int(random(N));
            } while (k == i);
            
            newFlower[j] = cumFlower[j] + (cumFlower[j] - flowers[k][j]) * (random(1.0) * 2.0 - 1.0);
            
            if (evaluationFunction(objectiveFunction(newFlower, benchmark)) > evaluationFunction(objectiveFunction(cumFlower, benchmark))) {
                newFlowers[i] = newFlower;

                trialCounter[i] = 0;
            } else {
                newFlowers[i] = cumFlower;

                trialCounter[i]++;
            }
            
            if (best == null || evaluationFunction(objectiveFunction(newFlowers[i], benchmark)) > evaluationFunction(objectiveFunction(best, benchmark))) {
                best = newFlowers[i];
            }
        }
    }

    return newFlowers;
}

float[][] scoutBees(float[][] flowers) {
    if (max(trialCounter) > TC_LIMIT) {
        for (int i = 0; i < N; i++) {
            if (trialCounter[i] > TC_LIMIT) {
                flowers[i] = new float[dimensions];
                
                for (int j = 0; j < dimensions; j++) {
                    flowers[i][j] = random(LOW, UPP);
                }
                
                trialCounter[i] = 0;
            }
        }
    }

    return flowers;
}

void artificialBeeColony() {
    float[][] newPopulation = new float[N][dimensions];
    
    newPopulation = employedBees(population);
    newPopulation = onlookerBees(newPopulation);
    newPopulation = scoutBees(newPopulation);

    population = newPopulation;
}