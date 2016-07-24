class DebatesController < ApplicationController

  def choose_alpha
    choose_something('alpha')
  end

  def choose_beta
    choose_something('beta')
  end

  def choose_hold
    return if hold_chosen? params[:slug]

    @debate = Debate.find_by slug: params[:slug]
    @debate.alpha_count -= 1 if alpha_chosen? params[:slug]
    @debate.beta_count -= 1 if beta_chosen? params[:slug]

    save_choice(params[:slug], 'hold') if @debate.save
    @overall_adoption_debate = Debate.find_by slug: 'overall_adoption'
    @non_gmo_debate = Debate.find_by slug: 'non_gmo'
    @exemption_range_debate = Debate.find_by slug: 'exemption_range'
  end

  private

  def choose_something(choice)
    anti_choice = (choice == 'alpha' ? 'beta' : 'alpha')

    return if chosen? params[:slug], choice

    @debate = Debate.find_by slug: params[:slug]
    #@debate.alpha_count -= 1 if alpha_chosen? params[:slug]
    @debate.decrement("#{anti_choice}_count") if chosen? params[:slug], anti_choice
    @debate.increment("#{choice}_count")

    save_choice(params[:slug], choice) if @debate.save
    @overall_adoption_debate = Debate.find_by slug: 'overall_adoption'
    @non_gmo_debate = Debate.find_by slug: 'non_gmo'
    @exemption_range_debate = Debate.find_by slug: 'exemption_range'
  end
end
