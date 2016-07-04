class BillsController < ApplicationController
  include ApplicationHelper

  def upvote
    @bill = Bill.find_by slug: params[:slug]

    @upvoted = false
    return if bill_upvoted?(@bill)
    if @bill.present?
      @bill.upvotes_count += 1
      if @bill.save
        @upvoted = true
        bill_mark_upvoted(@bill)
      end
    end
  end
end
