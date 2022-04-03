module Mutations
  class User::CreateUser < BaseMutation
    
    field :token, String, null: false
    field :user, ::Types::Query::UserType, null: false
    field :quizzes, [::Types::Query::QuizType]
    field :errors, [String], null: false

    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true


    def resolve(username:, email:, password:, password_confirmation:)
      payload = { 
        username: username, 
        email: email, 
        password: password, 
        password_confirmation: password_confirmation 
      }
      outcome = ::Users::Create.run(payload)
      if outcome.valid?
        context[:current_user] = outcome.result[:user]
        { 
          token: outcome.result[:token], user: outcome.result[:user], quizzes: Quiz.all
        }
      else
        raise GraphQL::ExecutionError, outcome.errors.full_messages
      end
    end
  end
end
