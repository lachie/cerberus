module Cerberus
  class Hooks
    attr_reader :output
    
    def self.run(kind,config,*args)
      if hook_cmd = config[:hooks,kind.to_sym,:command]
        new(kind,hook_cmd,config,*args).run
      end
    end
    
    def initialize(kind,hook_cmd,config,*args)
      @kind = kind
      @hook_cmd = hook_cmd
      @config = config
      @args = args
    end
    
    def run
      Dir.chdir @config[:application_root]
      @output = `#{@hook_cmd} 2>&1`
      
      puts `pwd`
      puts "hook #{@kind}:"
      puts @output
    end
  end
end