package main
import (
    "net/http"
    "github.com/gin-gonic/gin"
)
const(hello_message = "Hello World 2")
func main() {
    router := gin.Default()
    router.GET("/", func (c  *gin.Context) {c.String(http.StatusOK, hello_message)})
    router.Run("localhost:8080")
}

