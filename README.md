```text
 _____         ______     _____              __________  ______
/\  __`\         __\ \__ /\  __`\              __/_\  _`\  \__ \
_ \ \/\ \   _____ \ \ ,_\\ \ \L\_\   ____     ___ __\ \L_  \//\ \      ___    __  __  __
__ \ \ \ \ /\ '__`\\ \ \/ \ \ \L_L  __'__`\ /' _ `\\ \  _\/  \ \ \    / __`\ /\ \/\ \/\ \
____\ \_\ \\ \ \L\ \\ \ \___ \ \/, \/\  __/ /\ \/\ \\ \ \/ ___\_\ \_ /\ \L\ \\ \ \_/ \_/ \
 ____\_____\\ \ ,__/ \ \__\___\____/\ \____\\ \_\ \_\\ \_\  ___\____\\ \____/__ \___^___/'
   ________/__ \ \/   \/__/_______/  \/____/ \/_/\/_/ \/_/    ______/ \/___/ __/___//__/
             ___\_\
               ___/
```

# OptGenFlow

## A Visual Tool for Understanding Genetic Algorithms  

**OptGenFlow** is an interactive and educational application specifically designed to help users visually understand the workings and mechanisms of genetic algorithms (GAs). 

![sphere-ga](./image/SPHERE_GA.gif)

---

#### **What Are Genetic Algorithms?**

Genetic algorithms are a type of optimization algorithm inspired by the principles of natural selection and evolution. They are commonly used to solve complex problems where traditional optimization methods may be inefficient or inapplicable. GAs work by iteratively evolving a population of candidate solutions toward an optimal result, using techniques such as selection, crossover, and mutation.  

---

#### **Features of OptGenFlow**  

1. **Step-by-Step Visualization**  
   - **Population Initialization**: Shows how an initial set of random solutions is generated.  
   - **Selection Process**: Illustrates how fitter solutions are chosen for reproduction based on objective fitness scores.  

2. **Real-Time Monitoring**  
   - Track the evolution of solutions over multiple generations with dynamic charts.  
   - Observe fitness improvement trends and convergence toward optimal solutions.  

3. **Interactive Experimentation**  
   - Adjust parameters such as population size, crossover rate, mutation rate, and fitness functions.  
   - Compare outcomes with different configurations to understand their impact on algorithm performance.  

---

#### **Who Is OptGenFlow For?**  

- **Students and Educators**: A powerful learning tool for computer science and engineering courses focused on evolutionary computing or optimization.  
- **Researchers**: A platform to experiment with genetic algorithm parameters and visualize outcomes for academic studies.  
- **Industry Professionals**: Useful for explaining GA-based solutions to stakeholders or exploring optimization tasks in fields like logistics, finance, and AI development.  

---

#### **Benefits of OptGenFlow**  

- **Hands-On Learning**: Experience how genetic algorithms evolve solutions without diving into complex coding.  
- **Deeper Understanding**: Visualize the relationship between algorithm parameters and performance.  
- **Problem-Solving Tool**: Experiment with real-world problems and gain insights into  optimization.  

---

### **Why OptGenFlow?**  

By transforming abstract algorithmic processes into clear, engaging visualizations, OptGenFlow makes the power of genetic algorithms accessible to a wider audience. Whether you’re seeking to understand the fundamentals or refine optimization strategies, OptGenFlow provides the tools and insights needed to master genetic algorithms effectively.

- Sphere function | Genetic Algorithm  
   ```math
   \displaystyle f\left(\boldsymbol{x}\right)  = \sum_{i=1}^{D} x_i^2  \quad
   [-5.12, 5.12], \quad f\left(0, \ldots, 0\right) = 0  
   ```
   ![sphere-ga](./image/SPHERE_GA.gif)  
- Rastrigin function | Artificial Bee Colony Algorithm  
   ```math
   \displaystyle f\left(\boldsymbol{x}\right)  = 10D + \sum_{i=1}^{D} \left[ x_i^2 - 10 \cos(2\pi x_i) \right]  \quad
   [-5.12, 5.12], \quad f\left(0, \ldots, 0\right) = 0  
   ```
   ![rastrigin-abc](./image/RASTRIGIN_ABC.gif)  
- Rosenbrock finction | Differential Evolution
   ```math  
   \displaystyle f\left(\boldsymbol{x}\right)  = \sum_{i=1}^{D-1} \left[ 100 (x_{i+1} - x_i^2)^2 + (1 - x_i)^2 \right]  \quad
   [-5.00, 5.00], \quad f\left(1, \ldots, 1\right) = 0  
   ```
   ![rosenbrock-de](./image/ROSENBROCK_DE.gif)  
