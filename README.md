# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise


## Approach

Persistence: To persist user answers across runs, I used the pstore gem. Each run's answers are stored in a PStore file (tendable.pstore).

User Input: Users are prompted to answer each question with "Yes" or "No". The input is case-insensitive and validated to ensure it meets the required format.

Rating Calculation: After each run, the program calculates a rating for that run based on the number of "Yes" answers provided by the user. The rating is calculated as 100 * number of yes answers / number of questions.

Average Rating: The program also calculates an average rating for all runs. It accumulates the total number of "Yes" answers across all runs and divides it by the total number of questions multiplied by the number of runs.

## Implementation Details

The do_prompt method prompts the user for answers to each question, validates the input, and stores the answers in the PStore file.

The do_report method calculates ratings for each run and prints them. It also calculates and prints the average rating for all runs.

User input is validated to ensure it's either "Yes" or "No". If an invalid input is provided, the user is prompted again until a valid input is received.

## Running the Application

Ensure you have Ruby installed on your system.

Clone this repository to your local machine.

Install the pstore gem by running bundle install.

Run the application using ruby questionnaire.rb.


