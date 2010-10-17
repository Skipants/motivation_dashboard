class Setup::DataSetsController < Setup::ApplicationController
  
  def new
    @data_set = DataSet.new
    @config_info = integration_constant.info(@data_source.config)
  end
  
  def create
    @config = integration_constant
    @config_info = @config.info(@data_source.config)
        
    @data_set = DataSet.new(params[:data_set])
    
    config_result = @config.check_config(params[:custom_config]) 
    @data_set.config = config_result if config_result
    
    if config_result && @data_set.save
      redirect_to [:new, :setup, @data_source, @data_set, :report]
    else
      render :action => :new
    end    
  end

  def edit
    @data_set = DataSet.find(params[:id])
  end
  
  def update
    @data_set = DataSet.find(params[:id])
    
    if @data_set.update_attributes(params[:data_set])
      redirect_to [:new, :setup, @data_source, @data_set, :report] # Should redirect to existing page - Nathan 3:33PM SAT
    else
      render :action => :edit
    end
  end

  private
    
    def integration_constant
      "Integration::#{@data_source.integration.to_s.classify}::DataSet".constantize
    end

end


