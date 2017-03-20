class JobDetailsResponder < BotResponder
  def initialize(session_uid:, details:, **options)
    @session_uid = session_uid
    @details = details
    super(**options)
  end

  def response
    if no_job_codes?
      no_available_jobs_response
    elsif job_codes.length == 1
      one_available_job_response
    else
      show_quick_responses
    end
  end

  private

  attr_reader :session_uid, :details

  def show_quick_responses
    bot_deliver(
      {
        text: I18n.t('text_messages.which_offer'),
        quick_replies: quick_replies
      }
    )
  end

  def quick_replies
    job_codes.map do |code|
      DetailsQuickResponse.new(code: code, details: details).reply
    end
  end

  def no_available_jobs_response
    bot_deliver({ text: I18n.t('text_messages.no_available_details') })
  end

  def one_available_job_response
    JobDetailsResponse.new(single_job_code).messages.each do |line|
      bot_deliver({ text: line })
    end
  end

  def no_job_codes?
    job_codes.empty?
  end

  def job_codes
    @job_codes ||= conversation_job_codes & active_job_codes
  end

  def conversation_job_codes
    conversation.job_codes ? conversation.job_codes.split(',') : []
  end

  def single_job_code
    @single_job_code = "#{details}|#{job_codes.first}"
  end

  def active_job_codes
    JobRepository.new.active_job_codes
  end
end