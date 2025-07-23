package com.fitness.cse;

public class BMI {
    public static String calculateBMI(int age, double height, double weight) {
        // Check if the height is realistic
        if (height <= 0 || weight <= 0) {
            return "Invalid input. Height and weight must be positive numbers.";
        }

        // Convert height from cm to meters
        double heightInMeters = height / 100;

        // Calculate BMI
        double bmi = weight / (heightInMeters * heightInMeters);

        // Determine the BMI category
        String category = "";
        if (bmi < 18.5) {
            category = "Underweight";
        } else if (bmi >= 18.5 && bmi < 24.9) {
            category = "Normal weight";
        } else if (bmi >= 25 && bmi < 29.9) {
            category = "Overweight";
        } else {
            category = "Obese";
        }

        // Return BMI details without diet and workout tips
        return String.format("BMI: %.2f\nCategory: %s", bmi, category);
    }
    
    
    public static double onlyBMI(int age, double height, double weight) {
        // Check if the height is realistic
        if (height <= 0 || weight <= 0) {
            return 0.0;
        }

        // Convert height from cm to meters
        double heightInMeters = height / 100;

        // Calculate BMI
        double bmi = weight / (heightInMeters * heightInMeters);

       return bmi;
    }
}
