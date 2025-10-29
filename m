Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EF3469F1
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753577; cv=none; b=ggTJ2f3HEw4NbSQusRPfNBoNSeFCYhgpW9UsMiZSYZRWYcQ5kAW68qyOIfvOa2/bq9KjlwXugGlZ2xfooaz7KYFUvWycVvOQ+JClgXsvnjcVFDqNfrnIE6XlekIIo+QUk6WznjPMF+HcmrP5NQiqIAtB7XlWcdB4/41WiKY2+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753577; c=relaxed/simple;
	bh=Wuffj6cPHPM4A5NwHDCOojJ9ajT2eiEUEeR2TOi076g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1lisOepJWKI3ddBP5xvJ9r7xFJErwiEnEzagBo6n6NA6AyusVZ19L0fN8xoW8nWf27sAvfn5WfUE2rEcIvJXQFT9Bk4D9VPwwu+6FWFRtDQ4JcnilQGBKzojm8h6i/bbMz0uF02T8cWNUtcqrZHXDF6eI1mj2FX+RF1YyouLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jyxf0Doy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5DcaBrpj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jyxf0Doy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5DcaBrpj"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761753573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC8L79/U+jvssoEZEowKKBa9fD4CBt6SS7URdOpJOs8=;
	b=jyxf0DoyAWM0uBiVJk3/r7FuAp0o7Dcf6TS/fvlxBhZsHbWskuYrrFI8pQ7/6BXwlRGLwN
	w1vtAcI1r1mq8qrcE+LJu117TJENkAhNp0XhHHswdPwbQUxoA2DZeMyNCLTwXB3iPdbwa1
	1fwuNEW7hUW+ahlIYi+SzBLsz5SjXJlbnWV0cGUgKyVbdJlSzhsaOsLdeuIJc9B0oovrrb
	0VF4R3P79Fx5b0pVysQZhC6SrZDYTP4X2rAWVWbL1vbTu+/JDRQ6S9NCyAinNF/vRvIYno
	IAazSFizKsmsZN5hamJUNZ2s6HC3KLo7MQz4kOAEPNmVfaud1xUY7RdZ8ieung==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761753573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC8L79/U+jvssoEZEowKKBa9fD4CBt6SS7URdOpJOs8=;
	b=5DcaBrpjhqQrem0X4nGZ4JhLVHn66h9ACqt+0hCSEoF/qscTEl1W0/3gSHMxoTjvJHVAYC
	STwJ3tYTPzO+yEAw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] ARM: Allow to enable RT
Date: Wed, 29 Oct 2025 16:59:18 +0100
Message-ID: <20251029155918.503060-6-bigeasy@linutronix.de>
In-Reply-To: <20251029155918.503060-1-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All known issues have been adressed.
Allow to select RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 99c9b1c320af8..002db8da69ee5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -41,6 +41,7 @@ config ARM
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
@@ -129,6 +130,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
--=20
2.51.0

