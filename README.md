<h1>Table Scheme</h1>

<h2>Users</h2>

| カラム名        | データ型 | 
| --------------- | -------- | 
| user_name       | string   | 
| email           | string   | 
| password_digest | string   | 
| admin           | boolean  | 


<h2>Tsks</h2>

| カラム名    | データ型 | 
| ----------- | --------- | 
| title       | string    | 
| description | text      | 
| user_id(FK) | integer   |

<h2>Labels</h2>

| カラム名   | データ型 | 
| ---------- | -------- | 
| label_name | string   | 


<h2>Labellings</h2>

| カラム名     | データ型 | 
| ------------ | -------- | 
| task_id(FK)  | integer  | 
| label_id(FK) | integer  | 
