class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
   @bills = Bill.all
   @billsmorethanone = Bill.joins(:encounters).group('bills.id').having("COUNT(encounters.bill_id) >= ?", 2).count
   @avgs = Bill.joins(encounters: :services).average(:cost)
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
     uploaded_file = params[:file]
     file_content = uploaded_file.read
     file_content.each_line do |l|
      if l =~ /START OF BILL \d/
        @bill = Bill.create
      else
        if l=~ /Patient\s+(.+)\s+encounter+\swith\s+(.+)/
          regex = /Patient\s+(.+)\s+encounter+\swith\s+(.+)/
          content = l.scan(regex)
          Encounter.create(patient_name: content[0][0], doctor_name: content[0][1], bill_id: Bill.last.id)
        else
          if l=~ /Service\s+(.+)\s+-+\scost\s\$+(.+)/
            regex = /Service\s+(.+)\s+-+\scost\s\$+(.+)/
            content = l.scan(regex)
            @service = Service.create(name: content[0][0], cost: content[0][1], encounter_id: Encounter.last.id)
          end
        end
      end
     end
   #Bill.import(params[:file]).read
    redirect_to bills_path, notice: "success!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:avg_cost)
    end
end
