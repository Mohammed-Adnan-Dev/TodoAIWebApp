<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chatbot</title>
</head>
<body>
    <h2>Ask the AI anything:</h2>
    <form action="chatbot" method="post">
        <input type="text" name="userInput" placeholder="Enter your question" required />
        <input type="submit" value="Ask" />
    </form>
</body>
</html>
