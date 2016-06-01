class Bill < ActiveRecord::Base

  MINIMUM_WAGE = 'minimum_wage'
  RENT_CEILING = 'rent_ceiling'
  DATE_VIOLENCE = 'date_violence'
  GMO_MARK = 'gmo_mark'

  def self.rent_ceiling
    find_by(slug: Bill::RENT_CEILING)
  end

  def self.minimun_wage
    find_by(slug: Bill::MINIMUM_WAGE)
  end

  def self.date_violence
    find_by(slug: Bill::DATE_VIOLENCE)
  end

  def self.gmo_mark
    find_by(slug: Bill::GMO_MARK)
  end

end
