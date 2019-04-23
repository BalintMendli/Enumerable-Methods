module Enumerable
  def my_each
    this=self
    i=0
    this=self.to_a if self.class==Range
    while i<this.size
      yield(this.keys[i],this.values[i]) if this.class==Hash
      yield(this[i]) if this.class==Array
      i+=1
    end
  end

  def my_each_with_index
    this=self
    i=0
    this=self.to_a if self.class==Range
    while i<this.size
      yield([this.keys[i],this.values[i]],i) if this.class==Hash
      yield(this[i],i) if this.class==Array
      i+=1
    end
  end

  def my_select
    this=self
    if this.class==Array || this.class==Range
      sel_arr=[] 
      this.my_each{|x| sel_arr.push(x) if yield(x)}
    end
    if this.class==Hash
      sel_hash={} 
      this.my_each{|k,v| sel_hash[k]=v if yield(k,v)}
    end
    sel_arr || sel_hash
  end

  def my_all?
    if self.class==Array || self.class==Range
      self.my_each{|x| return false if !yield(x)}
    end
    if self.class==Hash
      self.my_each{|k,v| return false if !yield(k,v)}
    end
    true
  end

  def my_any?
    if self.class==Array || self.class==Range
      self.my_each{|x| return true if yield(x)}
    end
    if self.class==Hash
      self.my_each{|k,v| return true if yield(k,v)}
    end
    false
  end

  def my_none?
    if self.class==Array || self.class==Range
      self.my_each{|x| return false if yield(x)}
    end
    if self.class==Hash
      self.my_each{|k,v| return false if yield(k,v)}
    end
    true
  end

  def my_count(*arg)
    count=0
    if arg.length>0
      if self.class==Array || self.class==Range
        self.my_each{|x| count+=1 if x==arg[0]}
      end
      if self.class==Hash
        self.my_each{|k,v| count+=1 if [k,v]==arg[0]}
      end
    elsif block_given?
      if self.class==Array || self.class==Range
        self.my_each{|x| count+=1 if yield(x)}
      end
      if self.class==Hash
        self.my_each{|k,v| count+=1 if yield(k,v)}
      end
    else
      return self.length
    end
    count
  end

  def my_map(*arg)
    proc=arg[0]
    map_arr=[]
    if proc.class==Proc
      if self.class==Array || self.class==Range
        self.my_each{|x| map_arr.push(proc.call(x))}
      end
      if self.class==Hash
        self.my_each{|k,v| map_arr.push(proc.call(k,v))}
      end
    else
      if self.class==Array || self.class==Range
        self.my_each{|x| map_arr.push(yield(x))}
      end
      if self.class==Hash
        self.my_each{|k,v| map_arr.push(yield(k,v))}
      end
    end
    map_arr
  end

  def my_inject(*arg)
    acc=self.to_a[0]
    acc=arg[0] if arg.length>0
    if self.class==Array || self.class==Range
      self.my_each_with_index{|x,i| acc=yield(acc,x) if arg.length>0 || i!=0}
    end
    if self.class==Hash
      self.my_each_with_index{|item,i| acc=yield(acc,item) if arg.length>0 || i!=0}
    end
    acc
  end

end

def multiply_els(arr)
  arr.my_inject{|acc,n| acc*n}
end

multiply_els([2,4,5])

my_proc=Proc.new {|n| n*2}
p [1,2,3,4].my_map(my_proc)
p [1,2,3,4].my_map {|n| n*2 }
