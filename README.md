# 👣 발 통증 일기

발/손 통증을 기록하고 AI로 분석하는 개인 웹앱

**앱 주소**: https://schoyeon.github.io/foot

---

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
