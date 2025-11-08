const { Server } = require("socket.io");
const io = new Server(8080, {
    cors: { origin: "*" },
});

io.on("connection", (socket) => {
    console.log("Client connected:", socket.id);

    socket.on("message", (msg) => {
        console.log(`Received message from ${socket.id}: ${msg}`);
        socket.broadcast.emit("message", msg);
    });

    socket.on("disconnect", () => {
        console.log("Client disconnected:", socket.id);
    });
});