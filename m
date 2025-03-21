Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A111A256B
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Mar 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567609; cv=none; b=RDOU7mn9J9lGdBzrChy5EAt4qEM7XMAeTVockZcKvlCQfuGNwuk9v04F6DjfEbmxsrdxd5i/sLQygy4tj0pUuuo00/oMB9uEDRgSoxfaNfJbnQFLFvsY8mHALwGhZh2iUmm4E7snFIoMeOdnZUgyqB8gARgjRLO79K0RdpGeBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567609; c=relaxed/simple;
	bh=2wTKV/U4BoU5bDZ58CDBxB00ghO6JtVFoCtJ0yPHlX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LLm3/r7Ri2jpdzG3LcYNou5+3KgT2TSyolLhsVrEAzTuciXG18iY8f75wObF9a7q+mIb+6WecINTvUzt9PZXxvBiLQ4Oustvzq5bhThju5CjoTeQpWyliCsvdoONw9wfspk7gX39IXh5KrwRzRAwTG1bUW7de24Yrd5TPMLkv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvNzff5d; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvNzff5d"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47692b9d059so27763161cf.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 21 Mar 2025 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742567607; x=1743172407; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zq/g0IqGpYRLJ2prWs3RnuRl8aHTSbproF6Pc3o+u6Q=;
        b=UvNzff5dg6tiAYUo3TlugI32/vqp8j9UPO8KlV9KHCbd/Al5zlkqWQgJqZAEeJIN4g
         ZhE25vovsL1d8k98U8HnqmVyWfraaTyN6FNzvfaA4sxPMp0/i/89CFtQiIgl+jeoh6Ug
         py072ZB12ZhJrjRqE/vwbrv/N0PmiALMGOklkpNc+wiC9SCHMS2Ay0J/8G3BPSfzN4ZH
         89SDZDCEuJCp0yT2UG/cJzxYDORXIKjhm118uGZ+wqUqc0T28KLeWdxipUuZakRUQpJC
         C6p2MFqSgt4zneydfIqvxW2Lg89E1UzIzi9tsM7W3T3kGRMqdyZa6KTH9A3SJCMX0gXC
         V2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567607; x=1743172407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq/g0IqGpYRLJ2prWs3RnuRl8aHTSbproF6Pc3o+u6Q=;
        b=ewRVIL9TjjjT0SqGJGfL+JGu2wbHAyPRTuj4lgjL5LP6EncLuzju1dY64I4Tpg9STo
         4xsxYL01DyDtjZDx7OTvciD95NTBnv0yLhkc4rdxcWjB03NODOdQ0YOLf8yo+SkM3Ut9
         W+MJXPYJfUHNzvz6tLz6DQyAUuTqRSWHHpZ5rBwosMPpI2TsaiJwsGc+Tzd7r6LzkSWJ
         lswsJLLK82JtSBYLkLxjxd/jabvVF+g7b3b6msQpRvMnFlI9KEWzABBBoQWmkbTQ534T
         oiayfg/tk2inNwRSj1aJTHohfXekXG59EwinPr9Vs/ILbEHyBeE88sh8jJjL/ew/tIHp
         NL1A==
X-Forwarded-Encrypted: i=1; AJvYcCVFQIS8CZvFzHWC4IDyoW7kOIecyksC+YM1ilJpJZKq88u0s7RL7YWosjLU7v7aMhzHz+n2xCAo43n+y5TKqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHIU92of0z686ZT2eURH+/B/kK/hdTbjcow14/d0WfojI3K1sD
	BcSboZV5JE2VfmoDXRlVIO/3EPvhV/f8hpooGvvXrMwtkJfJNSKF
X-Gm-Gg: ASbGncvdzHZGgsHdqY7bypBPtGFfe0db4nkRG7Tj6ypkMV4gq0huyx5yGb9kZ7AyJWi
	PnCMnthks09Gt7M9p1Jij7w+3ROKqf3z+FHEqHGKT4ObV5PMDVUBBKRhh/p5ja5nc3vmVwVPGyf
	kIMGKVe5HkqHqOEqQcA2jmVMuQVUnwuEI9g6+y3JWrWrUoXogav7Revb6DSeEglxqgE0jCZym/0
	/xo2iKn7y3Um1L4xs9zp/4H/vK+N6c8iNgbosNS390YRr8FrY0ASzaOS7bupA5Zq1W+FV1Y6q47
	qN9CrxNaF11bcCgTbvgb4aJDdsljb0RcPra8WabSdPWaPfHP2y51QlDtEwFTmMA2thOZ5PeXuwf
	k86QJAFsG8UbslhBD/bXJHQY59N4kpHFjVog=
X-Google-Smtp-Source: AGHT+IGkloBWswAdwzKFDcuLz2onq1qu5s8QqoSyvZvIXW5EfoMJyNCL23TTnMYUSweCV5XWbGphLg==
X-Received: by 2002:a05:6214:1bc7:b0:6e8:f770:5045 with SMTP id 6a1803df08f44-6eb3f34b479mr53093746d6.28.1742567606895;
        Fri, 21 Mar 2025 07:33:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efdc1b1sm11667136d6.110.2025.03.21.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:33:26 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id D403E1200043;
	Fri, 21 Mar 2025 10:33:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Mar 2025 10:33:25 -0400
X-ME-Sender: <xms:tXjdZ10WtFGnauFShwRkg40hWqgUWgnmX4q1O9QjxKoRC7oB7pwSgg>
    <xme:tXjdZ8EvdyGXA6RlvPlRms5KjsCMtDsWLMIjX_nwvvjTfyIy24Ga4xVuzcvcd0cC6
    wfuZhIDUqbIvFaRpQ>
X-ME-Received: <xmr:tXjdZ14T86_zIiUuTkl9xTTtYWy6476lPeg2tDaQIRfRMqPqc83nQU07>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeggeeukeeghfevudektdevjeehhfekffevueef
    udeivdelteeltdekheejgfeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlhhrkhif
    lhhlmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoug
    hmihhsrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhr
    tghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepph
    gruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhn
    vghlrdgukhdprhgtphhtthhopehrhihothhkkhhrleeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgvihhlsgesshhushgvrdguvg
X-ME-Proxy: <xmx:tXjdZy0fcfHTQwgEHHGsWjP-_uvKZt0XTDV491lFK5JpvDGp0UduDQ>
    <xmx:tXjdZ4F47G6KOHhRKMBIz05nfVfGRQzlZt9M8CWmihAoDXlDa4uTwA>
    <xmx:tXjdZz_RxSRPOxTkynsBV7fzeL4hc1sFq3AyPBwHdeHqhNB88cio6A>
    <xmx:tXjdZ1lD6lx6F86EGk1w0nRe7gGOrctZDPrSgsluUMRs1Ehqv9BOXA>
    <xmx:tXjdZ8Fv_VQ-PEc4XBfyIFd3YR9b2l4qkzK-17WaQNkuIF9Yyz4obwMH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 10:33:25 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v4] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Fri, 21 Mar 2025 07:33:22 -0700
Message-Id: <20250321143322.79651-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
PREEMPT_RT."), the wait context test for mutex usage within
"in softirq context" fails as it references @softirq_context.

[    0.184549]   | wait context tests |
[    0.184549]   --------------------------------------------------------------------------
[    0.184549]                                  | rcu  | raw  | spin |mutex |
[    0.184549]   --------------------------------------------------------------------------
[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|

As a fix, add lockdep map for BH disabled section. This fixes the
issue by letting us catch cases when local_bh_disable() gets called
with preemption disabled where local_lock doesn't get acquired.
In the case of "in softirq context" selftest, local_bh_disable() was
being called with preemption disable as it's early in the boot.

[boqun: Move the lockdep annotations into __local_bh_*() to avoid false
positives because of unpaired local_bh_disable() reported by Borislav
Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
PREEMPT_RT]

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
---
v3 -> v4:

*	Move the dummy lockdep_map (for detection) to PREEMPT_RT only.

v3: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com

I would need a tag from RT to send it for v6.16, please take a look,
thanks!

 kernel/softirq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4dae6ac2e83f..3ce136bdcbfe 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -126,6 +126,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name = "local_bh",
+	.key = &bh_lock_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type = LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -148,6 +160,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	WARN_ON_ONCE(in_hardirq());
 
+	lock_map_acquire_read(&bh_lock_map);
+
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
@@ -211,6 +225,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
+	lock_map_release(&bh_lock_map);
+
 	local_irq_save(flags);
 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
@@ -261,6 +277,8 @@ static inline void ksoftirqd_run_begin(void)
 /* Counterpart to ksoftirqd_run_begin() */
 static inline void ksoftirqd_run_end(void)
 {
+	/* pairs with the lock_map_acquire_read() in ksoftirqd_run_begin() */
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable(SOFTIRQ_OFFSET, true);
 	WARN_ON_ONCE(in_interrupt());
 	local_irq_enable();
-- 
2.39.5 (Apple Git-154)

