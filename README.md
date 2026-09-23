# 👣 발 통증 일기

발/손 통증을 기록하고 AI로 분석하는 개인 웹앱

**앱 주소**: https://schoyeon.github.io/foot

---

## 🔐 보안 (2026-09-23 추가)

기록은 **로그인한 본인만** 읽고 쓸 수 있다.

- 앱: 이메일+비밀번호 로그인. 데이터 요청은 anon 키가 아니라 로그인 토큰으로 나간다. 로그인 상태는 기기에 유지되고, "로그아웃"을 누르면 이 기기의 캐시도 지운다.
- DB: `security.sql` — `user_id` 컬럼 + RLS "본인 행만" 정책 + anon 권한 회수.
- 계정은 Supabase 대시보드에서만 만든다 (앱에 가입 기능 없음). **Authentication → Sign In / Providers → Email → "Allow new users to sign up" 을 꺼둘 것.**

처음 적용 순서: ① 이 index.html 배포 → ② Supabase Authentication → Users → **Add user** (이메일·비밀번호, Auto Confirm) → UUID 복사 → ③ `security.sql` 의 `<MY_USER_ID>` 두 곳에 넣고 SQL Editor 실행 → ④ 앱에서 로그인해 기록이 보이는지 확인.

## 🔧 앱 수정 방법

### 1단계 - Claude에게 수정 요청
- Claude.ai 접속
- "발 통증 일기 앱에서 ○○ 바꿔줘" 요청
- 새 `index.html` 파일 받기

### 2단계 - GitHub에 파일 올리기
1. 이 저장소 (https://github.com/schoyeon/foot) 접속
2. **Add file** → **Upload files** 클릭
3. 새 `index.html` 파일 드래그 앤 드롭
4. **Commit changes** 클릭

### 3단계 - 자동 배포
- 1~2분 후 앱에 자동 반영 ✅
- GitHub Pages가 자동으로 감지

---

## 🏗️ 인프라 구조

| 역할 | 서비스 |
|------|--------|
| 앱 호스팅 | GitHub Pages |
| 데이터베이스 | Supabase |
| 코드 저장소 | GitHub (이 저장소) |

---

## 📱 폰 홈 화면에 추가하는 법

**iPhone**
1. 사파리에서 앱 주소 열기
2. 하단 공유 버튼 (□↑) 탭
3. "홈 화면에 추가" 선택

**안드로이드**
1. 크롬에서 앱 주소 열기
2. 우측 상단 점 세 개 탭
3. "홈 화면에 추가" 선택

---

## 💾 데이터베이스 정보
- **Supabase 프로젝트**: https://wblndotsbuejihjembjz.supabase.co
- **테이블**: `records` (통증 기록), `hosps` (병원 기록)
- 데이터는 Supabase에 안전하게 저장됩니다
