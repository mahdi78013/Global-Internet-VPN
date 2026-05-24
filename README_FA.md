# 🌐 اینترنت آزاد³⁶⁹

[![GitHub](https://img.shields.io/badge/GitHub-Global--Internet--VPN-blue?logo=github)](https://github.com/mahdi78013/Global-Internet-VPN)
[![Telegram](https://img.shields.io/badge/Telegram-muntivpn-blue?logo=telegram)](https://t.me/muntivpn)

**زبان:** [English](README.md) | فارسی

**کانال تلگرام 📣:** [https://t.me/muntivpn](https://t.me/muntivpn) | @muntivpn

**گروه تلگرام 📣:** [https://t.me/+gklMAfodGdE3MGRk](https://t.me/+gklMAfodGdE3MGRk)

اینترنت آزاد³⁶⁹ یه ابزار یک‌کلیکه برای دور زدن فیلترینگ اینترنت در ویندوز. فقط `Global-Internet.bat` رو اجرا کن — همه چیز خودکار راه‌اندازی میشه.

```text
مرورگر -> پراکسی محلی -> مسیر Google -> رله Apps Script شما -> سایت مقصد
                         فیلتر فقط اتصال شبیه Google را می‌بیند
```

## شروع سریع ⚡

### مرحله ۱ — ساخت رله Google ☁️

1. وارد [Google Apps Script](https://script.google.com/) بشو
2. روی **New project** کلیک کن و محتوای پیش‌فرض رو پاک کن
3. فایل `apps_script/Code.gs` رو باز کن، همه چیز رو کپی و Paste کن
4. این خط رو پیدا کن و یه رمز طولانی بذار:
   ```javascript
   const AUTH_KEY = "یه-رمز-طولانی-اینجا-بذار";
   ```
5. از مسیر **Deploy** ← **New deployment** ← **Web app** برو
6. گزینه **Execute as** رو **Me** و **Who has access** رو **Anyone** بذار
7. روی **Deploy** کلیک کن و **Deployment ID** رو کپی کن

این دو مقدار رو نگه دار:
- `Deployment ID` از Google Apps Script
- `AUTH_KEY` — باید با `auth_key` توی کانفیگ یکی باشه

### مرحله ۲ — دانلود

**گزینه الف: ZIP**

[⬇️ دانلود پروژه](https://github.com/mahdi78013/Global-Internet-VPN/archive/refs/heads/main.zip)

**گزینه ب: Git**

```bash
git clone https://github.com/mahdi78013/Global-Internet-VPN.git
cd Global-Internet-VPN
```

### مرحله ۳ — اجرا

فایل `Global-Internet.bat` رو دوبار کلیک کن.

اولین بار یه wizard باز میشه که Deployment ID و Auth Key رو ازت می‌خواد — بعدش دیگه نمی‌خواد. پروکسی سیستم خودکار ست میشه و میانبر دسکتاپ ساخته میشه.

> ⚠️ **این پنجره رو باز نگه دار** — بستنش VPN رو قطع می‌کنه و پروکسی رو پاک می‌کنه

## تنظیمات پروکسی مرورگر ⚙️

اگه خودکار تنظیم نشد، دستی وارد کن:

| فیلد | مقدار |
|------|-------|
| نوع پراکسی | HTTP |
| آدرس | `127.0.0.1` |
| پورت | `8085` |
| پورت SOCKS5 | `1080` |

## نیازمندی‌ها 📋

- ویندوز ۱۰ یا ۱۱
- [Python 3.8+](https://www.python.org/downloads/) — موقع نصب تیک **Add Python to PATH** رو بزن

## مشکلات رایج 🛠️

- **خطای certificate** → [بخش رفع مشکل](docs/fa/TROUBLESHOOTING.md) رو ببین
- **خطای `unauthorized`** → مطمئن شو `AUTH_KEY` توی `Code.gs` با `auth_key` توی `config.json` یکیه
- **نصب وابستگی‌ها شکست خورد** → یه VPN دیگه روشن کن تا pip وصل بشه، بعد دوباره اجرا کن

## پشتیبانی 📣

- کانال تلگرام: [https://t.me/muntivpn](https://t.me/muntivpn)
- گروه تلگرام: [https://t.me/+gklMAfodGdE3MGRk](https://t.me/+gklMAfodGdE3MGRk)

## امنیت 🔒

فایل `config.json`، مقدار `auth_key` و پوشه `ca/` رو با کسی share نکن. این پروژه برای استفاده شخصی و آموزشیه.

## سلب مسئولیت قانونی ⚠️

- مسئولیت رعایت قوانین محلی و بین‌المللی با کاربر است
- توسعه‌دهندگان در قبال هرگونه خسارت مسئول نیستند
- رعایت شرایط سرویس Google بر عهده کاربر است

## Credits

این پروژه نسخه بهبودیافته‌ی [MasterHttpRelayVPN](https://github.com/masterking32/MasterHttpRelayVPN) ساخته [masterking32](https://github.com/masterking32) است. ما تغییرات و بهبودهایی روی پروژه اصلی اعمال کرده‌ایم.

## License

MIT
