from fastapi import FastAPI
from pydantic import BaseModel

class Input(BaseModel):
    text: str

# Define the app
app = FastAPI(
    title="MyApp",
    description="Hello API developer!",
    version="0.1.0"
)

# Define a GET operation
@app.get("/")
async def main():
    return {"message": "Hello Universe!"}

@app.get("/hello/{name}"):
async def hello_name(name: str):
    return {"message": f"Hello {name}"}

# Define a POST operation
@app.post("/submit")
async def submit(input: Input):
    return {"message": f"Data submitted is: {input.text}"}