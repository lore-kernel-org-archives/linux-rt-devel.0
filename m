Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5634DCD9
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753576; cv=none; b=s2BFVWdhS49FOYXi9NmkY2C/IJskJNnXWjD2Q6k+RwrukhCxlsMCGW8qXbwp/rAL84nk1cAM7bPa0bn0by13fgOzNZqCHnB42zAGkLVOnPPSFcrgsSvZ3aG6ovcstWCi7DZ9FAxxp2cssR9caQnNEdOmEThW1J8vWFggxMDxTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753576; c=relaxed/simple;
	bh=PRY7Lck05eceIVgciJsvkALtjC+ne22v2N2Dx7cNIdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHhzjc8eTmLsEhezMluUN0FsnDGWjs7SUbBaGn8V1c6GHfVyloY+e67gjildW4hBa3r24MQGHwnQyHdA2mPlY3Y/seC4w+/9ud451uQBVNCLCUS6ajKUTb2YO+IZCIOMpQ4KCnv8bAdVuPLoaKpw/f80lpmO7oZX2IMwlH+Yorw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mkp4AK1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Id4IpUJA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mkp4AK1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Id4IpUJA"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761753572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaU7p8ahmNCHaG3kbOaKByvc4PL/i8FOp86ZUuzimbc=;
	b=mkp4AK1g1+nEaFAnxnN1yRX+6h7qNRFVcVUVjjLDUHpS9ftoDSJu3pCrc+zyjiA+PnvR0M
	IglZsC2kkHV3Gecpuz7ishoDUMty+k+eWuQCUXqB4DpknOegstPVtH0nXtFBwjYYjB+j32
	n+0T75Ebr9MAu4H6mNAJVkV0J/ogP77aFbyXoc8bkdGohxUsqHAPMx2kfjRGrhDpCfh/Lx
	hLSb7ANyhwmv9HnGBNpFNQxj4VvPAPyEsvoOpyObnsxLJJhp6jTeP7R6REK2pMTazhxbDG
	rt5eBuqlwXoZ8z5eoYCZmPcPs3DjV2DbGYUBXjPXGKR7DbZ/bMvwJn3IYaqdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761753572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaU7p8ahmNCHaG3kbOaKByvc4PL/i8FOp86ZUuzimbc=;
	b=Id4IpUJAwCLjlI6vtkei4JtSeElAFjBvJxC3clvZE7E/kIGUKhMLCBsrUtHP1ILKIRjGX1
	cIiIehMVq+HV3DDw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] ARM: mm: fault: Enable interrupts before invoking __do_user_fault()
Date: Wed, 29 Oct 2025 16:59:15 +0100
Message-ID: <20251029155918.503060-3-bigeasy@linutronix.de>
In-Reply-To: <20251029155918.503060-1-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Yadi.hu" <yadi.hu@windriver.com>

In the !LPAE case __do_user_fault() is invoked from do_bad_area(). If a
user pointer cause the page fault then a signal is sent.

Sending a signal requires to acquire sighand_struct::siglock which is a
spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
requires interrupts to be enabled. Since the calling context is user
land, interrupts must have been enabled so it is fine to enable them in
this case.

Enable interrupts in do_bad_area() before invoking __do_user_fault().

[bigeasy: Initial patch/ report by Yadi. Maintained the patch and redid
          the patch description since]

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5d28c28e877c1..ad58c1e22a5f9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -218,6 +218,7 @@ void do_bad_area(unsigned long addr, unsigned int fsr, =
struct pt_regs *regs)
 	if (user_mode(regs)) {
 		if (addr >=3D TASK_SIZE)
 			harden_branch_predictor();
+		local_irq_enable();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		__do_kernel_fault(mm, addr, fsr, regs);
--=20
2.51.0

