class User < ApplicationRecord
   belongs_to:organizacion
   def organizacion_name
        self.organizacion.name
   end
end
