class CreateCaseStudyDb < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name,                 null: false, default: ""
      t.string :email,                null: false, default: ""
      t.string :encrypted_password,   null: false, default: ""
      t.timestamps
    end

    add_index :users, :email,         unique: true

    create_table :roles do |t|
      t.string :name,                 null: false, default: "", unique: true
      t.timestamps
    end

    create_table :role_users do |t|
      t.references :user,             null: false, foreign_key: true
      t.references :role,             null: false, foreign_key: true
      t.timestamps
    end

    create_table :casestudies do |t|
      t.string :name,                 null: false, default: "", unique: true
      t.integer :duration,            null: false, default: 90
      t.integer :scale,               null: false, default: 6
      t.timestamps
    end

    create_table :pages do |t|
      t.text :body,                   null: false, default: ""
      t.references :casestudy,        null: false, foreign_key: true
      t.timestamps
    end

    create_table :casestudy_users do |t|
      t.string :status
      t.integer :time_elaspsed
      t.datetime :started_time
      t.datetime :completed_time
      
      t.references :casestudy, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :assessor, null: false, index: true, foreign_key: {to_table: :users}
      
      t.timestamps
    end

    create_table :questions do |t|
      t.text :body,                   null: false, default: ""
      t.references :casestudy,        null: false, foreign_key: true
      t.timestamps
    end

    create_table :user_responses do |t|
      t.text :response,               null: false, default: ""
      t.references :question,         null: false, foreign_key: true
      t.references :casestudy_user,   null: false, foreign_key: true
      t.references :user,             null: false, foreign_key: true
      t.timestamps
    end

    create_table :traits do |t|
      t.string :name,                 null: false, default: ""
      t.timestamps
    end

    add_index :traits, :name,         unique: true

    create_table :question_traits do |t|
      t.references :question,         null: false, foreign_key: true
      t.references :trait,            null: false, foreign_key: true
      t.timestamps
    end

    create_table :assessor_responses do |t|
      t.float :rating,                null: false, default: 0
      t.references :question_trait,   null: false, foreign_key: true
      t.references :casestudy_user,   null: false, foreign_key: true
      t.references :user,             null: false, foreign_key: true
      t.references :assessor,         null: false, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
