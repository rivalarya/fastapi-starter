from fastapi import APIRouter
from .handler import get_ping, post_ping
from src.schemas import StandardResponse

router = APIRouter()

router.add_api_route("/ping", get_ping, methods=["GET"], response_model=StandardResponse)
router.add_api_route("/ping", post_ping, methods=["POST"], response_model=StandardResponse)