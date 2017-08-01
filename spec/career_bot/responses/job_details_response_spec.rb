describe JobDetailsResponse do
  let(:requirements_payload) { 'requirements|AF3C224021' }
  let(:benefits_payload) { 'benefits|AF3C224021' }
  let(:apply_payload) { 'apply|AF3C224021' }
  let(:position) { 'Senior Ruby Developer' }
  let(:sender_id) { '123123' }
  let(:job_requirements_response_messages) do
    [I18n.t('text_messages.job_requirements_info', position: 'Senior Ruby Developer', location: 'Warsaw'),
     '- Focus on clean, SOLID code', '- Attention to detail',
     '- A knack for finding simple solutions to complex issues',
     '- Being skilled in software engineering',
     '- Proven track record of using Rails in commercial projects',
     I18n.t('text_messages.apply_for_job', job_url: 'https://elpassion.workable.com/jobs/51167',
            position: position, location: 'Warsaw')]
  end
  let(:job_benefits_response_messages) do
    [I18n.t('text_messages.job_benefits_info'),
     '- We offer clear and fair compensation system based entirely on thorough assessment of your skills. ',
     '- Salary range 10000 - 14600 PLN net', '- IDE license, if you want one - you can choose your own editor',
     '- You decide which technology will be most appropriate for your project. Want to try something new? - Great, we love to experiment!',
     '- We practice TDD, write unit and functional tests; CI, CD, pair programming',
     I18n.t('text_messages.apply_for_job', job_url: 'https://elpassion.workable.com/jobs/51167',
            position: position, location: 'Warsaw')]
  end

  let(:job_apply_response_message) { [] }

  before do
    create(:conversation, messenger_id: sender_id )
    allow_any_instance_of(ApplyResponder).to receive(:response).and_return(nil)
  end

  context 'when requirements payload given' do
    let(:messages) { described_class.new(requirements_payload).messages }

    it 'has proper data structure' do
      expect(messages).to eq(job_requirements_response_messages)
    end
  end

  context 'when benefits payload given' do
    let(:messages) { described_class.new(benefits_payload).messages }

    it 'has proper data structure' do
      expect(messages).to eq(job_benefits_response_messages)
    end
  end

  context 'when apply payload given' do
    let(:messages) { described_class.new(apply_payload, sender_id).messages }

    it 'has proper data structure' do
      expect(messages).to eq(job_apply_response_message)
    end
  end
end
