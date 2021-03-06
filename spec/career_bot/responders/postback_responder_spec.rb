describe PostbackResponder do
  let(:sender_id) { '123123123' }
  let(:job_requirements_response_messages) do
    [{ text: I18n.t('text_messages.job_requirements_info', position: 'Ruby Developer', location: 'Warsaw') },
     { text: '- Focus on clean, readable code' },
     { text: '- Attention to detail' },
     { text: '- Insistence on adhering to good programming practices' },
     { text: '- Having worked on least one commercial project in Rails' },
     { text: '- Being familiar with SQL beyond ActiveRecord ' },
     { text: I18n.t('text_messages.apply_for_job', job_url: 'https://elpassion.workable.com/jobs/636000',
                   position: 'Ruby Developer', location: 'Warsaw',
                   application_url: 'https://elpassion.workable.com/jobs/636000/candidates/new') }]
  end

  let(:job_benefits_response_messages) do
    [{ text: I18n.t('text_messages.job_benefits_info') },
     { text: '- We offer clear and fair compensation system based entirely on a thorough assessment of your skills' },
     { text: '- Salary range 5800 - 10200 PLN net ' },
     { text: "- Choose your prefered editor. Get an IDE license, if you'd want one" },
     { text: '- You decide which technology will be most appropriate for your project. Want to try something new? - Great, we love to experiment!' },
     { text: '- We practice TDD, write unit and functional tests; CI, CD, pair programming' },
     { text: I18n.t('text_messages.apply_for_job', job_url: 'https://elpassion.workable.com/jobs/636000',
                    position: 'Ruby Developer', location: 'Warsaw',
                    application_url: 'https://elpassion.workable.com/jobs/636000/candidates/new') }]
  end

  let(:what_we_do_message) do
    [{ attachment: { type: 'image', payload: { url: 'https://media.giphy.com/media/l3q2Chwola4nfdNra/source.gif' } } },
     { text: "In EL Passion we create cool stuff, we use many fancy technologies! "\
      "We design and develop stunning native mobile apps for iOS (iPhone, iPad) and Android. "\
      "Our team builds high performance apps using optimal coding and best programming practices.\n"},
     { text: "Using modern technologies and Agile principles, we deliver web and mobile apps with "\
      "uncompromising quality.\n" },
     { text:"Our UI & UX Design Team bridges the distance between the human brain "\
      "and the digital product in every project!\n" },
     { text: "Wanna see more? Check out our website! http://www.elpassion.com/projects/. "\
       "Looking for a job? Type things you are good at and I will show you what we got! :) "\
       "We can also talk about (almost) anything you want! :)\n" }]
  end

  let(:company_message) do
    [{ attachment: { type: 'image', payload: { url: 'https://media.giphy.com/media/l3q2FwrtK2lURaeeA/source.gif' } } },
     { text: "We are EL Passion - Warsaw based software house with years of experience. "\
      "You can see our office location here: https://goo.gl/km42Fj.\n" },
     { text: "And here are useful links! Our website: http://www.elpassion.com/, "\
      "Facebook: https://www.facebook.com/elpassion, Dribbble: https://dribbble.com/elpassion "\
      "and our Blog: https://blog.elpassion.com/. Feel invited to check them out! :)\n" },
     { text: "Would you like to do something else now? Play a game? See main menu? Anything? :D" }]
  end

  before do
    VCR.use_cassette 'active_jobs' do
      Net::HTTP.get_response(URI('https://www.workable.com/spi/v3/accounts/elpassion/jobs?state=published'))
      WorkableService.new.set_jobs
    end
  end

  it 'handles WELCOME_PAYLOAD postback' do
    postback = MockPostback.new('WELCOME_PAYLOAD')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq([{ attachment: I18n.t('WELCOME_PAYLOAD', locale: :responses).first }])
  end

  it 'handles JOB_OFFERS postback' do
    postback = MockPostback.new('JOB_OFFERS')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq([{ text: I18n.t('JOB_OFFERS', locale: :responses).first }])
  end

  it 'handles ABOUT_US postback' do
    postback = MockPostback.new('ABOUT_US')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq([{ attachment: I18n.t('ABOUT_US', locale: :responses).first }])
  end

  it 'handles WHAT_WE_DO postback' do
    postback = MockPostback.new('WHAT_WE_DO')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq(what_we_do_message)
  end

  it 'handles COMPANY postback' do
    postback = MockPostback.new('COMPANY')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq(company_message)
  end

  it 'handles PEOPLE postback' do
    postback = MockPostback.new('PEOPLE')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq([{ text: I18n.t('PEOPLE', locale: :responses).first }])
  end

  it 'handles benefits postback' do
    postback = MockPostback.new('benefits|50E5C4179C')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq(job_benefits_response_messages)
  end

  it 'handles requirements postback' do
    postback = MockPostback.new('requirements|50E5C4179C')
    described_class.new(postback, PostbackResponse.new.message(postback.quick_reply, sender_id)).send
    expect(postback.sent_messages).to eq(job_requirements_response_messages)
  end
end
