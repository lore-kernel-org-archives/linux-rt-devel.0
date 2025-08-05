Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9917279DB2
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 Aug 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407630; cv=none; b=AW534nDlT35uUrBU3hmFxauwA132WV8PJAt2XNM3kz4aH9/c83c32xd8LeUnj8Qw6y2GekObfpdcsLIL+kZfQHNKF6PYeAyu6LWiIYFrg9UgCQn2uw2DwJNgm0NL5lMynpSHWhhKXO8iNFC6oVKTdDFax3kCO7EbbgxdRoM48tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407630; c=relaxed/simple;
	bh=lbWIMGmXSfPP8qxW81xC9fWF8J70sLsBiiZS09J+PqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/dKltzKLdsZjb6TdeuVM62cHmKydoBmrJbd/cx8iqjqN2R+9XXaayPsjYUAhLT6krFx6waJgYO0ZEk33MAwdPMSKeVJXwqgIlnmRbRREFl+gLWQ6UI2MUII1oTezEalG3+e+73o/exwE+iFO1UMT912enFVmj4OzUonV9K/EgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76624ecc7efso535152b3a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 05 Aug 2025 08:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407628; x=1755012428;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pr6DrCEDv+a0jbLHVvBac89tThXy65vIV2bUWnsRig=;
        b=vlv6tEhYcDWVWxWNTtqzm3cxvelyvAb2hVsyH/53D7plr/30yeacSYT+ESIotzKSLE
         bbXqo0ZOLRUQny1iYUf/Wg161rnX/6bSvJHPpbvO2P3/qHZe0EOgn+1l2VUYNKiSJz09
         fZ3NpsI+tXIKGiu8W3hNOErSzW5KGQCeEl0vb6HN/T0ddn44wYTFFwVloDK8P4X28zrP
         awoDy8SHYDQQhhNs1x53w4kToVnShnrD6YNVfU7gMSo8B2yyCufuCOdsqbXa922O+1bS
         38oPuZTcOwGc/jqEuYDPFmRI7LieF9fw/9Xn9VzrOwjcVDi14aqjSVPAlHmZqKgyjy6R
         JAvg==
X-Forwarded-Encrypted: i=1; AJvYcCVTEYPJP2ZAPgjP8Zu7SGAmzkLqwy9tndwCunMXoyUodklbZEDNj8wx8glCHBEpNZzTi9Gju9l6GGlYw0+5pg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1gZyGT5JlWmwNmP94PxJ1YWUixeyhTlHAYQrni5BH5i96spj6
	V5gUUiBOGiU+ak6SrwVXMS/g1uTw59weXP8e2WJQM91FKCGc/6bdpzof
X-Gm-Gg: ASbGncvj2EyshuHm61AE7FRN1Lf52oUkBcyRLncM7WXi05TBqBfCuse1TZC+amnpfug
	23KQW1SYh+njUgVtfkdeIVi5iheg+UmknA2DIEPYNzvuYsSEvLXZgsvMvf6B9dHxY1t0qA8gQVb
	h2F7H+409vLj90vXs5JBBs8XjKPI/XYTn1yaIfzaPe8TsV/VMcEg7liL50yVnKUe8eXus4YQtri
	tzCyO/HZJ5mQw/NnHwElWSh04z2Dk72WwMUxmmaQeqQGS5xttOyBDGwlNBwZhWqB96W0kn+7MN4
	dsxj4pwV8LuDzBNad9ddSzwZ14/+TDwdQkZ8rU6Pmm7jMmYSQlAmGH8uOSU0/z2IohRncFiexna
	NVw5uuszshsydOPauUm8r8nl29m19QAyw
X-Google-Smtp-Source: AGHT+IEsKFfKhbmomJLvjN9Tv+WNDm8mFlc7vYZxJMukrVF3+0b0N+h3Y50ODx8JttQHR39Cg6w5ow==
X-Received: by 2002:a05:6a00:856:b0:747:ae55:12e with SMTP id d2e1a72fcca58-76bec2ee69amr7829469b3a.1.1754407627955;
        Tue, 05 Aug 2025 08:27:07 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce929aesm13090519b3a.49.2025.08.05.08.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:27:07 -0700 (PDT)
Message-ID: <ddd14f62-b6c9-4984-84be-6c999ea92e30@kzalloc.com>
Date: Wed, 6 Aug 2025 00:27:01 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] kcov, usb: Fix invalid context sleep in softirq
 path on PREEMPT_RT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
 Yeoreum Yun <yeoreum.yun@arm.com>, ppbuk5246@gmail.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250803072044.572733-2-ysk@kzalloc.com>
 <20250804122405.3e9d83ed@gandalf.local.home>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250804122405.3e9d83ed@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steve,

You're absolutely right to ask for clarification, and I now realize that
I didn’t explain the background clearly enough in my cover letter.

On 8/5/25 1:24 오전, Steven Rostedt wrote:
> On Sun,  3 Aug 2025 07:20:41 +0000
> Yunseong Kim <ysk@kzalloc.com> wrote:
> 
>> This patch series resolves a sleeping function called from invalid context
>> bug that occurs when fuzzing USB with syzkaller on a PREEMPT_RT kernel.
>>
>> The regression was introduced by the interaction of two separate patches:
>> one that made kcov's internal locks sleep on PREEMPT_RT for better latency
> 
> Just so I fully understand this change. It is basically reverting the
> "better latency" changes? That is, with KCOV anyone running with PREEMPT_RT
> can expect non deterministic latency behavior?

The regression results from the interaction of two changes — and in my original
description, I inaccurately characterized one of them as being 
"for better latency." That was misleading.

The first change d5d2c51 replaced spin_lock_irqsave() with local_lock_irqsave()
in KCOV to ensure compatibility with PREEMPT_RT. This avoided using a
potentially sleeping lock with interrupts disabled.
At the time, as Sebastian noted:

 "There is no compelling reason to change the lock type to raw_spin_lock_t...
  Changing it would require to move memory allocation and deallocation outside
  of the locked section."

However, the situation changed after another patch 8fea0c8 converted the USB
HCD tasklet to a BH workqueue. As a result, usb_giveback_urb_bh() began running
with interrupts enabled, and the KCOV remote coverage collection section in
this path became re-entrant. To prevent nested coverage sections — which KCOV
doesn’t support — kcov_remote_start_usb_softirq() was updated to explicitly
disable interrupts during coverage collection f85d39d.

This combination — using a local_lock (which can sleep on RT) alongside
local_irq_save() — inadvertently created a scenario where a sleeping lock was
acquired in atomic context, triggering a kernel BUG on PREEMPT_RT.

So while the original KCOV locking change didn't require raw spinlocks at
the time, it became effectively incompatible with the USB softirq use case once
that path began relying on interrupt disabling for correctness. In this sense,
the "no compelling reason" eventually turned into a "necessary compromise."

To clarify: this patch series doesn't revert the previous change entirely.
It keeps the local_lock behavior for task context (where it's safe and
appropriate), but ensures atomic safety in interrupt/softirq contexts by
using raw spinlocks selectively where needed.

> This should be fully documented. I assume this will not be a problem as
> kcov is more for debugging and should not be enabled in production.
> 
> -- Steve
> 

Thanks again for raising this — I’ll make sure the changelog documents this
interaction more clearly.

Best regards,
Yunseong Kim
