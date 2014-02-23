class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  /def self.order_by order
    if order == 'desc'
      Movie.order(title: :desc)
    else
      Movie.order(title: :asc)
    end
  end/
end
