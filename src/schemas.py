from pydantic import BaseModel
from typing import Generic, TypeVar

T = TypeVar("T")

class StandardResponse(BaseModel, Generic[T]):
    message: str
    data: T