class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :brand

  after_touch() { __elasticsearch__.index_document }

  def as_indexed_json(options={})
    self.as_json(
      include: { brand: { only: :name } }
    )
  end
end
