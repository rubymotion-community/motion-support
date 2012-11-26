class Class
  # Defines class-level attribute readers as specified in fields. Fields can be one or more
  # symbols specifying the names of the readers.
  def cattr_reader(*fields)
    metaclass.send :attr_reader, *fields
  end
  
  # Defines class-level attribute writers as specified in fields. Fields can be one or more
  # symbols specifying the names of the writers.
  def cattr_writer(*fields)
    metaclass.send :attr_writer, *fields
  end
  
  # Defines class-level attribute readers and writers as specified in fields. Fields can be
  # one or more symbols specifying the names of the accessors.
  def cattr_accessor(*fields)
    metaclass.send :attr_accessor, *fields
  end
end
