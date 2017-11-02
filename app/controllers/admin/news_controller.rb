module Admin
  class NewsController < Admin::AdminController
    before_action :set_news, only: [:show, :edit, :update, :destroy]

    # GET /admin/news
    # GET /admin/news.json
    def index
      @admin_news = News.includes([:site, :region])
                        .order('in_top desc, date desc')
                        .page(params[:page])
    end

    # GET /admin/news/1
    # GET /admin/news/1.json
    def show
    end

    # GET /admin/news/new
    def new
      @admin_news = News.new
    end

    # GET /admin/news/1/edit
    def edit
    end

    # POST /admin/news
    # POST /admin/news.json
    def create
      @admin_news = News.new(news_params)

      respond_to do |format|
        if @admin_news.save
          format.html { redirect_to @admin_news, notice: 'News was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /admin/news/1
    # PATCH/PUT /admin/news/1.json
    def update
      respond_to do |format|
        if @admin_news.update(news_params)
          format.html { redirect_to [:admin, @admin_news], notice: 'News was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /admin/news/1
    # DELETE /admin/news/1.json
    def destroy
      @admin_news.destroy
      respond_to do |format|
        format.html { redirect_to admin_news_index_url, notice: 'News was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @admin_news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :description, :in_top)
    end
  end
end