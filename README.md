# My Fitness Pal

Welcome to My Fitness Pal, a comprehensive fitness tracking application designed to help users monitor their health and fitness goals effectively. With features ranging from BMR and AMR calculations to detailed exercise and consumption history, My Fitness Pal aims to provide a holistic view of your fitness journey.

## Features

- **BMR and AMR Calculator**: Calculate your Basal Metabolic Rate (BMR) and Active Metabolic Rate (AMR) to understand how many calories your body needs at rest and during activity.
- **Visualized Macros and Calorie Consumption**: Get insights into your macro intake and calorie consumption through intuitive visualizations.
- **Exercise Tracker**: Log and track your exercises, including type, duration, and intensity.
- **Consumption and Exercise History**: Keep a detailed record of your food intake and physical activities over time.

## API References

My Fitness Pal leverages external APIs for enhanced functionality:

- [Nutritionix](https://www.nutritionix.com/business/api): For detailed nutritional information about various foods.
- [Calorie Ninja](https://www.calorieninja.com/api): To estimate calorie content in meals based on user input.

## Getting Started

To get started with My Fitness Pal, follow these steps after cloning the repository:

1. Install dependencies by running:




```bash
  bundle install
```

2. Create the database:

```bash
  rails db:create
```

3. Run migrations to set up the database schema:

```bash
  rails db:migrate
```


## Styling

The styling for "My Fitness Pal" is powered by [Bootstrap](https://getbootstrap.com/).



## Gem Dependencies Explanation

This project utilizes several Ruby gems to provide essential functionalities and streamline the development process. Below is an overview of these gems and their roles:

### Core Functionality Gems

- **`devise`**: Authentication ang generation of the user model.

- **`rest-client`**: Simplifies HTTP requests to external services, enabling interaction with RESTful APIs for fetching or sending data.

- **`dotenv`**: Manages environment variables through a `.env` file.

- **`rails_charts`**: Integrates charting capabilities into Rails applications.

- **`bootstrap`, `~> 4.3.1`**: Incorporates the Bootstrap framework for responsive, mobile-first front-end web development, enhancing the user interface with pre-designed components.

- **`jquery-rails`**: Facilitates the use of jQuery to enable interactive elements on the webpage.

### Development and Testing Gems

Included under the `:development` and `:test` groups, these gems are used exclusively in non-production environments.

- **`rspec-rails`**

- **`shoulda`**

## Authors

- [@lbmartinez2](https://github.com/lbmartinez2)
- [@Anst09](https://github.com/Anst09)

