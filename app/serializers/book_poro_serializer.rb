class BookPoroSerializer
  include FastJsonapi::ObjectSerializer
  set_id :g_id
  attributes :title, :authors, :genres, :description
end