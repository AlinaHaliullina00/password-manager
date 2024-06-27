<!DOCTYPE html>
<html>
<head>
<title>Менеджер паролей</title>
<style>
body {
font-family: sans-serif;
}
table {
border-collapse: collapse;
width: 100%;
}
th, td {
text-align: left;
padding: 8px;
border: 1px solid #ddd;
}
th {
background-color: #f2f2f2;
}
.add-form {
margin-top: 20px;
}
input[type="text"], input[type="password"] {
width: 100%;
padding: 8px;
margin: 8px 0;
box-sizing: border-box;
}
button {
padding: 8px 16px;
background-color: #4CAF50;
color: white;
border: none;
cursor: pointer;
}
</style>
</head>
<body>
<h1>Менеджер паролей</h1>
<table id="password-table">
<thead>
<tr>
<th>Логин</th>
<th>Пароль</th>
<th>URL</th>
<th>Действия</th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<div class="add-form">
<h2>Добавить новый пароль</h2>
<label for="login">Логин:</label>
<input type="text" id="login" name="login">
<label for="password">Пароль:</label>
<input type="password" id="password" name="password">
<label for="url">URL:</label>
<input type="text" id="url" name="url">
<button onclick="addPassword()">Добавить</button>
</div>
<script>
function displayPasswords(passwords) {
const tableBody = document.querySelector('#password-table tbody');
tableBody.innerHTML = '';
passwords.forEach(password => {
const row = tableBody.insertRow();
const loginCell = row.insertCell();
const passwordCell = row.insertCell();
const urlCell = row.insertCell();
const actionsCell = row.insertCell();

loginCell.textContent = password.login;
passwordCell.textContent = '********';
passwordCell.dataset.realPassword = password.password;
passwordCell.dataset.masked = 'true';

urlCell.textContent = password.url;

actionsCell.innerHTML = '<button onclick="togglePasswordVisibility(this)">Показать</button> <button onclick="deletePassword(' + password.id + ')">Удалить</button>';
});
}

function togglePasswordVisibility(button) {
const passwordCell = button.parentNode.previousSibling.previousSibling;
if (passwordCell.dataset.masked === 'true') {
passwordCell.textContent = passwordCell.dataset.realPassword;
button.textContent = 'Скрыть';
passwordCell.dataset.masked = 'false';
} else {
passwordCell.textContent = '********';
button.textContent = 'Показать';
passwordCell.dataset.masked = 'true';
}
}
function addPassword() {
const login = document.getElementById('login').value;
const password = document.getElementById('password').value;
const url = document.getElementById('url').value;
let passwords = JSON.parse(localStorage.getItem('passwords')) || [];
const newPassword = {
id: passwords.length > 0 ? Math.max(...passwords.map(p => p.id)) + 1 : 1,
login,
password,
url
};
passwords.push(newPassword);
localStorage.setItem('passwords', JSON.stringify(passwords));
displayPasswords(passwords);
}

function deletePassword(id) {
let passwords = JSON.parse(localStorage.getItem('passwords')) || [];
passwords = passwords.filter(password => password.id !== id);
localStorage.setItem('passwords', JSON.stringify(passwords));
displayPasswords(passwords);
}
loadPasswords();
</script>
</body>
</html>
