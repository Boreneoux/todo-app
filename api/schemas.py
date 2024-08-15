from pydantic import BaseModel, validator

class ToDoCreate(BaseModel):
    title: str
    description: str

class ToDoUpdateStatus(BaseModel):
    status: str

    @validator('status')
    def validate_status(cls, value):
        if value not in ['pending', 'completed']:
            raise ValueError('Invalid status')
        return value

class ToDo(BaseModel):
    id: int
    title: str
    description: str
    status: str

    class Config:
        from_attributes = True
