Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A21E47B9
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227045; cv=none; b=FzPd8ekKRXIATNBLKpTVdI4pp4SU+Osfbb+oPpm1gCXAhus3KKmSd5DI2KbSDD6w3GNCrxDywmtYjOiFOEgrdo5IR+IE0Sv1VcsHsjhI1CD0b/6E4FpyD4eci6aY4zBqTVqkVktbAhX/mDcop4USBp+tQTw3jc0zrp2OxGWJ7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227045; c=relaxed/simple;
	bh=khwkbIDCszP/+KVApvrUbi0r1WWmsW7fGF0p/ciUWuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXnSmEt4Ts4CNTWsOQ9OJ8SYgrtJDPdNBIJb43u9SmE3jMLpMCmKrsmC84wFe5VmVU6qwVNrM7zl0/LRS1JJQOaoyqHSm5Kg6hAryogqsEtXztwG4ZHP0/TfoaG2iXNLw/qIECsDAdVeW9d6vUSKEew4ld/1X5I/q8dCpmGzTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AddHR/Af; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AddHR/Af"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2154e3af730so30405655ad.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Dec 2024 03:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733227042; x=1733831842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKRQ6IxMwfzftYtehq3noAFU/07+jHyxPSa3A0Pbh4g=;
        b=AddHR/AfzKYUl9b0jS/LaeljiwG6G20reiz77KJUogMAYEkqP68EcZ6wRCUdSZRlsY
         t+vWDrr6VObfzrizF1R4ygaxK5+1Bvyv83Nrl6o5JIJsFeHwnOaoZIFU1V6AMhiVJglM
         6IvMeq2Zltyqb30+nvevQ50gHxv9QPtfhjQEqpWM1GIye1zc/9ppH5CYMADM1+Q+ma8k
         6+1eNBJUkx5cRrDtngFFnBVQZl5EXA1xK+Ow4hF4bgTrqERJu+5k3l4/aYSm9qUnESiy
         TE+Z3l9NS1n/Vk+YgnTgsOnmXYyFJaSYbDrZtt2/XYKaORwhwQ7ZzgLGaw/Q4yl7dxkf
         nDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227042; x=1733831842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKRQ6IxMwfzftYtehq3noAFU/07+jHyxPSa3A0Pbh4g=;
        b=CFPIdpsFSwNndQS3UGonI5ohk+OkkBAt35AvJAFB3X/EdpylfUQu5ZuGrPryKvoAhg
         L7vsQSru0vhVkD8Bd0F4knUF+x6mKvhf2XRNQaFNIIclzDF2arK6sjmUarYg6o/qOONk
         LLhGA/4U50+iuhpDDoLTJ5mSwI7jf6tI+uwm26n0zaANylHUmXLrHm0S91kI8dNSqvKt
         qVfczGmbJPNwh/PQD0OUtBd7x/VjSJL7i9q7cuHNI/oUeHFxIksv/fvaZOlrOp9IJzB+
         q8VN1BYjsCBXugqHaHWGswJv1nlpA48eg9R/Y+DmNpnSRTMbU1UiqxyCsSkGfEgHo3tj
         h0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+wivWbUJO3w5hdWZUM1nPPyRQa8dp4hQ3wJ2etkHGDe+uGMuc+B1w7s1sn9luSMZkZzroAfVVDp7b8K11Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYDxnqe4SVsbe5AEszgShzwG8nhSNkT/sYgkNMmSltissH/NDU
	ONGh/qENrTXLSfY+qvsk0zqTcM+WMEiDw65sr7jFFVL+eLnwE0iq
X-Gm-Gg: ASbGnctJ+QMLHpUU7CBqBWeieTctIvnMsCQt9BQswbpf71zgfkZThmVFolskLZqvCA7
	qGkYuUxUCn/6jM5yXpEk/EnHSCEkrj8u1kWz9CelCX4XwUSV+bo4vyJY3u0kYfkmyhNle4/WQ/R
	EAXMpYFol++wubZJjz2WR91bsOFHlFt9Wn6bEXnImsAwyrH19GWg9ons7YMKZCYhBFALfwDf6M3
	FPr+s597zorIemw154/0ymcyOINbsN+Fzx+Jf9ovA/mJCNkLeibOAQvVDR/1Km2yB/k6aa532D0
	SUr8lDAtJn1ZtgjjeVKS
X-Google-Smtp-Source: AGHT+IG/RBtDwHnS+MInoLH6AJ58yixmDJXlnlpRPfaSWGHErFouFH+/FTivlsNbjVccSHfhRIounw==
X-Received: by 2002:a17:903:1790:b0:215:8550:a95d with SMTP id d9443c01a7336-215bd13df18mr37361315ad.52.1733227042613;
        Tue, 03 Dec 2024 03:57:22 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157fad0031sm42654835ad.35.2024.12.03.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:57:22 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: boqun.feng@gmail.com,
	peterz@infradead.org
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Tue,  3 Dec 2024 20:57:17 +0900
Message-Id: <20241203115717.62392-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z064BAsxrEe5zQV7@boqun-archlinux>
References: <Z064BAsxrEe5zQV7@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter and Boqun,
Thanks for getting back!

On Mon, 2 Dec 2024 23:49:24 -0800, Boqun Feng wrote:
>On Mon, Dec 02, 2024 at 11:32:28AM +0100, Peter Zijlstra wrote:
>> On Mon, Dec 02, 2024 at 10:20:17AM +0900, Ryo Takakura wrote:
>> > Commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
>> > PREEMPT_RT.") stopped updating @softirq_context on PREEMPT_RT
>> > to ignore "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage"
>> > as the report accounts softirq context which PREEMPT_RT doesn't
>> > have to.
>> > 
>> > However, wait context check still needs to report mutex usage
>> > within softirq, even when its threaded on PREEMPT_RT. The check
>> > is failing to report the usage as task_wait_context() checks if
>> > its in softirq by referencing @softirq_context, ending up not 
>> > assigning the correct wait type of LD_WAIT_CONFIG for PREEMPT_RT's
>> > softirq.
>> > 
>> > [    0.184549]   | wait context tests |
>> > [    0.184549]   --------------------------------------------------------------------------
>> > [    0.184549]                                  | rcu  | raw  | spin |mutex |
>> > [    0.184549]   --------------------------------------------------------------------------
>> > [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
>> > [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
>> > [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
>> > 
>> > Account softirq context but only when !PREEMPT_RT so that
>> > task_wait_context() returns LD_WAIT_CONFIG as intended.
>> > 
>> > Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> > 
>> > 
>> > ---
>> > 
>> > Hi! 
>> > 
>> > I wasn't able come up with a way to fix the wait context test while 
>> > keeping the commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting 
>> > on PREEMPT_RT.") without referencing @softirq_context...
>> > Hoping to get a feedback on it!
>> > 
>> > Also I wonder if the test can be skipped as I believe its taken care 
>
>Skipping the test would be awful because tests are supposed to catch
>unexpected bugs :/
>
>> > by spinlock wait context test since the PREEMPT_RT's softirq context is 
>> > protected by local_lock which is mapped to rt_spinlock.
>> 
>> Right,.. so I remember talking about this with Boqun, and I think we
>> were going to 'fix' the test, but I can't quite remember.
>> 
>> Perhaps adding the local_lock to SOFTIRQ_ENTER?
>
>So I took a look, SOFTIRQ_ENTER() already calls local_bh_disable(),
>which is supposed to acquire a local_lock "softirq_ctrl.lock" (Ryo, I
>believe this is the local_lock you mentioned above?) in normal cases.

Yes, and I was assuming the normal case...

Since Peter's feedback, I was just wondering why the wait context 
selftest was not reporting anything if the local_lock were already 
acquired (answered below!).

>However, if local_bh_disable() is called with preempt disabled, then no
>local_lock will be acquired. For example, if you do:
>
>	preempt_disable();
>	local_bh_disable();
>	preempt_enable();
>	mutex_lock();
>
>no local_lock will be acquired, therefore check_wait_context() will
>report nothing. The fun part of "why this caused an issue in the lockdep
>selftests?" is these tests are run with preempt_count() == 1 ;-) I guess
>this is because we run these in early stage of kernel booting? Will take
>a look tomorrow.

I see! That is indeed quite fun!

>Maybe the right way to fix this is adding a conceptual local_lock for
>BH disable like below.
>
>Regards,
>Boqun
>
>------------------------->8
>diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>index fc53e0ad56d9..d5b898588277 100644
>--- a/include/linux/bottom_half.h
>+++ b/include/linux/bottom_half.h
>@@ -4,6 +4,7 @@
> 
> #include <linux/instruction_pointer.h>
> #include <linux/preempt.h>
>+#include <linux/lockdep.h>
> 
> #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
> extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
>@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
> }
> #endif
> 
>+extern struct lockdep_map bh_lock_map;
>+
> static inline void local_bh_disable(void)
> {
> 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>+	lock_map_acquire(&bh_lock_map);
> }
> 
> extern void _local_bh_enable(void);
>@@ -25,6 +29,7 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> 
> static inline void local_bh_enable_ip(unsigned long ip)
> {
>+	lock_map_release(&bh_lock_map);
> 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> }
> 
>diff --git a/kernel/softirq.c b/kernel/softirq.c
>index 8b41bd13cc3d..17d9bf6e0caf 100644
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
> {
> 	return from;
> }
>+
>+static struct lock_class_key bh_lock_key;
>+struct lockdep_map bh_lock_map = {
>+	.name = "local_bh",
>+	.key = &bh_lock_key,
>+	.wait_type_outer = LD_WAIT_FREE,
>+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>+	.lock_type = LD_LOCK_PERCPU,
>+};
>+EXPORT_SYMBOL_GPL(bh_lock_map);

Let me take a look at it!

Sincerely,
Ryo Takakura
