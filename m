Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D32EB858
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610319; cv=none; b=J/0iO5JJxvoDduNhZBSLeV+NG0ql8LYDuWRRXe9+GeNSsPCsEERuFVm8xPrJu5aLzJztquNSuR4XNoA0EpdCEF/mu3bMmPiaIW2AJPKFQQqgBVcbKTmPzx+HDBRKp3gYVhczgeSIfUi3/4K+sZYpZcL+/28ya4nOKjpvNCKgF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610319; c=relaxed/simple;
	bh=YOWuOvXp8Yh+4tpnkb1YtqwLLeaFoLleda5Z+WQNqx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opWaUjmgQeA3EuBCwkgnJEV3u55kkr8QrA9+VufmPhuMUtX4Zm17BqS6FKGrloQQb2q+GF0XO9BZSNCqnRo8O02dBoAFJ157Jo7CsTf1rEt1egvMP9ZAPgN9z052ks14Ip8+RaNUYVUOcIzIhyvudpH1aePUSBHerLlrlvOKXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsEu8iTv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsEu8iTv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2901238b3a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755610316; x=1756215116; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRmcafjLK/bUe3QVBcZSTxEMW/hT2fpAZCLoRLeyHpQ=;
        b=TsEu8iTvrlts3Gld1jjIdWsD8Y87tfxKH3Gi/Mhiv0AMGCTSEKn75cJUlKv/HLdfHW
         nryXDdWWlLYkJdedUz0hr7eKHrf6HRki/UTdxZ3bBWLnsmZbruP5dhjN+FQzPWuiuqaV
         rskysInHvT1fiovKj221ffZT2Si7h34pxYs9M5qwfE773d2Oi2Lb+LVhjXR7nCO7+Qf9
         /oGScbrTaiUTNs6mL6A/a2OqRoBIpZaTy40HPdcx/YxEQs2dqkP54qgelEeHgeS9iLeV
         qr1kckzHKwbZLgdmnTqMaS0m5euzs1yHOqhAEIASI05ELX9YtGFSLHYB3y3x2RSeg6sB
         5Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610316; x=1756215116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRmcafjLK/bUe3QVBcZSTxEMW/hT2fpAZCLoRLeyHpQ=;
        b=jE3ax4HSzpYzFQC9xS2YwIR3cfeJuPbvQMz3z1M5eftMbmy6FAF6MLRIq7GQV37ofC
         wOqI0LkudUmLBKt+eE42L2wSM+xK7LMrsnJ23FLGpQurLQelIECiLzoxP8oOEQTRqsgI
         kdlcVMtDN7yd76YKryCZuSKg8COwo9YJ8n07ZoMtzuAnEzktTDCDyFOz2zG7RuW44DX3
         GXlnU5BpxcwFV3vNnhX12c0TUrWxyQxeVtJFlHyK3vFkByidFJZ+ZdbCUsorRknESIWl
         eAHub2BvFWRhtBTTXEwt+XnbDsjFAuqIKQceq1jyYUyIGpYJWfKYgo1PcK5TjIrrDJ8W
         aVQw==
X-Forwarded-Encrypted: i=1; AJvYcCWnXoRrQas71ej4zRRKU/U6dhezrqAN5kM8/V1dt3psBu0nlkOcUtJw8QcvHI5rSiUMh3cVrwLgWEP0YghKcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxazDE0QxQEoDC+vm7dqTtJ0xyhh7Kafw1TVlkEzVHQgIXnQa7J
	b3kKKhnyuRo8Y4KGE9KAISBMTFt2ClT8aSqaXqv4AN4Ktxljb8HT8vue
X-Gm-Gg: ASbGnctdXXTaLt5fgFtMbx6endNjUyAF8kDOzc1eU+Eak8HLZtYU1zwkahUjzOSCfm5
	b8EHLVo0j1CrGTZme5LNWxr448z8r/1FAlkhBw+pV7v7x90/+eWlpoq4mNdc98FWnXBIzJPbaN4
	ptg2+xWrnoeB4u2Ht4TEoBpkPwfgtreap2fQGyZ9Cgw2eJGHJAiAu9dY8GX/JFyC93v7oLnm5KB
	eQjQv5PDPNtcXRERTe5AROMKMYss612L64mQdkKjZu6AGP0s6xePraSaPe2BCprUrWSdKc8Z+XL
	WtAbBGX2POr+WRlTuu06jv1eg0oAcJLiPtxwj4nKiWRykkKyZ5IWTgOvZ9/Fh59/UwD8+jf+Ip+
	nh0VkKIr60as0RBZI54CGIYi+/mbfUoGNSrgCFe3/TUOvbQrZc421qkcaSjX/VNXztJw=
X-Google-Smtp-Source: AGHT+IGHwMFf1Q2ZU3OCGcqXj35XfKNBWk9FMiaKSJAbgclkE6zyl5GtbMaE1KB/or/Tiwr5taj28A==
X-Received: by 2002:a05:6a21:3298:b0:243:78a:8299 with SMTP id adf61e73a8af0-2430d49d8d5mr3621641637.50.1755610315907;
        Tue, 19 Aug 2025 06:31:55 -0700 (PDT)
Received: from fedora.. (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cdfsm2517490b3a.63.2025.08.19.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:31:55 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: cuiguoqi@kylinos.cn
Cc: akpm@linux-foundation.org,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	farbere@amazon.com,
	feng.tang@linux.alibaba.com,
	guoqi0226@163.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	namcao@linutronix.de,
	pmladek@suse.com,
	rostedt@goodmis.org,
	sravankumarlpu@gmail.com,
	takakura@valinux.co.jp,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] printk: Fix panic log flush to serial console during kdump in PREEMPT_RT kernels
Date: Tue, 19 Aug 2025 13:31:49 +0000
Message-ID: <20250819133149.7452-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250807112247.170127-1-cuiguoqi@kylinos.cn>
References: <20250807112247.170127-1-cuiguoqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi cuiguoqi!

I'm not an expert on the subject, but hope this helps.

On Thu,  7 Aug 2025 19:22:47 +0800, cuiguoqi wrote:
>When a system running a real-time (PREEMPT_RT) kernel panics and triggers kdump,
>the critical log messages (e.g., panic reason, stack traces) may fail to appear
>on the serial console.
>
>When kdump cannot be used properly, serial console logs are crucial,
>whether for diagnosing kdump issues or troubleshooting the underlying problem.

The console not being flushed in the case of kexec should be expected
as described [0]. Its about prioritizing kexec over serial output.

>This issue arises due to synchronization or deferred flushing of the printk buffer
>in real-time contexts, where preemptible console locks or delayed workqueues prevent
>timely log output before kexec transitions to the crash kernel.
>
> /**
>  * kexec_image_info - For debugging output.
>@@ -176,6 +177,9 @@ void machine_kexec(struct kimage *kimage)
> 
> 	pr_info("Bye!\n");
> 
>+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_kexec_crash)
>+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>+

Calling console_flush_on_panic() while trying to kexec will
reduce its chance of success.

>diff --git a/kernel/panic.c b/kernel/panic.c
>index 72fcbb5..e0ad0df 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -437,6 +437,8 @@ void vpanic(const char *fmt, va_list args)
> 	 */
> 	kgdb_panic(buf);
> 
>+	printk_legacy_allow_panic_sync();
>+
> 	/*
> 	 * If we have crashed and we have a crash kernel loaded let it handle
> 	 * everything else.
>@@ -450,8 +452,6 @@ void vpanic(const char *fmt, va_list args)
> 
> 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> 
>-	printk_legacy_allow_panic_sync();
>-

The ordering here should be kept where we don't want CPUs other than
the one panicked flushing legacy consoles.

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/847cagmjsx.fsf@jogness.linutronix.de/
