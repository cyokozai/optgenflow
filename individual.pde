class Individual {
    float x, y;

    Individual(float x, float y) {
        this.x = x;
        this.y = y;
    }

    void display() {
        fill(0, 100, 255);
        noStroke();
        ellipse(x, y, 10, 10);
    }
}
