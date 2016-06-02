# Bubble project

## 실환경 구축 방법

[reCAPTCHA API key](https://www.google.com/recaptcha)를 얻어서 /data/bubble/shared/config/env.yml에 등록합니다.

```
production:
  ....
  RECAPTCHA_PUBLIC_KEY: 'xxx'
  RECAPTCHA_PRIVATE_KEY: 'yyy'
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
