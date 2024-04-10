require_relative 'questionnaire' # Assuming the code is in a file named 'questionnaire.rb'

describe 'Survey Application' do
  let(:test_answers) do
    [
      {"q1" => "yes", "q2" => "no", "q3" => "yes", "q4" => "no", "q5" => "yes"}, # One run with mixed answers
      {"q1" => "yes", "q2" => "yes", "q3" => "yes", "q4" => "yes", "q5" => "yes"}, # Another run with all yes answers
    ]
  end

  before(:each) do
    @store_name = "test_store.pstore" # Use a different store name for testing
    File.delete(@store_name) if File.exist?(@store_name) # Remove the store file if exists
  end

  describe '#do_prompt' do
    it 'prompts the user for answers and stores them in the store file' do
      allow_any_instance_of(Object).to receive(:gets).and_return("yes\n", "no\n", "yes\n", "no\n", "yes\n") # Stub user input

      do_prompt

      store = PStore.new(@store_name)
      store.transaction(true) do
        expect(store[:answers].size).to eq(1) # Expect only one set of answers
        expect(store[:answers][0].size).to eq(5) # Expect all questions to be answered
      end
    end
  end

  describe '#do_report' do
    it 'calculates and prints ratings for each run' do
      store = PStore.new(@store_name)
      store.transaction do
        store[:answers] = test_answers
      end

      expect { do_report }.to output.to_stdout.and include("Rating for Run 1", "Rating for Run 2")
    end

    it 'calculates and prints average rating for all runs' do
      store = PStore.new(@store_name)
      store.transaction do
        store[:answers] = test_answers
      end

      expect { do_report }.to output.to_stdout.and include("Average Rating for All Runs")
    end
  end
end
