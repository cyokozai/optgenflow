String version = "1.0.0";

import controlP5.*;
import gifAnimation.*;

ControlP5 cp5;
boolean startOptimization = false;

GifMaker gif;
int fc;
boolean movie = false;

float[][] population; // population
float[] best;         // best individual
float UPP = 0.0;      // upper
float LOW = 0.0;      // lower
int generation = 0;

void setup() {
    size(800, 800);

    PFont font = createFont("Zen Kaku Gothic New", 18);
    cp5 = new ControlP5(this);
    cp5.setFont(font);
    cp5.setColorBackground(color(0, 158, 255));

    cp5.addTextfield("How many individuals?")
       .setPosition(20, 20)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(N));

    cp5.addTextfield("Dimensions")
       .setPosition(20, 90)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(dimensions));

    cp5.addTextfield("Which benchmark function? \n (SPHERE, ROSENBROCK, RASTRIGIN)")
       .setPosition(20, 160)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(benchmark);

    cp5.addTextfield("Which optimization method? \n (GA, DE, ABC)")
       .setPosition(20, 250)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(method);

    cp5.addTextfield("The number of maximum generations")
       .setPosition(20, 340)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(MAX_GENERATION));

    cp5.addTextfield("GA: The rate of elite selection")
       .setPosition(20, 410)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(ELITE_RATE));

    cp5.addTextfield("GA: The rate of mutation")
       .setPosition(20, 480)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(MUTATION_RATE));

    cp5.addTextfield("DE: The scaling factor (F)")
       .setPosition(20, 550)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(F));

    cp5.addTextfield("DE: The crossover rate (CR)")
       .setPosition(20, 620)
       .setSize(200, 40)
       .setAutoClear(false)
       .setText(str(CR));

    cp5.addButton("start")
       .setPosition(20, 690)
       .setSize(200, 40)
       .setColorBackground(color(30, 220, 80))
       .onClick(new CallbackListener() {
           public void controlEvent(CallbackEvent event) {
                startOptimization = true;
                generation = 0;
                initializePopulation();
                cp5.hide();
           }
       });

    cp5.addCheckBox("recordGif")
       .setPosition(620, 760)
       .setSize(20, 20)
       .setItemsPerRow(1)
       .setSpacingColumn(50)
       .addItem("Record GIF", 0);

    println("OptGenFlow " + version);
    println("Configure the settings and press 'start' to begin optimization.");

    frameRate(50);
}

void draw() {
    if (!startOptimization) {
        return;
    } else {
        generation++;
    }

    if (generation == 1 && movie == true) {
        gif = new GifMaker(this, "./image/" + benchmark + "_" + method + ".gif");
        fc  = frameCount;
        gif.setRepeat(0);
        gif.setQuality(10);
        gif.setDelay(40);
    }

    background(255);
    noStroke();
    drawBenchmarkContours(benchmark, LOW, UPP, LOW, UPP, 1000, 1000);

    println("Generation: " + generation);
    fill(255);
    textSize(24);
    textAlign(LEFT);
    text("Generation: " + generation, 40, height - 20);

    for (int i = 0; i < N; i++) {
        float[] position = population[i];
        float fitness = evaluationFunction(objectiveFunction(position, benchmark));

        float x = map(position[0], LOW, UPP, 0, width);
        float y = map(position[1], LOW, UPP, height, 0);
        ellipse(x, y, 10, 10);

        fill(0);
        textSize(14);
        textAlign(CENTER);
        text(nf(fitness, 0, 4), x, y - 10);
    }

    // ベンチマークの最小値の座標に☆マークを表示
    float minX = 0;
    float minY = 0;
    if (benchmark.equals("SPHERE") || benchmark.equals("RASTRIGIN")) {
        minX = 0;
        minY = 0;
    } else if (benchmark.equals("ROSENBROCK")) {
        minX = 1;
        minY = 1;
    }
    float starX = map(minX, LOW, UPP, 0, width);
    float starY = map(minY, LOW, UPP, height, 0);
    fill(255, 215, 0);
    textSize(18);
    textAlign(CENTER);
    text("☆", starX, starY + 5);
    textSize(14);
    text("x: " + nf(minX, 0, 2) + ", y: " + nf(minY, 0, 2), starX, starY + 20);

    if (generation < MAX_GENERATION) {
        if (movie == true) {
            gif.addFrame();
        }

        evolvePopulation();

        println("Best individual: [" + nf(best[0], 0, 4) + ", " + nf(best[1], 0, 4) + "]");
        println("Best fitness: " + evaluationFunction(objectiveFunction(best, benchmark)));
    } else {
        startOptimization = false;

        if (movie == true) {
            gif.finish();
            movie = false;

            println("Saved gif");
        }

        println("\nOptimization finished");
        println("Best individual: [" + nf(best[0], 0, 4) + ", " + nf(best[1], 0, 4) + "]");
        println("Best fitness: " + evaluationFunction(objectiveFunction(best, benchmark)));

        cp5.show();

        cp5.addTextfield("Best individual")
           .setPosition(580, 20)
           .setSize(200, 40)
           .setAutoClear(false)
           .setText("[" + nf(best[0], 0, 4) + ", " + nf(best[1], 0, 4) + "]")
           .setColor(color(0, 0, 0))
           .setColorBackground(color(255, 190, 0));
        
        cp5.addTextfield("Best fitness")
           .setPosition(580, 100)
           .setSize(200, 40)
           .setAutoClear(false)
           .setText(str(evaluationFunction(objectiveFunction(best, benchmark))))
           .setColor(color(0, 0, 0))
           .setColorBackground(color(255, 190, 0));
    }

    delay(50);
}

void mousePressed() {
    if (mouseX > 20 && mouseX < 40 && mouseY > 760 && mouseY < 780) {
        movie = !movie;
        println("Movie recording: " + movie);
    }
}

void initializePopulation() {
    N              = int(cp5.get(Textfield.class, "How many individuals?").getText());
    dimensions     = int(cp5.get(Textfield.class, "Dimensions").getText());
    benchmark      = cp5.get(Textfield.class, "Which benchmark function? \n (SPHERE, ROSENBROCK, RASTRIGIN)").getText();
    method         = cp5.get(Textfield.class, "Which optimization method? \n (GA, DE, ABC)").getText();
    MAX_GENERATION = int(cp5.get(Textfield.class, "The number of maximum generations").getText());
    ELITE_RATE     = float(cp5.get(Textfield.class, "GA: The rate of elite selection").getText());
    MUTATION_RATE  = float(cp5.get(Textfield.class, "GA: The rate of mutation").getText());
    F              = float(cp5.get(Textfield.class, "DE: The scaling factor (F)").getText());
    CR             = float(cp5.get(Textfield.class, "DE: The crossover rate (CR)").getText());
    
    population = new float[N][dimensions];
    best       = new float[dimensions];

    if (benchmark.equals("SPHERE")) {
        UPP =  5.0;
        LOW = -5.0;
    } else if (benchmark.equals("ROSENBROCK")) {
        UPP =  2.0;
        LOW = -2.0;
    } else if (benchmark.equals("RASTRIGIN")) {
        UPP =  5.12;
        LOW = -5.12;
    } else {
        println("Unknown benchmark type: " + benchmark);
        exit();
    }

    if (method.equals("ABC")) {
        trialCounter = new int[N];

        for (int i = 0; i < N; i++) {
            trialCounter[i] = 0;
        }
    }
    
    for (int i = 0; i < N; i++) {
        for (int d = 0; d < dimensions; d++) {
            population[i][d] = random(LOW, UPP);
        }
    }

    best = population[0].clone();

    if (cp5.get(CheckBox.class, "recordGif").getState(0)) {
        movie = true;
        gif = new GifMaker(this, "./image/" + benchmark + "_" + method + ".gif");
        gif.setRepeat(0);
        gif.setQuality(10);
        gif.setDelay(20);
    }

    println("Start optimization with " + method + " method");
}

void evolvePopulation() {
    if (method.equals("GA")) {
        geneticAlgorithm();
    } else if (method.equals("DE")) {
        differentialEvolution();
    } else if (method.equals("ABC")) {
        artificialBeeColony();
    } else {
        println("Unknown method: " + method);
        exit();
    }
}