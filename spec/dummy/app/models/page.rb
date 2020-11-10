class Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :section
  has_many :page_elements, :order => :position

  ["Embeddable::OpenResponse","Embeddable::MultipleChoice"].each do |klass|
    eval %!has_many :#{klass[/::(\w+)$/, 1].underscore.pluralize}, :class_name => '#{klass}',
:finder_sql => proc { "SELECT #{klass.constantize.table_name}.* FROM #{klass.constantize.table_name}
INNER JOIN page_elements ON #{klass.constantize.table_name}.id = page_elements.embeddable_id AND page_elements.embeddable_type = '#{klass}'
WHERE page_elements.page_id = \#\{id\}" }!
  end

  def add_embeddable(embeddable)
    page_elements << PageElement.create(:user => user, :embeddable => embeddable)
  end
end
