class Api::V1::NotesController < Api::V1::ApiController
  
  before_filter :load_notable, :only => [:index, :create]
  
  def index
    @notes = @notable.notes
  end
  
  def show
    @note = Note.find(params[:id])
  end

  def create
    @note = @notable.notes.new(params[:note])
    
    if not @note.save
      render status :unprocessable_entity, json: @note.errors
    end
    
  end

  def update
    @note = Note.find(params[:id])

    if not @note.update_attributes(params[:note])
      render status: :unprocessable_entity, json: @note.errors  
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    head :no_content
  end
  
 private
 
 def load_notable
    resource, id = request.path.split('/')[3,4]
    @notable = resource.singularize.classify.constantize.find(id)
  end

  def find_notable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
