require "pstore" # https://github.com/ruby/pstore

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# TODO: FULLY IMPLEMENT
def do_prompt
  answers = {} # Hash to store answers
  store = PStore.new(STORE_NAME) # Create or load the store

  # Ask each question and get an answer from the user's input.
  QUESTIONS.each_key do |question_key|
    print QUESTIONS[question_key]
    ans = gets.chomp.downcase #gets user input and convert it to lowercase

    # Check if the answer is valid (Yes/No)
    while ans != "yes" && ans != "no" && ans != "y" && ans != "n"
      puts "Invalid answer. Please enter Yes or No."
      print QUESTIONS[question_key]
      ans = gets.chomp.downcase
    end

    answers[question_key] = ans # Store answer in hash
  end

  # Store answers in pstore
  store.transaction do
    store[:answers] ||= [] # Initialize answers array if not exists
    store[:answers] << answers # Append answers to array
  end
end

def do_report
  store = PStore.new(STORE_NAME) # Load store
  total_yes = 0
  total_questions = QUESTIONS.size
  
  # Calculate ratings for each run
  store.transaction(true) do
    runs = store[:answers].size # Number of runs
    
    store[:answers].each_with_index do |answers, index|
      yes_count = answers.values.count { |value| value.downcase == "yes" || value.downcase == "y" } # Count "yes" answers
      rating = (yes_count * 100.0) / total_questions # Calculate rating
      total_yes += yes_count # Accumulate total "yes" answers
      puts "Rating for Run #{index + 1}: #{rating}%"
    end
  end
  
  # Calculate and print average rating for all runs
  average_rating = (total_yes * 100.0) / (total_questions * store.transaction { store[:answers].size })
  puts "Average Rating for All Runs: #{average_rating}%"
end

do_prompt
do_report
