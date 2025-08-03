Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DE27F198
	for <linux-rt-devel@lists.linux.dev>; Sun,  3 Aug 2025 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205758; cv=none; b=b1O9Wiu6bIRKozwNhpSt43Te55lc1jcyOdcCsy17wkgG+o69lbc7vu3UoRQnWOuXT2MAn1JnEHzn5zzG+haco9ej0B8Eqod2sMF2PIVd86Lvo6h+fTMwB6M3ho3dpT3wBxXsSQEeEVjSOJwPR0gFCmERJjx92GT4Huh0hfiEs8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205758; c=relaxed/simple;
	bh=a1wPu7qWEqbXSE3m92o14aGzkXL9K+CEYt6wZ0QdWlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGukPVLxfqWD1W6x55ZxLLhCs8ohpcp7wqvAWSZ5FUZmFAE+DEEZAZTb5u4+3/hiJTW/LeeuGjBATV4eWr0OMarZ1ue27kXSS60jPdezLawremDTk+syq07qpIUxcJX708Sfdri9GMOiitkF+QZf4R3DVSoLlOMCNWFeIxz22xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23ff92d05acso7500125ad.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 03 Aug 2025 00:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205755; x=1754810555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jgd1GNOsYadrfuybM239b5t7yZLqoDPXrAoeKpSwNM=;
        b=WkgNjpmmUccFQ4TvqTi0WhKUTfDFkLMQ6/l0AvbKb3pff5Q5TpyJ1H0vDw1ks14/JY
         QRScb/wAzH8STMj6QbrOxjPKdITnZJZh0ErKGya+BGvC9pUdrwWF1j4MPS1pHaMbX2n4
         8NQVmDznSLuqkU7tzeC43O/X6xVZ4XMywOQLJuLU9WQ2ozpLJ2jWhPiLP8P5Fcrjsn6t
         /qnKioFhK4LM/8tHUxxO0rvpoGarptUbw1iWTX/2YSHyxMpI4rq6qZkFqDvP2FDuXvHx
         B5Dc3ZSJGmWTpy/Q/S5oq7nHFWlsr7ns3ULb6wgvd8x5jwOK7MxaUnYDno66JBoCGwcQ
         Ez7w==
X-Forwarded-Encrypted: i=1; AJvYcCVbGHj/0sRDJATL7ym/VuxFsCPFVXaJGsJmDf+oZaw4pu6QiGb0T+btYtwU1udq7eunpJK5HnZ6q3ZjyH8LZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpl7FWDLbzZi7Fss2R8xsyaoxwXSwi8wDkD3SZrTMaeMsCjY6y
	GEBcfad+r7ERHYl7r5avNsKGqEf/08rVO3RZ4/BIrLRrLYJPiJq7YdPc
X-Gm-Gg: ASbGncvAA741XqCfvGjxlqKjKY/lx+kGZlXNzhS3iRv0Baz2sRftL2M5YdurBkOQLIA
	g4sqHSPX96QhUaHiWiPevEEAFX3TcPrkzbV3v/LDK9YFN8YhJjTr7rXK56uz+4WSbUZGkAWg6m4
	Jp1hUE7eWE7j2dJyLPEWPdhgf/kzpc+pAvhC9NVxrxbbkGrfdfxvTyJTy9mjYmjD7+qvn+OKlnM
	W6e+wDHJo1tLOJ7pgbt0JaW4mzpkDix5ye3zjLhBvTyOQy1IrmxF/QGHLqKp1JPhetKVGYCrEYC
	2rRWvdc+fN3nRxySK6oKo2cYsZqh9B3mvf8wdUwdVWdAPi6gyWEpZ/D1eJsrkkaepREw0F98L4w
	Ku15TGg8gOVLH
X-Google-Smtp-Source: AGHT+IEExGu5iIl8dO34DlMWk4OmiF1INIjAC/Q4dK9xAmegQ7x38dfO88DNWfygHfkGxkMXswX2Fw==
X-Received: by 2002:a05:6a20:748c:b0:230:aa8c:f729 with SMTP id adf61e73a8af0-23df8e3d03emr3551485637.0.1754205755356;
        Sun, 03 Aug 2025 00:22:35 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:22:35 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	ppbuk5246@gmail.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH 2/4] kcov: Replace per-CPU local_lock with local_irq_save/restore
Date: Sun,  3 Aug 2025 07:20:45 +0000
Message-ID: <20250803072044.572733-6-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803072044.572733-2-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f85d39dd7ed8 ("kcov, usb: disable interrupts in
kcov_remote_start_usb_softirq") introduced a local_irq_save() in the
kcov_remote_start_usb_softirq() wrapper, placing kcov_remote_start() in
atomic context.

The previous patch addressed this by converting the global
kcov_remote_lock to a non-sleeping raw_spinlock_t. However, per-CPU
data in kcov_remote_start() and kcov_remote_stop() remains protected
by kcov_percpu_data.lock, which is a local_lock_t.

On PREEMPT_RT kernels, local_lock_t is implemented as a sleeping lock.
Acquiring it from atomic context triggers warnings or crashes due to
invalid sleeping behavior.

The original use of local_lock_t assumed that kcov_remote_start() would
never be called in atomic context. Now that this assumption no longer
holds, replace it with local_irq_save() and local_irq_restore(), which are
safe in all contexts and compatible with the use of raw_spinlock_t.

With this change, both global and per-CPU synchronization primitives are
guaranteed to be non-sleeping, making kcov_remote_start() safe for
use in atomic contexts.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 kernel/kcov.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 7d9b53385d81..faad3b288ca7 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -90,7 +90,6 @@ static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
 
 struct kcov_percpu_data {
 	void			*irq_area;
-	local_lock_t		lock;
 
 	unsigned int		saved_mode;
 	unsigned int		saved_size;
@@ -99,9 +98,7 @@ struct kcov_percpu_data {
 	int			saved_sequence;
 };
 
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
 
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -862,7 +859,7 @@ void kcov_remote_start(u64 handle)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_lock_irqsave(&kcov_percpu_data.lock, flags);
+	local_irq_save(flags);
 
 	/*
 	 * Check that kcov_remote_start() is not called twice in background
@@ -870,7 +867,7 @@ void kcov_remote_start(u64 handle)
 	 */
 	mode = READ_ONCE(t->kcov_mode);
 	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/*
@@ -879,7 +876,7 @@ void kcov_remote_start(u64 handle)
 	 * happened while collecting coverage from a background thread.
 	 */
 	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -887,7 +884,7 @@ void kcov_remote_start(u64 handle)
 	remote = kcov_remote_find(handle);
 	if (!remote) {
 		raw_spin_unlock(&kcov_remote_lock);
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	kcov_debug("handle = %llx, context: %s\n", handle,
@@ -912,13 +909,13 @@ void kcov_remote_start(u64 handle)
 
 	/* Can only happen when in_task(). */
 	if (!area) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
-		local_lock_irqsave(&kcov_percpu_data.lock, flags);
+		local_irq_save(flags);
 	}
 
 	/* Reset coverage size. */
@@ -930,7 +927,7 @@ void kcov_remote_start(u64 handle)
 	}
 	kcov_start(t, kcov, size, area, mode, sequence);
 
-	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+	local_irq_restore(flags);
 
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -1004,12 +1001,12 @@ void kcov_remote_stop(void)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_lock_irqsave(&kcov_percpu_data.lock, flags);
+	local_irq_save(flags);
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (!kcov_mode_enabled(mode)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/*
@@ -1017,12 +1014,12 @@ void kcov_remote_stop(void)
 	 * actually found the remote handle and started collecting coverage.
 	 */
 	if (in_serving_softirq() && !t->kcov_softirq) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
-		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -1052,7 +1049,7 @@ void kcov_remote_stop(void)
 		raw_spin_unlock(&kcov_remote_lock);
 	}
 
-	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+	local_irq_restore(flags);
 
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
-- 
2.50.0

