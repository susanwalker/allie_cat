RSpec.describe UserInputProcessor do
  describe 'X_SPEED' do
    it 'returns the X_SPEED' do
      expect(UserInputProcessor::X_SPEED).to eq(2)
    end
  end

  describe 'Y_SPEED' do
    it 'returns the Y_SPEED' do
      expect(UserInputProcessor::Y_SPEED).to eq(1)
    end
  end

  describe '#process_input' do
    let!(:cat) do
      Cat.new(0, 0)
    end

    let!(:maze) do
      Maze.new(100, 100, cat, treats, walls)
    end

    context 'when there are no treats and walls' do
      let!(:treats) do
        []
      end

      let!(:walls) do
        []
      end

      let!(:user_input_processor) do
        UserInputProcessor.new(input, maze)
      end

      context 'when A is the input' do
        let!(:input) { 'A' }

        it 'does not update cat position because it cannot go further up' do
          expect(cat.y).to eq(0)
          user_input_processor.process_input
          expect(cat.y).to eq(0)
        end
      end

      context 'when B is the input' do
        let!(:input) { 'B' }

        it 'updates cat position one down' do
          expect(cat.y).to eq(0)
          user_input_processor.process_input
          expect(cat.y).to eq(1)
        end
      end

      context 'when D is the input' do
        let!(:input) { 'D' }

        it 'does not update cat position because it cannot go further left' do
          expect(cat.x).to eq(0)
          user_input_processor.process_input
          expect(cat.x).to eq(0)
        end
      end

      context 'when C is the input' do
        let!(:input) { 'C' }

        it 'updates cat position one right' do
          expect(cat.x).to eq(0)
          user_input_processor.process_input
          expect(cat.x).to eq(2)
        end
      end
    end

    context 'when there are treats and walls' do
      let!(:treats) do
        [Treat.new(2, 0)]
      end

      let!(:walls) do
        [Wall.new(2, 2, 0, 1)]
      end

      let!(:user_input_processor) do
        UserInputProcessor.new(input, maze)
      end

      context 'when B is the input' do
        let!(:input) { 'B' }

        it 'does not update cat position because of the wall below' do
          expect(cat.y).to eq(0)
          user_input_processor.process_input
          expect(cat.y).to eq(0)
        end
      end

      context 'when C is the input' do
        let!(:input) { 'C' }

        it 'updates cat position one right and removes the treat' do
          expect(cat.x).to eq(0)
          expect(treats.size).to eq(1)
          user_input_processor.process_input
          expect(cat.x).to eq(2)
          expect(treats.size).to eq(0)
        end
      end
    end
  end
end
