Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4033F364
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753576; cv=none; b=KSXB6XQCk4pf1f0dkbyQ5kv7NlF0P1akeMd+5PR8CC77BnjdAGp+/CQD8Tog2DTQgJ0WSOP8FIIWW7GNSFKA/skduVp4AZBa8Rv9Q4azbQAcumi6+dgRAA9zuEfHb85YqckyN77qq/RCs+bM9c9PYlfhhxdFi9H+FRcIT223jGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753576; c=relaxed/simple;
	bh=UdtcrtCNprgkfiG6+rMQNa+LXFExZzDDMM4VX1vZhAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEAcCLGZGtiPLnLaX6OeNiAw36qPpBHKF6H6HcfMP2wr9WgXIBGkAbPk0SZ3ZCw58pPzoCcJEka5flXdkLRMehLYYd5nBArHkeTm9XJNf14Bd1irWhH6TU+KQxMnbmYbaFzaTul5uYg4DXlZ2tJ6261IsQKbdopv8kliaBH9tmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHLZLcOT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O79y++7/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHLZLcOT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O79y++7/"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761753572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpKzCdj5qcu3hu84AvpMgxT6khF5giKkPZsqGowQugI=;
	b=cHLZLcOTbZv8HRQsqELn5G6Ko2h6wAZNsLD077VvP8SdRJecFI0ti4NjurbbJfFIJAymPD
	jyzox8bDIVVJK3z2GEqHmqdhznzY+6H9Z54QQ2UZ27Mj7BgpY2oM04YaVcG9wPr32yZ03R
	QNErZLlK5wlpht+0xy4mrFdrxs8yvGt0TrBgrrpii4fuo6UucKRWGyRT5PFfuGR4zVJvRZ
	zKHWVYW8YR+5h5LoC6kExy8QKH/281s/4wijsbYj7G7LBU1dcj8Bnc4QHL0Nj/5pBafNJg
	wTNfFccsppefDDaUbsTM+0L493tUu1FUgwaFhlyYhhWn6Qf+O2PJOCozhe+Qfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761753572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpKzCdj5qcu3hu84AvpMgxT6khF5giKkPZsqGowQugI=;
	b=O79y++7/8kBTiO1CJCsglRL9ggC0z87ZcX5MNw5PG0zQlDaITemDOA8rwnKYMngQLtTZ+N
	8NoPwWaJbhH6llAw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] ARM: Disable FAST_GUP on PREEMPT_RT if HIGHPTE is also enabled.
Date: Wed, 29 Oct 2025 16:59:16 +0100
Message-ID: <20251029155918.503060-4-bigeasy@linutronix.de>
In-Reply-To: <20251029155918.503060-1-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gup_pgd_range() is invoked with disabled interrupts and invokes
__kmap_local_page_prot() via pte_offset_map(), gup_p4d_range().
With HIGHPTE enabled, __kmap_local_page_prot() invokes kmap_high_get()
which uses a spinlock_t via lock_kmap_any(). This leads to an
sleeping-while-atomic error on PREEMPT_RT because spinlock_t becomes a
sleeping spin lock and must not be acquired in atomic context.

The loop in map_new_virtual() uses wait_queue_head_t for wake up which
also is using a spinlock_t.

Limit HAVE_FAST_GUP additionally to remain disabled on PREEMPT_RT with
HIGHPTE enabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e3f93b690f47..864a14a434b08 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -105,7 +105,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) &=
& MMU
 	select HAVE_EXIT_THREAD
-	select HAVE_GUP_FAST if ARM_LPAE
+	select HAVE_GUP_FAST if ARM_LPAE && !(PREEMPT_RT && HIGHPTE)
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_FREGS
--=20
2.51.0

