class PartyNamesController < ApplicationController
  include ApplicationHelper

  def upvote
    @party_name = PartyName.find_by slug: params[:slug]

    @party_name_upvoted = false
    return if party_name_upvoted?
    if @party_name.present?
      @party_name.upvotes_count += 1
      if @party_name.save
        @party_name_upvoted = true
        party_name_mark_upvoted(@party_name)
      end
    end
  end
end

