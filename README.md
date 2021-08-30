
# Table Scheme

## Users

| カラム名        | データ型 | 
| --------------- | -------- | 
| user_name       | string   | 
| email           | string   | 
| password_digest | string   | 
| admin           | boolean  | 


## Tasks

| カラム名    | データ型 | 
| ----------- | --------- | 
| title       | string    | 
| description | string    | 
| user_id(FK) | integer   |

## Labels

| カラム名   | データ型 | 
| ---------- | -------- | 
| label_name | string   | 


## Labellings

| カラム名     | データ型 | 
| ------------ | -------- | 
| task_id(FK)  | integer  | 
| label_id(FK) | integer  | 


# The Deployment Procedure to Heroku
1. Log in to Heroku  
 ```% heroku login```　　
 
1. Make sure you are located in your current directory and create a new application on Heroku.  
```% heroku create```  
You would get the URL of the application. The URL is different each time.  

1. Perform asset precompilation  
```% rails assets:precompile RAILS_ENV=production```  

1. Add Heroku buildpack  
ex)
```% heroku buildpacks:add --index 1 heroku/nodejs```  

1. Commit

1. Deploy to Heroku  
```% git push heroku master```

1. Database migration  
```% heroku run rails db:migrate```

1. Finally you can open your app!  
```% heroku open```

