Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3852558BB
	for <linux-rt-devel@lists.linux.dev>; Sat, 21 Dec 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734758279; cv=none; b=aHuljrvuW44X8n3HkSgBxZe0VtyYrwFd5YJ2DcgvFoK6zZNe8JukIMMdhDFxjTcW4xSd7khcrqtxrwk8fC7TmRsMVZml9eK5hBKEvlWf8sgY6c3macEFTkx8eYCITxCrUT4ngquTIGIjJgwuh59+qNt3eBTtdE8mPO3skAYJdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734758279; c=relaxed/simple;
	bh=tdhrviXUyYrOkJpK6TlNLvUEorJ/drEcGIS4XeLFDjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odpt4ipAH9rSq4kG1CuwonXfv+rhRj6xME4hI2JVEeZ7kpq+u6CV1o9bOzQUaKJUPKudWixwsQw7y6o28uvdV60f7Y13KzNrkBMrGrRFTGfZL2vO2dUwSBl/VWIbGZGpeqwLc+P0vpY4IxR3cNzCDdGomBusthqUU5vjVGSRJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adob6G40; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adob6G40"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd526d4d9eso1972537a12.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 21:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734758277; x=1735363077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QC/72JjUekI5hebR4Z81Enr4PkYEQJAIEzWRLgLbhM=;
        b=adob6G40r3DbXAFIBkVj/UfKHkNHCpTeUUFOF5DifvedCj90NCd4kFjTL+knjstxIm
         qEJgWsoBAA1mJ9SUEVqq+bqc2azQPfUBEkIGcAMlGUzwLaA0VfLg2oGVZvrzr4k+fr6/
         mNaWXdVJLLU8nMwEFh9jre9XvKMnHDI5q4vmNlNiAU01cVqRgMh1Qcr182X6tDJP3rus
         8WbAw+L5ihLJei5XEHZgMQKkRLpv5yhYqtbr43bEFRC1yupHIwm2aUIb/N0mp/Jra9xf
         ZPVujYUlllG5RG7WkxOl4nxR5nQ7dDGKdGVWHCYaRFx46nNeZ3qmAVrs3ocAKkwCCcfP
         bHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734758277; x=1735363077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QC/72JjUekI5hebR4Z81Enr4PkYEQJAIEzWRLgLbhM=;
        b=fKvXXg4pBejFHiMQtBE3ObVexHPNdUFFnpS+rWuiFlQEWN4DfGDvRIf/k3B52FWhnp
         Zzzy1boYpmw19QQatKnE/j9KuH+wadRskGHqmkm14N8EluRFdpAI0RDPILV6+iJuI9Gy
         xhl2c+7tlxKSINX1zNh3iM9x1v6fzKfd4ZuVIY8tPLZywIgQSpLhOk/xU1gR9N2NtsUB
         Wey45Dq+5TMEMOlLgXMAQ8Hl9p+TrnhDBsH21cFDT3kjM/VMiQWnulH1t/npAMgjQzaj
         9kvu2xT+15HmE7mYXfPk0ZBOtGaxvc45L+TW7qy095u0EKIo8ugnBM8I90FWs5W6niO6
         LsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1TtKOv/K+qZq2nwRkYt/OwJNAQ/XK4MvfU0+Ty3ZUDoV/j+Il0F8IjkisZB45iUC/ko2Xzz8NZaVMERXVlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWOtgt3S2ncM6v2x1oxTqhSv5eQbzdP1sXt/qmS9mwVzDQNf4f
	wxDw/ETjcNYD1eqjSSs9eJJngF/3V6Znc8G5pXEs2A4vCcHr/EEv
X-Gm-Gg: ASbGnctQKbhkiZoxXEtPIk75rPYf8Jynt1QCJTfxfholQHo10TyUUjQwV9LMao+qnhm
	SasVEy4s/jQKYGpXsPDDLKLsn19h2GBzuZZbYvwaKL2SM/0+7wENzrnbpRzW2rqwzy+HN7zQr5b
	vKA7JaWNIHkxqlw5WGff3ptsMb4f7MilVDYIXJXObV3Maplt3INGfapn8OuNR2dC1aXImqc3hUo
	dKCqDw2kZLFvJo5Dub9tmKI+i5UEwp8ro6vBjgu+X/GjD/NFzamuPoeT15+c7/v05CsAdI22DnR
	v8HU42SCUqKm6/ZkiTndWPZ8rDyYXerw5BP9agTCwX9GeCfY
X-Google-Smtp-Source: AGHT+IFsYfJId669Yi/Z8RdORPq00z/V5HFURF3oX5eKRxEQc/+OrwIJnkALp4TOdHaEOZByd6fzuw==
X-Received: by 2002:a17:903:234e:b0:216:46f4:7e3d with SMTP id d9443c01a7336-219e6e9fa68mr75551895ad.15.1734758277123;
        Fri, 20 Dec 2024 21:17:57 -0800 (PST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85efb81sm3672181a12.41.2024.12.20.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 21:17:56 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: boqun.feng@gmail.com,
	bigeasy@linutronix.de
Cc: clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Sat, 21 Dec 2024 14:17:32 +0900
Message-Id: <20241221051732.218496-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2W-veam4RP1C6zM@boqun-archlinux>
References: <Z2W-veam4RP1C6zM@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Dec 2024 11:00:13 -0800, Boqun Feng wrote:
>On Sat, Dec 21, 2024 at 01:10:16AM +0900, Ryo Takakura wrote:
>> On Thu, 19 Dec 2024 14:27:11 -0800, Boqun Feng wrote:
>> >The following is the rough idea:
>> >
>> >Regards,
>> >Boqun
>> >
>> >----->8
>> >diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>> >index fc53e0ad56d9..7191a753e983 100644
>> >--- a/include/linux/bottom_half.h
>> >+++ b/include/linux/bottom_half.h
>> >@@ -4,6 +4,7 @@
>> > 
>> > #include <linux/instruction_pointer.h>
>> > #include <linux/preempt.h>
>> >+#include <linux/lockdep.h>
>> > 
>> > #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
>> > extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
>> >@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
>> > }
>> > #endif
>> > 
>> >+extern struct lockdep_map bh_lock_map;
>> >+
>> > static inline void local_bh_disable(void)
>> > {
>> > 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>> >+	lock_map_acquire_read(&bh_lock_map);
>> > }
>> > 
>> > extern void _local_bh_enable(void);
>> >@@ -25,11 +29,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
>> > 
>> > static inline void local_bh_enable_ip(unsigned long ip)
>> > {
>> >+	lock_map_release(&bh_lock_map);
>> > 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
>> > }
>> > 
>> > static inline void local_bh_enable(void)
>> > {
>> >+	lock_map_release(&bh_lock_map);
>> > 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>> > }
>> > 
>> >diff --git a/kernel/softirq.c b/kernel/softirq.c
>> >index 8b41bd13cc3d..17d9bf6e0caf 100644
>> >--- a/kernel/softirq.c
>> >+++ b/kernel/softirq.c
>> >@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
>> > {
>> > 	return from;
>> > }
>> >+
>> >+static struct lock_class_key bh_lock_key;
>> >+struct lockdep_map bh_lock_map = {
>> >+	.name = "local_bh",
>> >+	.key = &bh_lock_key,
>> >+	.wait_type_outer = LD_WAIT_FREE,
>> >+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>> >+	.lock_type = LD_LOCK_PERCPU,
>> >+};
>> >+EXPORT_SYMBOL_GPL(bh_lock_map);
>> 
>> Self-tests are now all passing. Thanks!
>> It looks good to me.
>
>Good! Do you want to continue working on this based on the above
>changes? If so, feel free.

Oh yes, for sure!!
I'll send the next version based on it with the Sebastian's earlier
suggestion included [0].

>Regards,
>Boqun

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/20241220071554.YAD157bS@linutronix.de/
