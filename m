Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE73186E56
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Mar 2025 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143940; cv=none; b=guA1JeT5hnlhl+75wuaftzQiUg9YZ7LpP3vHz8q4BWBt0DLb1s4PuMa2ibfQxB7YhwnifpM7xmW//Ezn1ob5beHXrPo/fOdIa+yvIUbiAdbLw+xiVSrKfcClLoXa+Xrn8eG+uyTQoncjd8LUaBSjNRpyHna/T7T9iD3AzpUYtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143940; c=relaxed/simple;
	bh=htVQ/cFn8gDimJsI774ZgbzxQst76++Dz7pcCkF7/uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6g1dUp8sVKVUQvqiHWrM0KnCU9JpFoFqcZOExQKSumNbXS+bYZo0iiLFOEbbKEO2zFLZU+Vg+sMMpGF6IbXkDoVNaAoCDmK53cox/h3iGaQg3uz/UD3n1stPtM8Y15tkiOPw8GICnTOHOLyskpFt/HCkIsQ6+CsdVzW2eAvAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aztwvUBV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aztwvUBV"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c2303a56d6so686061785a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Mar 2025 19:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143937; x=1741748737; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+smKTbDA0k13UVYSv6ftLrHf0Uww1eKxMUTHXNn3NLI=;
        b=aztwvUBV8raPaSC7fh7Z4nF9vfdHAnmbtqYDCU/YnEFExv58wgcxFUoob2OwpW14AA
         KGQ70+/1yG6kDS6sV2UsYshRgIqwRLL1jzUelL7mASEJaGWBBFuIhieLxjQ3klTbq4JO
         nKnrYrsAKcIJlaAQ4KCRRf50DQjH4kDgCF4VxKCKh8Zxp5uaHjE8VrsXqM+aDL/QAdq4
         IYEZ7s7O3BAo5Fo/4G5rI3OgPESFTskHczM1U31FK8JVoIirzWYVL2SjyS3/EztBfirl
         XHwUDNCId5Wwyd5iHGXLUWPfPNvEvAFssiKHuvEzZ8rZ7mOSDcn1LkvqnpjdMaj7Zw8e
         TXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143937; x=1741748737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+smKTbDA0k13UVYSv6ftLrHf0Uww1eKxMUTHXNn3NLI=;
        b=Z4rIwZCKfDlnusQ+o0d+ty0gkGcrkVhZLrp9KJY8SfqhLlaYZenw8DukXMDX8M7HU3
         LIw5xHAci6F/TKprNq6Dl0MzLpmnziqiUqL7EBa3zmLEE3S1VYUlwUjH81tL6JEBflB3
         ME7hVj8BrYXKfODLK/EfATKh2kD4c5ZT80DHo7y9tNqr/h/LmPsIC/ZcFdbJobu2CvtA
         ZSU7DsSf/aoaf9rIMh8dECa5BA7abUlsQlM0h21Gd9CYzaUITF31CL6DeQ2Kn1CkjhMk
         H+CFFezaGSLRMOXEp4gack2nITrwauwaMOSf40XLndKPpjNv/OIeZeDOT3Mgocu4xRqh
         3owg==
X-Forwarded-Encrypted: i=1; AJvYcCU3v3K2RCQDsurb+onxHKRp+vNfTQJMZCBJeElyfLlDcMGqIlu54mjdb7b1crIUBdRKUFzqr0W3IHfH1BfIpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpOQQMP3DefnBKBAwz39RnUdetSsB2oMbfSOemzmmY3yJC5z/X
	y7SZ9qsYulw7otXlbE8VoLGyk7mzfR+ZyIOu1GJndxqDzHrkJWA8
X-Gm-Gg: ASbGncuKkQLcH6xjE1TtJKptijzVVDheBv8LdoPWO0lArQTKBov63wGUxquMptZNXWS
	E3yEf9yhCf0qPgdklOW4TOf3qhMkHdga2MMtWiOSWbTB5vyWlLvmkIzQB4qjg0Xs+JH22IPcaKx
	FKUXSc3V2CTNkpPkhuZvQ0a/JSQsYKhB8bgviV+QNk3Z+uB1qyp6YBlnpVgmWBZ2BKndJc9Cf7i
	GurZDAmR7s2PSnkShlq4rNpAEEZy4Lc3Z9Zrh+/vovLoEnwcjOOKMUOe8Z9t/Z9GrQs+kGaKIPj
	DND2B7t/PDAFA5ChoyU3XZYXd/oTCi3SdVfHgsylSLp+F2S+omdGjFJ6CGOy32zu8ifI+V5KjKA
	q3wTzFOlgcWmhb4FmaFVGJfjDwwfnw9wkoD0=
X-Google-Smtp-Source: AGHT+IHoVSPzj/lvLcsVS6uwvkqTeZb7BDh933B4bENtWOIJJDtOsAV+fXzGX+/TwWLAUI/Xcxu2+A==
X-Received: by 2002:a05:620a:2720:b0:7c0:bde7:61b1 with SMTP id af79cd13be357-7c3d8ef3766mr251160685a.50.1741143937345;
        Tue, 04 Mar 2025 19:05:37 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8a2170bcasm60554756d6.34.2025.03.04.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:37 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 476B1120006A;
	Tue,  4 Mar 2025 22:05:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 22:05:36 -0500
X-ME-Sender: <xms:gL_HZ2uQhfoBSN-AUCth5YeBh2ctwa6_zsHc7aMptTa8YziZSh0SGg>
    <xme:gL_HZ7e7ON9Uzrx76p1Vs3gNyoAGTnuc5nPioVaUWhvXQh8BjIYIjcyYNx5KHjXW4
    Fv-CCVp3ccK060a2g>
X-ME-Received: <xmr:gL_HZxyv4rlN7D1u_EiwprOY9S0VWGQBr-1_q7yhMXNlHyjIKmAqfOQv-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:gL_HZxMji8lTi4O7-4C_eXI0sYL-lZVrCjWeWczO-aWj2EKE1uWBtQ>
    <xmx:gL_HZ2_FiN0Dw3Db-kAhaBmcRgb1-IU68t0LntX6x3pUyBKHVKjH3w>
    <xmx:gL_HZ5Vm2PlNEbA2oEB7oXmXGV3c6KJFL1tMhYWBvX1Y8B-vxAnIdA>
    <xmx:gL_HZ_ccRwcGpKux16zw3G3cCx2qLqpBA-pFgISboVZQ9LnWBWROXg>
    <xmx:gL_HZwcMsuuhuasD07T0UXzuzaxTuvkEBXGa7UV3uS2N0uBEDuETRGle>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:34 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Yuntao Wang <ytcoode@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Guo Weikang <guoweikang.kernel@gmail.com>,	KP Singh <kpsingh@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	zhangguopeng <zhangguopeng@kylinos.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
	linux-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH rcu 07/10] Flush console log from kernel_power_off()
Date: Tue,  4 Mar 2025 19:05:02 -0800
Message-ID: <20250305030505.94059-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305030505.94059-1-boqun.feng@gmail.com>
References: <20250305030505.94059-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
and shutdown time, which hides shutdown-time RCU issues from rcutorture.
Therefore, make pr_flush() public and invoke it after then last print
in kernel_power_off().

[ paulmck: Apply John Ogness feedback. ]
[ paulmck: Appy Sebastian Andrzej Siewior feedback. ]
[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://lore.kernel.org/r/5f743488-dc2a-4f19-bdda-cf50b9314832@paulmck-laptop
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/printk.h | 6 ++++++
 kernel/printk/printk.c | 4 +---
 kernel/reboot.c        | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..5b462029d03c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b..057db78876cd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2461,7 +2461,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2474,7 +2473,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4466,7 +4464,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b5a8569e5d81..41ab9e1ba357 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
-- 
2.48.1

