class Api::V1::BalanceChangesController < InheritedResources::Base
  respond_to :json
  # actions :index, :create, :update, :destroy, :show

  def chart_data
    e = Exchange.find params[:exchange_id]
    render json: Oj.dump(e.changes_chart_data)
  rescue
    render json: []
  end

  def index
    e = Exchange.find(params[:exchange_id])
    @balance_changes = e.balance_changes.includes(:currency)
  end
end
