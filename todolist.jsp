<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>To-Do List</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
            min-height: 100vh;
        }

        .main-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
            padding-bottom: 100px;
        }

        h2 {
            color: #1a73e8;
            text-align: center;
            margin-bottom: 40px;
            font-size: 2em;
        }

        h3 {
            color: #202124;
            margin: 30px 0 20px 0;
        }

        .task-form {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .task-form form {
            display: flex;
            gap: 15px;
        }

        .task-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .task-input:focus {
            outline: none;
            border-color: #1a73e8;
        }

        .task-submit {
            padding: 12px 25px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: 500;
            min-width: 120px;
        }

        .task-submit:hover {
            background-color: #1557b0;
        }

        .task-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .task-item {
            background: white;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .task-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.12);
        }

        .task-content {
            display: flex;
            flex-direction: column;
            gap: 8px;
            flex: 1;
        }

        .task-content strong {
            font-size: 1.1em;
            color: #202124;
        }

        .task-date {
            font-size: 0.85em;
            color: #5f6368;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: 500;
            margin-left: 20px;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        .ai-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 320px;
            z-index: 1000;
        }

        .ai-section {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .ai-header {
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }

        .ai-header h4 {
            margin: 0;
            color: #202124;
        }

        .minimize-btn {
            background: none;
            border: none;
            color: #5f6368;
            font-size: 20px;
            cursor: pointer;
            padding: 0 5px;
        }

        .ai-content {
            padding: 20px;
        }

        .ai-response {
            background-color: #e8f5e9;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #34a853;
            margin-bottom: 15px;
        }

        .ai-response strong {
            display: block;
            margin-bottom: 8px;
            color: #1e8e3e;
        }

        .ai-textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            margin-bottom: 15px;
            resize: vertical;
            min-height: 80px;
            font-family: inherit;
            font-size: 14px;
            box-sizing: border-box;
        }

        .ai-textarea:focus {
            outline: none;
            border-color: #1a73e8;
        }

        .ai-buttons {
            display: flex;
            gap: 12px;
        }

        .ai-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: opacity 0.3s;
            font-weight: 500;
            font-size: 14px;
        }

        .add-btn {
            background-color: #1a73e8;
            color: white;
        }

        .ask-btn {
            background-color: #34a853;
            color: white;
        }

        .ai-btn:hover {
            opacity: 0.9;
        }

        .ai-section.minimized .ai-content {
            display: none;
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 20px;
                padding-bottom: 200px;
            }

            .task-form form {
                flex-direction: column;
            }

            .task-submit {
                width: 100%;
            }

            .task-item {
                flex-direction: column;
                gap: 15px;
            }

            .delete-btn {
                width: 100%;
                margin-left: 0;
            }

            .ai-container {
                width: calc(100% - 40px);
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <h2>Todolist With AI</h2>

        <div class="task-form">
            <form action="todo" method="post">
                <input type="text" name="task" class="task-input" placeholder="Add a new task" required>
                <input type="submit" value="Add Task" class="task-submit">
            </form>
        </div>

        <h3>Your Tasks</h3>
        <ul class="task-list">
            <c:forEach var="task" items="${tasks}">
                <li class="task-item">
                    <div class="task-content">
                        <strong>${task.task}</strong>
                        <span class="task-date">
                            Added on: <fmt:formatDate value="${task.createdDate}" pattern="dd-MM-yyyy HH:mm"/>
                        </span>
                    </div>
                    <form action="deleteTask" method="post">
                        <input type="hidden" name="taskId" value="${task.id}">
                        <input type="submit" value="Delete" class="delete-btn">
                    </form>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="ai-container">
        <div class="ai-section" id="aiSection">
            <div class="ai-header" onclick="toggleAI()">
                <h4>AI Assistant</h4>
                <button type="button" class="minimize-btn" id="minimizeBtn">-</button>
            </div>
            <div class="ai-content">
                <c:if test="${not empty aiResponse}">
                    <div class="ai-response">
                        <strong>AI Response:</strong>
                        <p>${aiResponse}</p>
                    </div>
                </c:if>

                <form id="aiForm" action="chatbot" method="post">
                    <textarea id="userInput" name="task" class="ai-textarea" rows="3" 
                        placeholder="Ask me anything..."></textarea>
                    <div class="ai-buttons">
                        <button type="button" onclick="submitAIForm('todo')" class="ai-btn add-btn">Add Task</button>
                        <button type="button" onclick="submitAIForm('chatbot')" class="ai-btn ask-btn">Ask AI</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
    function submitAIForm(action) {
        const form = document.getElementById('aiForm');
        const input = document.getElementById('userInput');
        
        if (!input.value.trim()) {
            alert('Please enter some text');
            return;
        }
        
        form.action = action;
        form.submit();
    }

    function toggleAI() {
        const aiSection = document.getElementById('aiSection');
        const minimizeBtn = document.getElementById('minimizeBtn');
        aiSection.classList.toggle('minimized');
        minimizeBtn.textContent = aiSection.classList.contains('minimized') ? '+' : '-';
    }

    // Remove duplicate AI response if exists
    document.addEventListener('DOMContentLoaded', function() {
        const aiResponses = document.querySelectorAll('.ai-response');
        if (aiResponses.length > 1) {
            aiResponses[0].remove();
        }
    });
    </script>
</body>
</html>