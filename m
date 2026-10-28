Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158341;
	b=D5TkYiLi47BGq7Plcc9dOpjyVoXonfaUMg03seiAvw5sr3NX+AXw20cv9fV0yD63VVLO
	 N6lhLXRwY36iDk318TEZQHn3PUuzaeqZr9JcbogWqAZuqXnPsmxFIWJqO96IDFgH7V8J1
	 9RvbvBbTfenjQX3DPflSvo7Z68Uo0Y1mLzzcJtQTwtJy9JBZ4iwNPmqzARuTAAx6rbYeP
	 QHvQau63dnXmubhk8fZrTVixdc1QM8d0K+KIODfSxEfW23nKGdPv+Y8udeEJvWrW9B0rB
	 7gT6/YIaBvo6XJiEs4WfNUiu8FWlc89V/WRNWfz2hkjTmysbTl6hbskuL+OgmSYLwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZR3iK/21HRL590OT/HWs7TggzA8Gmahp8IuVcPxIo1I=;
	b=b8dYzmbBfkhVPcPrJB5BnpWekJkb5/aH+6lWlGW5XSCMcwZ7fSvpZXtFQFVSZ0HN07b7
	 caEIVdigThmDCBWTlOet0qdG0rRdG56QlsOipfVtu6DB1pHMkroJxeWN5Mryf0p1pxUkx
	 pGDfV+8CiLRlQ4i19UFtB/CRlvCqEXe8aUSrjIsS9EFqBPjoKgHQTcJNL4Cei0zfAzEJm
	 OE0dY4nPc1I8nPgYNO6Dt0ztij8gnP34OqMFe3dCaY+UXfCagInIYyrwrXYy+qovLKzA9
	 GiX1diEuitdPA5a5ffLBmmqOr1LtoQ0MLnqkyFSVbA3I0cb1Jjq9NSF/kxTr2BfktIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pYewvRJo;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A5606A33C
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 03:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5A5606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pYewvRJo
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so9950165e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Oct 2026 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158340; x=1793763140; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZR3iK/21HRL590OT/HWs7TggzA8Gmahp8IuVcPxIo1I=;
        b=pYewvRJo2ad9DvGMM8vBMzuDVLbtjFgeMpstmyaDKVWPbWbvmk7z/IA/K7nW8FBjaC
         nT9WBD1/fcGC4sSwjawbLjfywKxuU27JlHJhM/UQuRA0UMCejNgw6lSJ0up+US885sEq
         TFlGzzzaH9QAGmmmL4ts8XdCSmsKdZdc82J3xiODfT16dVHVM5kD34091PvL/s05QyMj
         LRJ4rAyBp3spJFoXbT2UY8O5MxAiSw1SuihpUjNV3crvzyy6PVk/RFq9XyWHDwyC8E11
         JfSXJhe1zmur2MKE/DKoqfjOQvt9EAnvS3yTfdIWasGlCDXbSk2YRVRAs80Q7LqlOWDX
         Namw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158340; x=1793763140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZR3iK/21HRL590OT/HWs7TggzA8Gmahp8IuVcPxIo1I=;
        b=uCPYhu9OcRYIDk3DwW+zXEgvJnr7xCivZdIgpZjn1xmKwx5wVqJGa7jsRUdd4LFTDd
         tsFd7vJgP4+7pvFLT5TNFjLq2stLBhbxs2WxS0n38QW7UNSA2kGObQnrgaQMvgrcfJ5j
         8BkS9a8aY+zkqQ7a+Kbqf2jDXligjGtJYZAtUNtdP1ZmAmMRZVr45U/Jee03cVSYnUlp
         9OLyHe5YK7I55bR+FYkhCvLnLn4aZm8dkUbdNMiVveL8k/C/yzfbJemKHkCT2zBYqy86
         mD6NeiSzZVAQcLsPGWupOcfbpPZbGuVqWSk5zOfG6TkLFWG8xs4Qbjfq/VWX93RC3SGh
         CnGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLu+bfbiKF7cfVKzKQ6b4THozUnAUP0vyTtDmvaOlgZTPg4Sp8Nf8xx/rN6ymJ726qvWDA0uvxTAYIIBsEng==@lists.linux.dev
X-Gm-Message-State: AFq9FYJWz+tcCOw8YdhWnNJwKGAwdFfZLvqmRn6NOqXuPKiqbPYZuXIF
	GJ7wYbqufZllxeRmmx756+E/iPZ8nzDzUzEml8knMXIWgfxxdX2XRrVX
X-Gm-Gg: AYBFou1cHWBCqEndv+A64Ig10PfsYC7UJkkfjSU9BIlOhuTxL9D5e/DVKdonKuqV7/M
	Y/58TY+QbfRJk4MJ486Cni18P9SzsmVo0njxjN56uMHoD1b27aeK+HbMbEKw8IuMRSk/PztdWB3
	cZGEVWBNjbnvSKrZSJmlx6OcjXlx2WCC7BHpgnNpvtdvfXqugLHGTOrW7ofIg/xmlJg1pLTI29O
	lXf9Wb/dAl2xed1Ey43hicWh3VHg7V1BI3JPa3NiTaoVCpi+u/TKJ7g2Nvc3MOz5Hz3DgkNAiIk
	KtdR+x7xmP4NyM01HBV7/llCCXPQg5Zgpcy2mpZ0puVtRxDvFWhqi3XbJP7o9i3IyLL+8YoNMyZ
	wgbIcDoiM6bo7EGmKrBYBvhcp2faLGKgaRYdEQjeiSC2ysACM6Hl9Kchp2TGsoZQunkofYMR1dl
	oyfmJW+1fcoL3E0Q/TZqq23XzZQLoTjp6CIy2FeRPfUUDbWodQ0aI+G1KNHA9c4ESb7Y5W3lT7j
	EjjmIo7ur1F/XiY4ZbNp3p9VtXaYcSZ7uYKaXlil5sVILhd7RPwhvrvzb1rQ7neue5/JVaCMTgc
	oe0sxqap6ZCLPlU/icgtJagZuUwBbTKg8Ywynnkhi/ZUDeiH9lpFujvIKimbA0+JuFPmvqVzawm
	v0zK4hTt/OnYgp1g/Xvtnclsll3YZgmPUxuvpav1GH+tVWpQNyvvADaFpfmNJhAEjCAY8QDeivX
	v3ZPGBNVhSUF5xxddCUgWLjA3lKvVNyF6F
X-Received: by 2002:a05:600d:8641:20b0:4a2:10d:5e0d with SMTP id 5b1f17b1804b1-4a7c58f389cmr88355155e9.14.1793158339700;
        Tue, 27 Oct 2026 20:32:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm24290569f8f.56.2026.10.27.20.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 20:32:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 13/13] locking/selftest: Exercise hardirq return-tail preparation
Date: Wed, 28 Oct 2026 04:31:27 +0100
Message-Id: <20261028033127.82193-14-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261028033127.82193-1-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return-tail lockdep preparation must see a live hardirq context. A zero
depth must fail. Depth one and nested contexts must pass. The ordinary
preparation helper must continue to reject a live hardirq context.

Add focused boot-time lockdep cases for those four states. Skip the final
IRQ-state transition after an expected preparation failure so that each
failure remains attributable to the preparation invariant.

Assisted-by: LLM
---
 lib/locking-selftest.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index c3d976c801bb4..7e26b757344a4 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -222,6 +222,55 @@ static void init_shared_classes(void)
 		local_irq_enable();		\
 		local_bh_enable();
 
+static void irqtail_prepare_test_enter(unsigned int nr)
+{
+	unsigned int i;
+
+	local_irq_disable();
+	for (i = 0; i < nr; i++)
+		__irq_enter_raw();
+	trace_hardirqs_on_prepare();
+}
+
+static void irqtail_prepare_test_exit(unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++)
+		__irq_exit_raw();
+	if (debug_locks)
+		lockdep_hardirqs_on(_THIS_IP_);
+	raw_local_irq_enable();
+}
+
+static void prepare_irqtail_0(void)
+{
+	irqtail_prepare_test_enter(0);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(0);
+}
+
+static void prepare_irqtail_1(void)
+{
+	irqtail_prepare_test_enter(1);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(1);
+}
+
+static void prepare_irqtail_2(void)
+{
+	irqtail_prepare_test_enter(2);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(2);
+}
+
+static void prepare_regular_1(void)
+{
+	irqtail_prepare_test_enter(1);
+	lockdep_hardirqs_on_prepare();
+	irqtail_prepare_test_exit(1);
+}
+
 /*
  * Shortcuts for lock/unlock API variants, to keep
  * the testcases compact:
@@ -2934,6 +2983,10 @@ void locking_selftest(void)
 	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
+	DO_TESTCASE_1B("IRQ tail prepare", prepare_irqtail, 0);
+	DO_TESTCASE_1("IRQ tail prepare", prepare_irqtail, 1);
+	DO_TESTCASE_1("IRQ tail prepare", prepare_irqtail, 2);
+	DO_TESTCASE_1B("regular IRQ prepare", prepare_regular, 1);
 
 	ww_tests();
 
-- 
2.39.5 (Apple Git-154)

