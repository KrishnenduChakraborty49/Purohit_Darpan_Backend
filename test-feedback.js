

async function run() {
    console.log("Registering user...");
    const regRes = await fetch("https://purohit-darpan-backend-q7b6.onrender.com/api/auth/register", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            username: "testuser123",
            password: "password123",
            email: "test12345@test.com",
            fullName: "Test User",
            role: "DEVOTEE"
        })
    });
    console.log("Register:", regRes.status);
    // Ignore if already registered
    
    console.log("Logging in...");
    const loginRes = await fetch("https://purohit-darpan-backend-q7b6.onrender.com/api/auth/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            username: "testuser123",
            password: "password123"
        })
    });
    
    if (!loginRes.ok) {
        console.error("Login failed", await loginRes.text());
        return;
    }
    const data = await loginRes.json();
    const token = data.token;
    console.log("Got token:", token.substring(0, 10) + "...");
    
    console.log("Submitting feedback...");
    const fbRes = await fetch("https://purohit-darpan-backend-q7b6.onrender.com/api/feedback", {
        method: "POST",
        headers: { 
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        },
        body: JSON.stringify({
            rating: 5,
            comments: "Testing the feedback api!"
        })
    });
    
    console.log("Feedback status:", fbRes.status);
    console.log("Feedback response:", await fbRes.text());
}

run();
