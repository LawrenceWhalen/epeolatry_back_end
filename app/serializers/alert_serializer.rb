class AlertSerializer
  include FastJsonapi::ObjectSerializer
  set_id 
  attributes :alert
end