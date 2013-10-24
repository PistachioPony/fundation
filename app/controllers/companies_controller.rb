class CompaniesController < ApplicationController

  def show
    @msg = "Company not found. Try another search."
    @company = Company.find(params[:id])
    if @company
      render :show
    else
      render :search
    end
  end

  def search
    @msg = "Company not found. Try another search."
    if params[:name].nil?
      @msg = "Search for a company by name below:"
      render :search
    else
      @company = Company.find_by(name: params[:name])
      if @company
        render :show
      else
        render :search
      end
    end
  end

  def query
    # @c_no_loc = Company.where('location IS NOT NULL')
    # @location_options = @c_no_loc.uniq.pluck(:location).sort
    @location_options = ['Los Angeles', 'Chicago', 'New York', 'San Francisco', 'Mountain View', 'Austin', 'Detroit', 'Palo Alto', 'Boston', 'Cambridge'].sort
    @location_options << "none"


    @c_no_ind = Company.where('industry IS NOT NULL')
    @industry_options = @c_no_ind.uniq.pluck(:industry).select do |ind|
      ind.length > 4
    end
    @industry_options.sort!
    @industry_options << "none"
    @months = ["none"]
    (1..12).each { |x| @months << x }
    @years = ["none"]
    (2000..2013).each { |x| @years << x}
    @funding_options = ["none", "<$100k", "$100k - $250k", "$250k - $500k", "$500k - $1m", "$1m - $2.5m", "$2.5m - $5m", "$5m - $10m", "$10m - $25m", ">$25m" ]
    render :query
  end

  def results
    @companies = Company.all

    unless params[:location] == "none"
      @companies = @companies.where(location: params[:location])
    end

    unless params[:industry] == "none"
      @companies = @companies.where(industry: params[:industry])
    end

    case params[:funding]
    when "<$100k"
      @companies = @companies.where('funding < 100000')  
    when "$100k - $250k"
      @companies = @companies.where('funding >= 100000 AND funding < 250000') 
    when "$250k - $500k"
      @companies = @companies.where('funding >= 250000 AND funding < 500000')
    when "$500k - $1m"      
      @companies = @companies.where('funding >= 500000 AND funding < 1000000') 
    when "$1m - $2.5m"
      @companies = @companies.where('funding >= 1000000 AND funding < 2500000') 
    when "$2.5m - $5m"
      @companies = @companies.where('funding >= 2500000 AND funding < 5000000')
    when "$5m - $10m"
      @companies = @companies.where('funding >= 5000000 AND funding < 10000000')
    when "$10m - $25m"
      @companies = @companies.where('funding >= 10000000 AND funding < 25000000')
    when ">$25m"
      @companies = @companies.where('funding >= 25000000')
    end

    unless params[:year] == "none"
      @companies = @companies.where('last_round IS NOT NULL')
      if params[:month] == "none"
        @companies = @companies.select do |company|
          company.last_round >= "01/01/#{params[:year]}"
        end
      else
        @companies = @companies.select do |company|
          company.last_round >= "#{params[:month]}/01/#{params[:year]}"
        end
      end
    end

    @watchlist_options = current_user.watchlists
    
    render :results
  end

end