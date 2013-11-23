class Module
  
  def attribute(*attributes, &block)
    if attributes.first.is_a? Hash
      attributes.first.each {|a,b| assert a,b }
    else
      assert *attributes, &block
    end
  end
  
  private
  
  def assert(method_name, default = nil, &block)
    
    define_method "#{method_name}?" do
      !!send("#{method_name}")
    end
    
    define_method method_name do
      return instance_variable_get("@#{method_name}_val") if instance_variable_defined?("@#{method_name}_val")
      send "#{method_name}=", (block ? instance_eval(&block) : default)
    end
    
    define_method "#{method_name}=" do |val|
      instance_variable_set("@#{method_name}_val", val)
    end
    
  end

end