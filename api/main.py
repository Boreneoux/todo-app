from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from . import models, schemas, database

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI()

@app.get("/")
def root():
    return {"Hello": "World"}

# Get All To-Do Items
@app.get("/todos", response_model=list[schemas.ToDo])
def read_todos(skip: int = 0, limit: int = 10, db: Session = Depends(database.get_db)):
    todos = db.query(models.ToDoItem).offset(skip).limit(limit).all()
    return todos

# Create To-Do Item
@app.post("/todos", response_model=schemas.ToDo)
def create_todo(todo: schemas.ToDoCreate, db: Session = Depends(database.get_db)):
    db_todo = models.ToDoItem(**todo.dict())
    db.add(db_todo)
    db.commit()
    db.refresh(db_todo)
    return db_todo

# Update To-Do Status
@app.put("/todos/{todo_id}", response_model=schemas.ToDo)
def update_todo_status(todo_id: int, todo: schemas.ToDoUpdateStatus, db: Session = Depends(database.get_db)):
    db_todo = db.query(models.ToDoItem).filter(models.ToDoItem.id == todo_id).first()
    if db_todo is None:
        raise HTTPException(status_code=404, detail="To-Do not found")
    db_todo.status = todo.status
    db.commit()
    db.refresh(db_todo)
    return db_todo

# Delete To-Do Item
@app.delete("/todos/{todo_id}")
def delete_todo(todo_id: int, db: Session = Depends(database.get_db)):
    db_todo = db.query(models.ToDoItem).filter(models.ToDoItem.id == todo_id).first()
    if db_todo is None:
        raise HTTPException(status_code=404, detail="To-Do not found")
    db.delete(db_todo)
    db.commit()
    return {"detail": "To-Do deleted"}
