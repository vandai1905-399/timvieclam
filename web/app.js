(function(){
  const form = document.getElementById('login-form');
  const emailEl = document.getElementById('email');
  const pwEl = document.getElementById('password');
  const msg = document.getElementById('message');
  const dashboard = document.getElementById('dashboard');
  const loginSection = document.getElementById('login-section');
  const welcomeText = document.getElementById('welcome-text');
  const logoutBtn = document.getElementById('logout');

  function showMessage(text, isError){
    msg.textContent = text;
    msg.style.color = isError ? '#b00020' : '#006900';
  }

  function isLoggedIn(){
    return !!localStorage.getItem('tvltoken');
  }

  function showDashboard(){
    loginSection.classList.add('hidden');
    dashboard.classList.remove('hidden');
    const email = localStorage.getItem('tvluser') || 'Người dùng';
    welcomeText.textContent = `Xin chào, ${email}!`; 
  }

  function showLogin(){
    loginSection.classList.remove('hidden');
    dashboard.classList.add('hidden');
    msg.textContent = '';
  }

  form.addEventListener('submit', function(e){
    e.preventDefault();
    const email = emailEl.value.trim();
    const pw = pwEl.value;
    if(!email || email.indexOf('@')===-1){
      showMessage('Vui lòng nhập email hợp lệ', true); return;
    }
    if(!pw || pw.length < 4){
      showMessage('Mật khẩu ít nhất 4 ký tự', true); return;
    }
    // Simulate login success
    const fakeToken = 'tok_' + Math.random().toString(36).slice(2);
    localStorage.setItem('tvltoken', fakeToken);
    localStorage.setItem('tvluser', email);
    showMessage('Đăng nhập thành công!', false);
    setTimeout(showDashboard, 600);
  });

  logoutBtn.addEventListener('click', function(){
    localStorage.removeItem('tvltoken');
    localStorage.removeItem('tvluser');
    showLogin();
  });

  // Initialize view
  if(isLoggedIn()) showDashboard(); else showLogin();
})();
