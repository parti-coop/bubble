# Bubble project

## 실환경 구축 방법

[reCAPTCHA API key](https://www.google.com/recaptcha)를 얻어서 /data/bubble/shared/config/env.yml에 등록합니다.

```
production:
  ....
  RECAPTCHA_PUBLIC_KEY: 'xxx'
  RECAPTCHA_PRIVATE_KEY: 'yyy'
```

페이스북, 트위터, 네이버를 연결합니다. 각 키는 /data/bubble/shared/config/env.yml에 등록합니다. 트위터는 사용자 email을 얻어오기 위해 twitter에 따로 요청해야합니다.

```
production:
  ...
  FACEBOOK_APP_ID: xx
  FACEBOOK_APP_SECRET: xx
  TWITTER_APP_ID: xx
  TWITTER_APP_SECRET: xx
  NAVER_KEY: xx
  NAVER_SECRET: xx
```

## 로컬 개발 환경 구축 방법

기본적인 Rail 개발 환경에 rbenv를 이용합니다.

```
$ rbenv install 2.2.3
$ bundle install
$ bundle exec rake db:migrate
```

### 초기 데이터 추가

[mbleigh/seed-fu](https://github.com/mbleigh/seed-fu) 을 이용하여 설정된 초기 데이터를 로딩합니다.

```
$ bundle exec rake db:seed_fu
```
