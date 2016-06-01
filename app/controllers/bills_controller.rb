class BillsController < ApplicationController
  include ApplicationHelper

  def upvote
    @bill = Bill.find_by slug: params[:slug]

    return if upvoted?(@bill)
    if @bill.present?
      @bill.upvotes_count += 1
      if @bill.save
        mark_upvoted(@bill)
      end
    end
  end
end
