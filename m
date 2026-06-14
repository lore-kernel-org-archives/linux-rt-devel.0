Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C439DBCB
	for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437311; cv=pass; b=mqV4hMXH4ejLgPqxLm4xqyskxME+c+ljI+7iTovvvjT+PfwEl7R7NQ7OCDmQ4wVGMUE7lXw285ryEMoEXI57C8KMjzVKl9EtjzNu+S0hCPQgQIWTExsC80DpH67/OwTUD/H5VyE7uycb28ApqBzB4JC/rqZ7yy+N6fVa8GoKu5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437311; c=relaxed/simple;
	bh=+QYGK68tYn6kO+42tzFsfF/PI7vOCoxlnLOyNd19xSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rti9K76O32thvp/Zr/Z6fli1k9pCT6mVVp+6es8OA/5ruIYRHfF6JBua0ykNeUptmX1g0SWIydgQWiAdGJIDeIPRM0FXniWTpmWcDY4vnUCMGiTmymD7PGbNtmUWpViqBP/09P29uSnUHYEnXB1PzQ8Rp8tdunxD+KiMOllkDpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=PKOL9Nu/; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="PKOL9Nu/"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4865e953031so2764109b6e.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 04:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437307; cv=none;
        d=google.com; s=arc-20240605;
        b=bzdvDkbDXqmaUukqRItH9Dz4NQp/UoIt4A7Yzy8NhUEyx3yAQxNdBaCBIS4iK+kM5E
         tj37gcOLn+a5wxqj9LMEM9L6a4Jxh7XV7tke8BYoB0fspd79DtzsrKhB0Rdp+pJK4+E6
         4mrmAcUoT1LMpT6HiY+A0TKQDW07Vo+LupGCZUWVbeWyl/AYUk9eCYGHCtr28RNIUNo6
         JnfbhyhfjK4u8WgDCJWX3leGOK8bR1dYoDR8u5JcrqJmMlXOk6QTfCS4AylW3UdLJH6V
         lsYUrUEQCBkwKopd6DN3SOQJJte83uoC7J4mLU9FQzxHR34xgHjNX/w6mBra0LgFzk7j
         mUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+QYGK68tYn6kO+42tzFsfF/PI7vOCoxlnLOyNd19xSA=;
        fh=81hLe3/Jd6e7cQ4NWh4ob3LLOcAF6Lkr+tBRScq0Pu0=;
        b=iTINj06Kxh1lJ5igT+uDgPt2gkZqvG//sxGMj8ZyV9fxIwCPcb5GHZjl1jUcPFRTRJ
         /3nZXuU9HlmVz5fBHIfA5DzeDwlPNZAs/90WzWsAXFbS5MdNoL8fw1GWn+Lg4rehoEPA
         vui5aicdYlwAPdr8gM8dM8vZiHSLtJhvV4RgoCHPfav6lvo9qyJsFGb2S4QvP9u40Y2s
         yaM1q0KYpOBirL0RbZORoe4awgXQw+CzI/FPWYx1EsSnKrzIOwqXqHpMBDtBVSFU5VYD
         2bLATnhsSM2/mCiOdoqE9ZjqGYCjr53hT8yp/0B0SIJJ8Zg6jYp5DzRH2c7/dUz3bkPo
         zb0Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781437307; x=1782042107; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QYGK68tYn6kO+42tzFsfF/PI7vOCoxlnLOyNd19xSA=;
        b=PKOL9Nu/SgCEWx1lMyhjSaAg3FDwJvea6UTJFaWVZHSxCyQTXcC4TSgS6xHN3O0SsE
         AR6ew06T3G2CKfMrZrMy7EqNZ3URYrK6zRYMgzPFS5vLOJnN0HSRP9sVduU0SU2OUF2j
         zLEbazTXwJF8AECHxY7ubAYN4oM3kAnCcXBnmN0sQRq746SYQyc0vVhT+DShN8x+ECbK
         m4R+xxQMSd5PeUU7p5KxsJvk8MxOepXIWZn/9tj/p1E6VnVGkDsI3EVy2bipG6Q8fcKq
         Oe8Io2zEyIc8jsCuSlxtbmlBIflxTVrt8jURSNB5B4kEr9mv9oeTrz5pRk2N6APNXyru
         NduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781437307; x=1782042107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QYGK68tYn6kO+42tzFsfF/PI7vOCoxlnLOyNd19xSA=;
        b=KTWDuXKey+fUFcDQzRa+/HcyQwH7uLk9zDCaPJpXYAL9f9PATQAjh9e308AK/UBbDP
         e95AHsLr8I4iUX9RzDNm81pEkTUfwdjR+fMeWdrfjyiwTPRp4mpCXbK5XjVx0euZov9S
         IbTyH1aDOQjWgnsCbquOW94L/SB/qWKnt1Iwqv5Dm3URjBuwBZgN5XEhzbc4zUM50cG7
         4xZPglY8XldNY6LqqaZPvvinwLdcibCJk8H3oGdp4RP9HWHjoDKgfuXHlGSQ6aahjmCN
         PqV0Da72SM3ugraPsP2jHVFMq4srV7vIzuY1toDwWelClXvNAOsx8A4GkDsV8oD+U/cg
         C9EA==
X-Forwarded-Encrypted: i=1; AFNElJ/lL+NZqFHYI3rg8VhMwEb8JLsUAhNrIb802fRt7cuhnwYMGw29xQyj0bT9tTq3S3qDVgEXHk6ARwKw3qaCLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRgt68oB5tD/F57+HIOzdk5dsegFSCWtJz0MJflxacs4ePHfBR
	gXgisiQC8k3FSXXXQoSFY/wHDtBEQVwPgas5KA3xi+WXRvTf5UTHTa+ywBsbh7/3QBO6n8/C3HU
	1XvW6Bk60O14tUu+MVwk6moxpsAAFZJ6DJvtnPPgJiQ==
X-Gm-Gg: Acq92OElRRujUr08MSR8nQswoP89CuTGiRmai/wzfCnC2eYmREa1rPlev/6PIkMNuck
	99zs28wXrnw/ymeyUWaN3PIkcY3Znm6fFIZthUXxn9RoJ8TJjNko4ctHiBwSQUViHh5XgoqZPMF
	jORRJIR3PMibtM3TaHp928kSEh8W2AFWGEwtV1vUmm33BsWc+13KW8m17vUkepdd4OxTln8jTND
	cDQhXlOd3n8nvtOrKMsqb5rKKK2HWX+Ha1+1ycEnZbKyXIGe3LS3h1Ofip5aKtQFdk/rQJWn+HM
	YKfwfpylPWggFmIVjWQ9JYiEXmdNw/NrhXVrW/FdSqdT546g7BlKb3bZ8zPG3vN/D5jdpsvRzTI
	XoDNH3YEe/U/74At79l01c9NKHqXI1MWD7zUiZ9LgB+SD64/mow==
X-Received: by 2002:a05:6808:5146:b0:485:4f07:eefc with SMTP id
 5614622812f47-4872de6bf08mr6368667b6e.15.1781437307489; Sun, 14 Jun 2026
 04:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-1-c34c187142a6@thegoodpenguin.co.uk> <aibCBGjVk4yqtYyT@pathway.suse.cz>
In-Reply-To: <aibCBGjVk4yqtYyT@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 14 Jun 2026 12:41:36 +0100
X-Gm-Features: AVVi8CeTwM4IEIAOmwN1jpA0UXhc3pxjWDCeUhdF0IP9jBqM1u8l5Way85027k8
Message-ID: <CALqELGy7nET5bRhq-0tf2pWgK7h_f0uyrsj9BAwGMH-tmf8AAg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] printk: remove BOOT_PRINTK_DELAY config option
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 14:22, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2026-06-01 00:17:37, Andrew Murray wrote:
> > The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> > are two distinct mechanisms for providing similar functionality which add a
> > delay prior to each printed printk message.
> >
> > In preparation of combining them into a single configurable feature, let's
> > first remove the kconfig option BOOT_PRINTK_DELAY.
> >
> > Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
>
> The option allowed to reduce a bit the vmlinux size when people were
> not interested into the functionality. I am not sure if it is worth
> it though. I am personally fine with this change.

I hadn't considered that need.

I'm happy to add this back in, but it would only make sense if this
option covered both boot_delay and printk_delay. That would change the
meaning of this existing Kconfig option, and would also allow the
removal of the printk_delay sysctl, I'm not sure if userspace assumes
this will always be there (probably not).

I'll leave this as is, unless there are objections.

Thanks,

Andrew Murray

>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr
