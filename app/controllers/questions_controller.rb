class QuestionsController < ApplicationController

  get '/questions' do
    if logged_in?
        @questions = Question.all
        erb :'questions/index'
    else
      redirect to '/login'
    end
  end

    get '/questions/new' do
      if logged_in?
        erb :'questions/new'
      else
        redirect to '/login'
      end
    end

    post '/questions' do
      if logged_in?
        #checking if each field is filled in
        if params[:topic].empty? && params[:content].empty? && params[:choice1].empty? && params[:choice2].empty?
          redirect to "/questions/new"
        else
          @question = current_user.questions.build(params)
          if @question.save
            redirect to "/questions/#{@question.id}"
          else
            redirect to "/questions/new"
          end
        end
      else
        redirect to '/login'
      end
    end

   get '/questions/:id' do
     if logged_in?
       @question = Question.find_by_id(params[:id])
       erb :'questions/show'
     else
       redirect to '/login'
     end
   end

   get '/questions/:id/edit' do
      if logged_in?
        @question = Question.find(params[:id])
        if @question && @question.user == current_user
          erb :'questions/edit'
        else
          redirect to '/questions'
        end
      else
        redirect to '/login'
      end
    end

    patch '/questions/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/questions/#{params[:id]}/edit"
      else
        @question = Question.find_by_id(params[:id])
        if @question && @question.user == current_user
          if @question.update(content: params[:content])
            redirect to "/questions/#{@question.id}"
          else
            redirect to '/questions/#{@question.id}/edit'
          end
        else
          redirect to '/questions'
        end
      end
    else
      redirect to '/login'
    end
  end

    delete '/questions/:id/delete' do
      if logged_in?
        @question = Question.(params[:id])
        if @question && @question.user == current_user
          @question.delete
        end
        redirect to '/questions'
      else
        redirect to '/login'
      end
    end

    get '/questions/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      else
        redirect to '/'
      end
    end


end
