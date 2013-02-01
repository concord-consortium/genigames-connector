module GenigamesConnector
  class Learner
    def self.process_bucket_content(content)
      json = JSON.parse(content.body) rescue {}
      return unless json && json["task"]
      learner = content.bucket_logger.learner
      runnable = learner.offering.runnable
      return unless runnable.is_a?(ExternalActivity)
      template = runnable.template
      return if template.nil?
      json["task"].each do |task, data|
        page = template.pages.detect{|p| p.name == task}
        next unless page
        score_or = page.open_responses.detect{|o| o.name == "Score" }
        completion_mc = page.multiple_choices.detect{|mc| mc.name == "Completion" }

        process_completion(completion_mc, learner, data["completed"]) unless data["completed"].nil?
        process_score(score_or, learner, data["reputationEarned"].to_s) unless data["reputationEarned"].nil?
      end
    end

    private

    def self.process_score(open_response, learner, answer)
      saveable_open_response = ::Saveable::OpenResponse.find_or_create_by_learner_id_and_offering_id_and_open_response_id(learner.id, learner.offering.id, open_response.id)
      if saveable_open_response.response_count == 0 || saveable_open_response.answers.last.answer != answer
        saveable_open_response.answers.create(:answer => answer)
      end
    end

    def self.process_completion(multiple_choice, learner, completed)
      if completed
        saveable = ::Saveable::MultipleChoice.find_or_create_by_learner_id_and_offering_id_and_multiple_choice_id(learner.id, learner.offering.id, multiple_choice.id)
        choice = multiple_choice.choices.detect{|c| c.choice == "Completed"}
        if saveable.answers.empty? || saveable.answers.last.choice_id != choice.id
          saveable.answers.create(:choice => choice)
        end
      end
    end
  end
end
