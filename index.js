const express = require('express');
const { spawn } = require('child_process');
const path = require('path');

const app = express();

// Middleware pentru procesarea JSON-ului din corpul cererii
app.use(express.json());

// Setare folder pentru fișiere statice
app.use(express.static(path.join(__dirname, 'public')));

// Servește fișierul index.html la ruta rădăcină
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// WebSocket logic pentru afișarea output-ului în timp real
const { WebSocketServer } = require('ws');
const wss = new WebSocketServer({ noServer: true });

app.post('/sync', (req, res) => {
    const { host1, user1, pass1, host2, user2, pass2 } = req.body;

    // Verifică dacă toți parametrii necesari sunt prezenți
    if (!host1 || !user1 || !pass1 || !host2 || !user2 || !pass2) {
        return res.status(400).json({ error: "Missing required parameters" });
    }

    const command = `imapsync --host1 ${host1} --user1 ${user1} --password1 ${pass1} --host2 ${host2} --user2 ${user2} --password2 ${pass2}`;

    res.status(200).json({ message: "Sync started. Check WebSocket for updates." });

    wss.on('connection', (ws) => {
        const process = spawn('sh', ['-c', command]);

        process.stdout.on('data', (data) => {
            ws.send(data.toString());
        });

        process.stderr.on('data', (data) => {
            ws.send(data.toString());
        });

        process.on('close', (code) => {
            ws.send(`Process exited with code ${code}`);
            ws.close();
        });
    });
});

const server = app.listen(3000, () => {
    console.log('Server running on port 3000');
});

server.on('upgrade', (request, socket, head) => {
    wss.handleUpgrade(request, socket, head, (ws) => {
        wss.emit('connection', ws, request);
    });
});

