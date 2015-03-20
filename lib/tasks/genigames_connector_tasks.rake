namespace :genigames do
  desc "Set up the reporting template for Genigames"
  task :setup_template => :environment do
    puts "Creating Genigames Report Template..."
    towns = {
      "Lullen"  => 8,
      "Angeral" => 8,
      "Tarrin's Crag" => 8,
      "Narran" => 6,
      "Luxceros" => 6
    }

    inv = Investigation.create({"user_id"=>1, "name"=>"Genigames Report Template", "description"=>"The report template for Genigames", "teacher_only"=>false, "publication_status"=>"draft"})
    num = 1
    towns.each do |town, count|
      act = Activity.create({"user_id"=>1, "name"=>town,        "description"=>"", "investigation_id"=>inv.id, "position"=>num, "teacher_only"=>false, "publication_status"=>"draft"})
      s = Section.create({"user_id"=>1, "activity_id"=>act.id, "name"=>town,        "description"=>"", "position"=>1, "teacher_only"=>false, "publication_status"=>"draft"})

      count.times do |i|
        p = Page.create({"user_id"=>1, "section_id"=>s.id, "name"=>"#{town} Task #{i+1}", "description"=>"", "position"=>i+1, "teacher_only"=>false, "publication_status"=>"draft", "offerings_count"=>0})

        e1 = Embeddable::MultipleChoice.create({"user_id"=>1, "name"=>"Completion", "description"=>"", "prompt"=>"Completion", "enable_rationale"=>false, "rationale_prompt"=>nil, "allow_multiple_selection"=>false})
        c1 = Embeddable::MultipleChoiceChoice.create({"choice"=>"Completed", "multiple_choice_id"=>e1.id, "is_correct"=>true})

        e2 = Embeddable::OpenResponse.create({"user_id"=>1,"name"=>"Score", "description"=>"", "prompt"=>"Score", "default_response"=>"", "rows"=>5, "columns"=>32, "font_size"=>12})

        pe1 = PageElement.create({"page_id"=>p.id, "embeddable_id"=>e1.id, "embeddable_type"=>"Embeddable::MultipleChoice", "position"=>1, "user_id"=>1})
        pe2 = PageElement.create({"page_id"=>p.id, "embeddable_id"=>e2.id, "embeddable_type"=>"Embeddable::OpenResponse",   "position"=>2, "user_id"=>1})
      end

      num += 1
    end

    puts "Done.\n\nDon't forget to set the 'template' attribute on the appropriate ExternalActivity!"
  end
end
